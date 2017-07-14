open HWData;;
open HWLib;;
open SMapData;;
open Util;;
open SolverData;;
open MathData;;

open IntervalLib;;
open IntervalData;;

open Z3Data;;
open Z3Lib;;

open ScipyOptimizeData;;
open ScipyOptimizeLib;;

open SMapHwConfigGen;;
open SMapData;;
open SMapSolverData;;
open Z3SMapSolver;;
open ScioptSMapSolver;;


                        
let string_of_cfggen_mapvar = SMapCfggenCtx.string_of_mapvar;;



exception SMapSolver_error of string

module SMapSolver =
struct

 
    let map_var_to_xid_var : mapslvr_ctx -> hwcompinst -> map_var -> int =
    fun ctx inst vr ->
      let name = string_of_cfggen_mapvar {comp=inst;mapvar=vr} in
      if MAP.has ctx.varmap name then
        MAP.get ctx.varmap name
      else
        raise (SMapSolver_error ("not found:"^name))

  

  let decl_var : mapslvr_ctx ->int -> hwcompinst -> map_var -> int =
    fun ctx varid inst mapvar ->
      let curr_decls = if MAP.has ctx.xidmap varid 
        then MAP.get ctx.xidmap varid else []
      in
      let new_decl : cfggen_mapvar = {comp=inst;mapvar=mapvar} in
      let name = string_of_cfggen_mapvar new_decl in
      (*only add the mapping if it doesn't exist already, and is not
      already mapped to an xid*)
      if LIST.has curr_decls new_decl = false &&
         MAP.has ctx.varmap name = false
      then
        begin
          Printf.printf("[slvr] -> decl %s\n") name;
          noop (MAP.put ctx.varmap name varid);
          noop (MAP.put ctx.xidmap varid (new_decl::curr_decls));
          varid
        end
      else
        begin
          let idx = MAP.get ctx.varmap name in
          Printf.printf("[slvr] -> get %s -> %d\n") name idx;
          idx
        end

  let max_xid : mapslvr_ctx -> int =
    fun ctx ->
      let _,curr_id =
        LIST.max float_of_int (MAP.keys ctx.xidmap)
      in
      curr_id

  let map_expr_to_xid_expr : mapslvr_ctx -> hwcompinst -> map_expr -> map_expr =
    fun ctx inst expr ->
      let rec _compute : map_expr -> map_expr =
        fun e -> match e with
          | SEVar(SMFreeVar(v)) ->
            let freevar_id = (max_xid ctx) + 1 in
            let act_var = decl_var ctx freevar_id inst (SMFreeVar v) in
            SEVar(SMFreeVar(act_var))

          | SEVar(v) ->
            SEVar(SMFreeVar(map_var_to_xid_var ctx inst v))

          | SENumber(n) -> SENumber(n)
          | SEAdd(a,b) -> SEAdd(_compute a, _compute b)
          | SESub(a,b) -> SESub(_compute a, _compute b)
          | SEMult(a,b) -> SEMult(_compute a, _compute b)
          | SEDiv(a,b) -> SEDiv(_compute a, _compute b)
          | SEPow(a,b) -> SEPow(_compute a, _compute b)
      in
      _compute (expr)

 
    
  
  let convert_mapvar_graph_to_xid_graph : mapslvr_ctx -> cfggen_ctx -> unit=
    fun slvr_ctx ctx ->
      let bin_set = GRAPH.disjoint ctx.bins in
      Printf.printf "[slvr] === Declaring Vars ====\n";
      List.iteri (fun (i:int) (bins:cfggen_bin set) ->
          SET.iter bins (fun (bin:cfggen_bin) ->
              match bin with
              | SMBMapVar(inst,varname) ->
                noop (decl_var slvr_ctx i inst varname)
              | _ -> ()
            )
        ) bin_set;
      Printf.printf "[slvr] === Constructing XID Graph ====\n";
      (*convert to exprs, merging as you go*) 
      let new_graph = GRAPH.map_nodes ctx.bins slvr_ctx.bins.node2str
          (fun (bin:cfggen_bin)  ->
             match bin with
             | SMBMapExpr(inst,e) ->
               SMVMapExpr(map_expr_to_xid_expr slvr_ctx inst e)

             | SMBMapVar(inst,varname) ->
               let xid = map_var_to_xid_var slvr_ctx inst varname in
               SMVMapVar(xid)

             | SMBNumber(n) ->
               SMVMapExpr(SENumber(n))

             | SMBTimeConstant -> SMVTimeConstant
          )
      in
      GRAPH.destroy slvr_ctx.bins;
      slvr_ctx.bins <- new_graph;
      Printf.printf "[slvr] === Constructing Contraints ====\n";
      MAP.iter ctx.cstrs (fun wire cstrs ->
          let inst = wire.comp in
          LIST.iter (fun cstr ->
              Printf.printf "  cstr: %s\n" (SMapCstr.to_string cstr);
              match cstr with
              | SCExprNeqConst(me,n) ->
                begin
                  let xidexpr = (map_expr_to_xid_expr slvr_ctx inst me) in
                  let xidexpr_bin = SMVMapExpr(xidexpr) in
                  let neq_bin = SMVNeq(xidexpr,n) in
                  if GRAPH.hasnode slvr_ctx.bins neq_bin = false then
                    noop (GRAPH.mknode slvr_ctx.bins neq_bin);
                  GRAPH.mkedge slvr_ctx.bins xidexpr_bin neq_bin ();
                  ()
                end
                
              | SCVarNeqConst(mv,n) ->
                begin
                  let xidvar = (map_var_to_xid_var slvr_ctx inst mv) in
                  let xidvar_bin = SMVMapVar(xidvar) in
                  let neq_bin = SMVNeq(SEVar (SMFreeVar xidvar), n) in
                  if GRAPH.hasnode slvr_ctx.bins neq_bin = false then
                    noop (GRAPH.mknode slvr_ctx.bins neq_bin);
                  GRAPH.mkedge slvr_ctx.bins xidvar_bin neq_bin ();
                  ()
                end
                
              
              | SCCoverInterval(hwival,mival,SEVar sc,SEVar off) ->
                begin
                  let sc_xid = (map_var_to_xid_var slvr_ctx inst sc) in
                  let off_xid = (map_var_to_xid_var slvr_ctx inst off) in
                  SET.add slvr_ctx.sts (SMVCover(sc_xid,off_xid,hwival,mival));
                  ()
                end

              | SCTrue -> () 
              | SCFalse -> slvr_ctx.success <- false 
              | SCCoverTime(min,max) ->
                begin
                  let cstr_bin = SMVCoverTime(min,max) in
                  if GRAPH.hasnode slvr_ctx.bins cstr_bin = false then
                    noop (GRAPH.mknode slvr_ctx.bins cstr_bin);
                  if GRAPH.hasnode slvr_ctx.bins SMVTimeConstant then
                    noop (GRAPH.mkedge slvr_ctx.bins SMVTimeConstant cstr_bin);
                  ()
                end
              | _ -> ()
          ) cstrs
      );
    (*remove any nodes that are not being exported*)
    MAP.iter ctx.export (fun bin export ->
        if export = false then
          begin
            let to_remove = match bin with
              | SMBMapExpr(inst,e) ->
                SMVMapExpr(map_expr_to_xid_expr slvr_ctx inst e)
              | _ ->
                raise (SMapSolver_error "unexpected: must export var")
            in
            if GRAPH.hasnode slvr_ctx.bins to_remove then
              begin
                let other = List.nth (GRAPH.connected slvr_ctx.bins to_remove) 0 in
                Printf.printf "repl %s with %s\n"
                  (SMapSlvrCtx.string_of_bin to_remove)
                  (SMapSlvrCtx.string_of_bin other);
                GRAPH.merge new_graph other to_remove 
              end
          end
      )


  let remap_xid_graph : mapslvr_ctx -> unit =
    fun ctx ->
      let remap = MAP.make () in
      let max_remap () =
        let _,v =LIST.max float_of_int (MAP.to_values remap) in
        v
      in
      let bin_set = GRAPH.disjoint ctx.bins in
      List.iteri (fun (i:int) (bins:mapslvr_bin set) ->
          SET.iter bins (fun (bin:mapslvr_bin) ->
              match bin with
              | SMVMapVar(old_i) ->
                noop (MAP.put remap old_i i)
              | _ -> ()
            )
        ) bin_set;
      MAP.iter ctx.xidmap (fun (i:int) _ ->
          if MAP.has remap i then () else
            noop (MAP.put remap i (max_remap() + 1))
        );
      raise (SMapSolver_error "unimpl")
        
        


  
  let print_slvr_bins : mapslvr_ctx -> unit =
    fun ctx ->
      let disjoint = GRAPH.disjoint ctx.bins in
      Printf.printf "=== SOLVER CTX ==";
      List.iteri (fun d bset ->
          Printf.printf "--- Bin %d ---\n" d;
          SET.iter bset (fun bin ->
              Printf.printf "%s\n" (SMapSlvrCtx.string_of_bin bin)
            );
          Printf.printf "---------\n"
        ) disjoint

  let build_linmap_transform : (string,mid) sln -> map_hw_spec -> (int,cfggen_mapvar list) map
    -> (int,float) map -> (wireid, linear_transform) map =
    fun sln mapspec mapper asgns ->
      let wire_to_mapping : (wireid,linear_transform) map = MAP.make () in
      MAP.iter mapper (fun xid (mapvars:cfggen_mapvar list) ->
          List.iter (fun (var:cfggen_mapvar) ->
              let wire_maybe  = match var.mapvar with
                | SMScale(port) ->Some (mkwire var.comp.name var.comp.inst port)
                | SMOffset(port) -> Some (mkwire var.comp.name var.comp.inst port)
                | _ -> None
              in
              let value = MAP.get asgns xid in
              match wire_maybe with
              | Some(wire) ->
                let linear_trans :linear_transform= if MAP.has wire_to_mapping wire 
                  then MAP.get wire_to_mapping wire else {scale=1.0;offset=0.0}
                in
                begin
                  match var.mapvar with
                  | SMScale(_) -> linear_trans.scale <- value 
                  | SMOffset(_) -> linear_trans.offset <- value
                end;
                noop (MAP.put wire_to_mapping wire linear_trans)

              | None -> ()

            ) mapvars
        );
      SET.iter sln.comps (fun (inst:hwcompinst) ->
          let spec : map_comp = MAP.get mapspec.comps inst.name in
          MAP.iter spec.inputs (fun port _ ->
              let wire : wireid = {comp=inst;port=port} in
              if MAP.has wire_to_mapping wire = false then
                noop (MAP.put wire_to_mapping wire {scale=1.0;offset=0.0})
            );
          MAP.iter spec.outputs (fun port _ ->
              let wire : wireid = {comp=inst;port=port} in
              if MAP.has wire_to_mapping wire = false then
                noop (MAP.put wire_to_mapping wire {scale=1.0;offset=0.0})
            )
        );
      Printf.printf "=== Mappings ===\n%s\n=======\n"
        (SLinearTransform.map_to_string wire_to_mapping);
      wire_to_mapping

  let validate_model : int -> mapslvr_ctx -> (int,float) map -> bool*(int,float) map =
    fun compute_time slvr_ctx stdmodel ->
      let z3prob = Z3SMapSolver.slvr_ctx_to_z3_validate slvr_ctx stdmodel in
      let mapsln : z3sln = Z3Lib.exec "mapver" z3prob compute_time true in
      match mapsln.model with
      | Some(model) -> true,Z3SMapSolver.get_standard_model model
      | None -> false,stdmodel
        
  let cfggen_ctx_to_sln : gltbl -> cfggen_ctx -> int -> (wireid,linear_transform) map option =
    fun tbl ctx compute_time ->
      let slvr_ctx = SMapSlvrCtx.mk_ctx () in
      convert_mapvar_graph_to_xid_graph slvr_ctx ctx;
      print_slvr_bins slvr_ctx;
      (*reduce_xid_graph slvr_ctx ctx;*)
      if slvr_ctx.success = false then
        None
      else
        let mapping = slvr_ctx.xidmap in
        let solver = Globals.get_glbl_string "jaunt-solve-method" in
        match solver with
        | "smt" ->
          begin
            let z3prob=  Z3SMapSolver.slvr_ctx_to_z3 slvr_ctx in
            let mapsln : z3sln = Z3Lib.exec "map" z3prob compute_time true in
            match mapsln.model with
            | Some(model) ->
              let stdmodel = Z3SMapSolver.get_standard_model model in
              Some (build_linmap_transform tbl.sln_ctx tbl.map_ctx mapping stdmodel)
            | None -> None
          end

        | "scipy" ->
          begin
            let scipy_prob = ScioptSMapSolver.to_scipy slvr_ctx in
            let mapsln : sciopt_result = ScipyOptimizeLib.exec "map" scipy_prob compute_time in
            match mapsln.vect with
            | Some(model) ->
              begin
                let stdmodel = ScioptSMapSolver.get_standard_model model in
                let is_valid,accmodel =
                  validate_model compute_time slvr_ctx stdmodel
                in
                if is_valid then
                  Some (build_linmap_transform tbl.sln_ctx tbl.map_ctx mapping accmodel)
                else
                  None
              end

            | None -> None
          end

  let compute_transform : gltbl ->  cfggen_ctx -> int ->
    (wireid, linear_transform) map option=
    fun tbl ctx compute_time ->
      cfggen_ctx_to_sln tbl ctx compute_time
      
  let compute_transform_exists : gltbl -> cfggen_ctx -> int -> bool =
    fun tbl ctx compute_time ->
      (cfggen_ctx_to_sln tbl ctx compute_time) <> None
      
end
