open Util;;

open SMapHwConfigGen;;
open SMapData;;
open SMapSolverData;;

open Z3Data;;
open Z3Lib;;

open HWData;;
open HWLib;;
open MathData;;


exception Z3SMapSolver_error of string
module Z3SMapSolver =
struct

  let rec xid_to_z3_var : int -> string =
    fun idx ->
      "x"^(string_of_int idx)

  let z3_var_to_xid : string -> int =
        fun name ->
          int_of_string (STRING.removeprefix name "x")

  let rec xid_expr_to_z3_expr : map_expr -> z3expr =
    fun expr -> match expr with
      | SEVar(SMFreeVar(idx)) -> Z3Var(xid_to_z3_var idx)
      | SENumber(i) -> Z3Number(i)
      | SEAdd(a,b) -> Z3Plus(xid_expr_to_z3_expr a, xid_expr_to_z3_expr b)
      | SESub(a,b) -> Z3Sub(xid_expr_to_z3_expr a, xid_expr_to_z3_expr b)
      | SEMult(a,b) -> Z3Mult(xid_expr_to_z3_expr a, xid_expr_to_z3_expr b)
      | SEDiv(a,b) -> Z3Div(xid_expr_to_z3_expr a, xid_expr_to_z3_expr b)
      | SEPow(a,b) -> Z3Power(xid_expr_to_z3_expr a, xid_expr_to_z3_expr b)

  let number_to_z3_expr : number -> z3expr =
    fun num -> match num with
      | Integer(i) -> Z3Number(Integer i)
      | Decimal(i) -> Z3Number(Decimal i)

  let z3st_decl_xid : int -> cfggen_mapvar list -> z3st list =
    fun idx mappings ->
      let varname = xid_to_z3_var idx in
      let decl = Z3ConstDecl(varname , Z3Real) in
      let s_max_float = 1e10 in
      let s_min_float = 1e-100 in
      let not_too_large =
        Z3Assert(Z3And(
            Z3LTE(Z3Var varname,Z3Number(Decimal s_max_float)),
            Z3GTE(Z3Var varname,Z3Number(Decimal (0.-.s_max_float)))
          ))
      in
      let comment =
        Z3Comment(LIST.tostr SMapCfggenCtx.string_of_mapvar ", " mappings)
      in
      (*not part of constraint problem.*)
      Z3Comment("")::comment::decl::not_too_large::[]

  let cover_cstr_to_z3 : int->int-> map_range -> map_range -> z3st list =
    fun scale_xid offset_xid hwival mival ->
      let scvar = Z3Var (xid_to_z3_var scale_xid) in
      let ofvar = Z3Var (xid_to_z3_var offset_xid) in
      let hmin =  number_to_z3_expr hwival.min
      and hmax = number_to_z3_expr hwival.max in
      let mmin =  number_to_z3_expr mival.min
      and mmax = number_to_z3_expr mival.max in
      if not (NUMBER.eq mival.min mival.max)  then
        begin
          let max_cover =
            Z3And(
              Z3LTE(Z3Plus(Z3Mult(scvar,mmax),ofvar),hmax),
              Z3GTE(Z3Plus(Z3Mult(scvar,mmax),ofvar),hmin)
            )
          in
          let min_cover =
            Z3And(
              Z3LTE(Z3Plus(Z3Mult(scvar,mmin),ofvar),hmax),
              Z3GTE(Z3Plus(Z3Mult(scvar,mmin),ofvar),hmin)
            ) 
          in
          Z3Comment("cover cstr")::Z3Assert(min_cover)::Z3Assert(max_cover)::[]
        end
        
      else
        begin
          let num_cover =
            Z3And(
              Z3GTE(Z3Plus(Z3Mult(scvar,mmin),ofvar),hmin),
              Z3LTE(Z3Plus(Z3Mult(scvar,mmax),ofvar),hmax)
            ) 
          in
          Z3Comment("cover cstr")::Z3Assert(num_cover)::[]
        end
                

  
  let time_cstr_to_z3 : z3expr -> number option -> number option -> z3st list =
    fun expr tmin_maybe tmax_maybe ->
        begin
          match tmin_maybe, tmax_maybe with
          | Some(tmin),Some(tmax) ->
            Z3Comment("time cstr")::
            Z3Assert(Z3LTE(expr,number_to_z3_expr tmax))::
            Z3Assert(Z3LTE(number_to_z3_expr tmin,expr))::
            []


          | Some(tmin),None ->
            Z3Comment("time cstr")::
            Z3Assert(Z3LTE(number_to_z3_expr tmin,expr))::
            []

          | None,Some(tmax) ->
            Z3Comment("time cstr")::
            Z3Assert(Z3LTE(expr,number_to_z3_expr tmax))::
            []

          | None,None -> [] 
        end


  let slvr_ctx_to_z3 : (mapslvr_ctx) -> (z3st list) =
    fun slvr_ctx ->
      let decls = QUEUE.make() in
      let cover = QUEUE.make() in
      let time_cover = QUEUE.make() in
      let equals = SET.make_dflt() in
      let not_equals = SET.make_dflt() in
      let bin_set = GRAPH.disjoint slvr_ctx.bins in
      MAP.iter slvr_ctx.xidmap (fun id mappings ->
          noop (QUEUE.enqueue_all decls (z3st_decl_xid id mappings));
        );
      List.iter (fun (bins:mapslvr_bin set) ->
          let is_tc = REF.mk false in
          let cls :z3expr list = SET.fold bins (fun bin rest -> match bin with
              | SMVMapVar(id) ->
                (Z3Var(xid_to_z3_var id))::rest
                
              | SMVMapExpr(mapexpr) ->
                (xid_expr_to_z3_expr mapexpr)::rest
                
              | SMVTimeConstant -> ret (REF.upd is_tc (fun _ -> true)) rest
              | _ -> rest
            ) []
          in
          (*equivalence constraints*)
          LIST.diag_iter cls (fun expr1 expr2 ->
              noop (SET.add equals (Z3Assert(Z3Eq(expr1,expr2))))
            );
          SET.iter bins (fun (bin:mapslvr_bin) ->
              match bin with
              | SMVNeq(_,n) ->
                let z3n = number_to_z3_expr n in
                let neqs = List.map (
                    fun expr ->
                      Z3Assert(Z3Not(
                          Z3Eq(expr,z3n)
                        ))
                  ) cls
                in
                  noop (SET.add_all not_equals neqs)
                    
              | SMVCoverTime(min,max) ->
                List.iter (
                  fun expr ->
                    noop (QUEUE.enqueue_all time_cover (time_cstr_to_z3 expr min max))
                ) cls
              | _ -> ()
            );
        ) bin_set;
      SET.iter slvr_ctx.sts (fun st -> match st with
          | SMVCover(sc,off,hwival,mival) ->
            let sts = cover_cstr_to_z3 sc off hwival mival in
            noop (QUEUE.enqueue_all cover sts)
        );
      let problem =
        (QUEUE.to_list decls) @
        [Z3Comment("");Z3Comment("== Equivalences==")] @
        (SET.to_list equals) @
        [Z3Comment("");Z3Comment("== Not Equals==")] @
        (SET.to_list not_equals) @
        [Z3Comment("");Z3Comment("== Covers ==")] @
        (QUEUE.to_list cover) @
        [Z3Comment("");Z3Comment("== Time ==")] @
        (QUEUE.to_list time_cover)
      in
      (problem)


  let slvr_ctx_to_z3_validate : mapslvr_ctx -> (int,float) map -> float -> z3st list =
    fun ctx sln prec ->
      let base_prob = slvr_ctx_to_z3 ctx in
      let delta = prec /. 2.0 in
      let neg_delta = 0.0 -. delta in
      let sts = MAP.fold sln (fun idx value rest ->
          if MAP.has ctx.xidmap idx then
            let value =
              if value >= neg_delta && value <= delta then
                0.0 else value
            in
            Z3Assert(Z3LTE(
                  Z3Var (xid_to_z3_var idx),
                  Z3Number
                    (NUMBER.from_float  (value +. delta))
                ))::
              Z3Assert(Z3GTE(
                  Z3Var (xid_to_z3_var idx),
                  Z3Number
                    (NUMBER.from_float  (value -. delta))
                ))
              ::rest
          else
            rest
        ) []
      in
      let prob =  base_prob @ Z3Comment("==== Validate ===")::sts in
      prob

  let get_standard_model : z3assign list -> (int,float) map =
    fun asgns ->
      let  xid_to_val : (int,float) map= MAP.make () in
      List.iter (fun asgn -> match asgn with
          | Z3Set(varname,qty) ->
            let xid = z3_var_to_xid varname in
            begin
              match qty with
              | Z3QInt(i) ->
                MAP.put xid_to_val xid (float_of_int i)
              | Z3QFloat(f) ->
                MAP.put xid_to_val xid (f)
              | Z3QInterval(Z3QRange(min,max)) ->
                MAP.put xid_to_val xid ((MATH.max[min;max]))
              (*anything with infinity is basically a don't care.*)
              | Z3QInterval(Z3QAny) ->
                MAP.put xid_to_val xid (0.0)
              | Z3QInterval(Z3QInfinite(QDNegative)) ->
                MAP.put xid_to_val xid (SMapSlvrOpts.vmin)
              | Z3QInterval(Z3QInfinite(QDPositive)) ->
                MAP.put xid_to_val xid (SMapSlvrOpts.vmax)
              (*if the interval has a lower or upper bound, set value to lower or upper bound*)
              | Z3QInterval(Z3QLowerBound(b)) ->
                MAP.put xid_to_val xid (b)
              | Z3QInterval(Z3QUpperBound(b)) ->
                MAP.put xid_to_val xid (b)
              | Z3QBool(_) ->
                raise (Z3SMapSolver_error "unexpected: boolean datatype")

            end;
            ()
        ) asgns;
      xid_to_val
  

end

