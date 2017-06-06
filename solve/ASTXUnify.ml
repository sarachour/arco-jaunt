open SymCamlData
open SymCaml
open PyCamlWrapper

open Util
open Globals
open Interactive

open SearchData
open Search

open AlgebraicLib

open AST
open ASTUnifyData

open SolverData
open SlnLib
open SolverUtil

open SolverCompLib

open StochLib

open HWData
open MathData

open HWLib
open MathLib

exception ASTUnifierException of (string)
let error n msg = raise (ASTUnifierException(n^": "^msg))

let spy_print_debug = print_debug 4 "sympy"
let _print_debug = print_debug 4 "uni"
let debug : string -> unit =_print_debug  
let spydebug: string -> unit =spy_print_debug  
let auni_menu = menu 3

type  rnode = (rstep) snode

module ASTUnifySymcaml =
struct

  let tempvar () =
    "__tmp__"


  let is_tempvar x =
    x = tempvar()

  let tempmid () =
    MNVar(MInput,tempvar())

  let _symvar2mid (s:mid menv) (rst:string list) : mid =  match rst with
    | [v] ->  MathLib.str2mid s v
    | _ -> error "apply_comp" "iconvmid encountered unexpected string"

  
  let symvar2mid s mid = _symvar2mid (s) (STRING.split mid ":")


  let symvar2unid (mstate:math_state) (hwstate:hwcomp_state) uid =
   match STRING.split uid ":" with
     | "m"::m2::r -> if is_tempvar m2 = false then
         MathId(_symvar2mid (mstate.env) (m2::r))
       else
         MathId(tempmid())
    | "h"::r -> HwId(HwLib._symvar2hwid (hwstate.env) r)
    | h::r -> error "iconvunid" ("unexpected prefix "^h)
    | _ -> error "" ""

  
  let mid2symvar (mid:mid) : string = match mid with
    | MNVar(k,n) -> n
    | MNParam(name,v) -> name
    | MNTime -> "t"


  let unid2symvar uid = match uid with
    | MathId(m) -> "m:"^(mid2symvar m)
    | HwId(h) -> "h:"^(HwLib.hwid2symvar h)

  let print_wildcard (v:string) (bans:symexpr list) =
    let ban_str = LIST.fold bans (fun (x:symexpr) str ->
        str^","^(SymExpr.expr2str x)
      ) ""
    in
      spydebug ("[env][decl] wild "^(v)^" != "^ban_str);
      ()

  type sym_var_state = SYMEnvDeclared | SYMEnvUsed
  type sym_vtable = (symvar,sym_var_state) map

  let mk_vtable () : sym_vtable =
    MAP.make () 

  let vtable_declare (tbl:sym_vtable) (v:symvar) =
    if MAP.has tbl v then
      match MAP.get tbl v with
      | SYMEnvDeclared -> ()

      | SYMEnvUsed -> noop (MAP.put tbl v SYMEnvDeclared)
    else
      noop (MAP.put tbl v SYMEnvDeclared)

  let vtable_use (tbl:sym_vtable) (v:symvar) =
    if MAP.has tbl v then
      match MAP.get tbl v with
      | SYMEnvDeclared -> ()
      | SYMEnvUsed -> ()
    else
      noop (MAP.put tbl v SYMEnvUsed)


  let vtable_iter = MAP.iter
  
  let to_symvar s = s.tbl.symenv.cnv 
  let to_symexpr s x : symexpr = ASTLib.to_symcaml x (to_symvar s)

  let to_uvar s (x:symvar) : unid =
    s.tbl.symenv.icnv s.tbl.mstate s.tbl.hwstate x

  let to_uast s (x:symexpr) : unid ast = ASTLib.from_symcaml x (to_uvar s)


  let wrap_distribution (mu:'a ast) (vr:'a ast) =
    let mean = OpN(Func("MEAN"),[mu]) in
    let std = OpN(Func("VAR"),[vr]) in
    OpN(Add,[mean;std])

  let make_symcaml_env (s:runify) =
    let symenv = s.tbl.symenv and hwstate = s.tbl.hwstate and mstate = s.tbl.mstate in
    let vtable : sym_vtable = mk_vtable  () in
    (*variable table*)
    try
      (*SymCaml.define_function symenv.s "VAR";
      SymCaml.define_function symenv.s "MEAN";*)
      SymCaml.define_symbol symenv.s ("m:"^tempvar());
      let decl_symvar (vname:symvar) =
          spydebug ("[env][decl] mvar "^vname);
          vtable_declare vtable vname;
          SymCaml.define_symbol symenv.s vname;
          ()
      in
      let use_vars_in_expr (e:symexpr) =
        List.iter (fun vname -> decl_symvar vname) (SymExpr.get_vars e)
      in
      (*get list of disabled expressions*)
      let get_disabled (v: hwvid hwportvar) = 
        if MAP.has hwstate.disabled v.port then
            let ban_cfgs = MAP.get hwstate.disabled v.port in
            List.map (fun (x:hwvarcfg) ->
                let symexpr = to_symexpr s x.expr in
                use_vars_in_expr (symexpr);
                symexpr
              ) ban_cfgs
        else []
      in
      (*declare and then print the wildcard*)
      let decl_wildcard (v: hwvid hwportvar) =
        let vname : symvar = to_symvar s (HwId (HwLib.var2id v hwstate.inst)) in
        let bans : symexpr list = get_disabled v in
        print_wildcard vname bans;
        vtable_declare vtable vname;
        SymCaml.define_wildcard symenv.s vname bans;
        ()
      in
      let decl_var (v:hwvid hwportvar) =
        let vname = to_symvar s (HwId (HwLib.var2id v hwstate.inst)) in
        begin
          match ConcCompLib.get_var_config hwstate.cfg v.port with
          | Some(conc_expr) -> use_vars_in_expr (to_symexpr s conc_expr)
          | None -> ()
        end;
        decl_symvar vname;
        ()
      in
      SymCaml.clear symenv.s;
      (*iterate over all variables and define them*)
      HwLib.comp_iter_vars hwstate.comp (fun (v:hwvid hwportvar) ->
          if ConcCompLib.is_conc hwstate.cfg v.port = false then
            decl_wildcard v
          else
            let vname : symvar = to_symvar s (HwId (HwLib.var2id v hwstate.inst)) in
            decl_symvar vname;
            decl_var v
        );
      MathLib.iter_vars mstate.env (fun (v:mid mvar) ->
          let vname = to_symvar s (MathId (MathLib.var2mid v)) in 
          decl_symvar vname;
          ()
      );
      (*declare variable external to component*)
      noop (vtable_iter vtable (fun v st-> match st with
          | SYMEnvUsed ->
            spydebug ("[env][decl] var-used "^v);
            SymCaml.define_symbol symenv.s v;
            ()
          | SYMEnvDeclared -> ()
        ));
      true 
    with
    | _ ->
      warn "mk_symcaml_env" "failed to build environment";
      false

  let print_unify (hwexpr:symexpr) (texpr:symexpr) =
    let hwstr = SymCaml.expr2str hwexpr in
    let tstr = SymCaml.expr2str texpr in
    debug ("#unify <?>\n"^
           "  hw-expr:\n  "^hwstr^"\n\n"^
           "  m-expr:\n  "^tstr^"\n");
    ()

  let print_assign (lhs:unid) (rhs:unid ast) =
    debug (" "^(unid2str lhs)^"="^(uast2str rhs))


  let if_numeric_unify (s:runify) (hwexpr:unid ast) (texpr:unid ast) =
    let valid = REF.mk true in
    let symenv = s.tbl.symenv in
    let result = match hwexpr,  texpr  with
    | Integer(x),Integer(y) -> if x = y then Some([]) else None
    | Integer(x),Decimal(y) -> if float_of_int x = y then Some([]) else None
    | Decimal(x),Integer(y) -> if x = float_of_int y then Some([]) else None
    | Decimal(x),Decimal(y) -> if x = y then Some([]) else None
    | Decimal(x),_ -> None
    | Integer(x),_ -> None
    | _,Decimal(x) -> None
    | _,Integer(x) -> None
    | _ -> REF.upd valid (fun x -> false); None 
    in
    REF.dr valid,result

  let unify (s:runify) (hwexpr:unid ast) (texpr:unid ast) =
    (*attempt unification*)
    let symenv = s.tbl.symenv in
    let symhwexpr = to_symexpr s hwexpr in
    let symtexpr = to_symexpr s texpr in
    print_unify symhwexpr symtexpr;
    let unified_numeric,result =
      if_numeric_unify s hwexpr texpr
    in
    if unified_numeric then result else
      let simpl_symhwexpr = SymCaml.simpl symenv.s symhwexpr in 
      let maybe_assigns =
        try
          SymCaml.pattern symenv.s symtexpr simpl_symhwexpr
        with
        | PyCamlWrapperException(_) ->
          begin
            warn "[unify_term][exception] python exception";
            None
          end
        | SymCamlFunctionException(_) ->
          begin
            warn "[unify_term][exception] symcaml fxn exception";
            None
          end
        | _ ->
          begin
            warn "[unify_term][exception] some other exception";
            None
          end

      in
      match maybe_assigns with
      | Some(assigns) ->
        debug "[unify][pattern]: ==ASSIGNMENTS==";
        Some (List.map (fun ((symlhs,symrhs):symvar*symexpr) ->
            let lhs = to_uvar s symlhs in
            let rhs = to_uast s symrhs in
            debug "[unify][pattern]: <no solution>";
            print_assign lhs rhs;
            (lhs,rhs)
        ) assigns) 
      | None ->
        debug "[unify][pattern]: <no solution>";
        None



end

module ASTUnifyTree =
struct
  let weights : (string*unid ast) search_weights =
    let compute ((x,y):(string*unid ast)) =
      float_of_int (ASTLib.size y)
    in
    SearchWeights.mk_weights compute

  let update_weights (env:runify) node =
    let steps = SearchLib.get_path env.search node in
    let path = List.map (fun step -> match step with
        | RAddInAssign(lhs,rhs) -> Some (lhs,rhs.expr)
        | RAddOutAssign(lhs,rhs) -> Some (lhs,rhs.expr)
        | RAddParAssign(lhs,rhs) -> Some (lhs,ASTLib.number2ast rhs)
        | RDisableAssign(lhs,rhs) -> None
      ) steps
    in
    SearchWeights.update_weights weights (OPTION.conc_list path) (fun x -> false)

  let get_weight (step) = match step with
    | RAddInAssign(lhs,rhs) -> SearchWeights.get_weight weights (lhs,rhs.expr)
    | RAddOutAssign(lhs,rhs) -> SearchWeights.get_weight weights (lhs,rhs.expr)
    | RAddParAssign(lhs,rhs) -> SearchWeights.get_weight weights (lhs,ASTLib.number2ast rhs)
    | RDisableAssign(lhs,rhs) ->
      0. -. (SearchWeights.get_weight weights (lhs,rhs))

  let remove_disabled (tbl:rtbl) v expr =
    let s = tbl.hwstate in 
    let ecfg = ConcCompLib.mkvarcfg expr in
    if MAP.has s.disabled v then
      let dsbl = MAP.get s.disabled v in
      let new_dsbl : hwvarcfg list =
        List.filter (fun (curr_e:hwvarcfg) ->
            curr_e.expr != ecfg.expr
          ) dsbl
      in
      begin
      match new_dsbl with
      | h::t -> MAP.put s.disabled v new_dsbl
      | [] -> MAP.rm s.disabled v
      end;
      ()
    else
      ()

  let add_disabled (tbl:rtbl) v expr =
    let s = tbl.hwstate in
    let e = ConcCompLib.mkvarcfg expr in
    begin
    if MAP.has s.disabled v then
      let dsbl = MAP.get s.disabled v in
      MAP.put s.disabled v (e::dsbl)
    else
      MAP.put s.disabled v [e]
    end;
    ()

  let apply_step (type a) (s:rtbl) (st:rstep) : rtbl =
    begin
      match st with
      | RAddParAssign(vr,asgn) ->
        ConcCompLib.conc_param s.hwstate.cfg vr asgn
      | RAddOutAssign(vr,asgn) ->
        ConcCompLib.conc_out s.hwstate.cfg vr asgn
      | RAddInAssign(vr,asgn) ->
        ConcCompLib.conc_in s.hwstate.cfg vr asgn
      | RDisableAssign(vr,asgn) ->
        add_disabled s vr asgn 
    end;
    s 


  let unapply_step (type a) (s:rtbl) (st:rstep) : rtbl =
    begin
      match st with
        | RAddParAssign(vr,_) ->
          ConcCompLib.abs_param s.hwstate.cfg vr 
        | RAddOutAssign(vr,_) ->
          ConcCompLib.abs_out s.hwstate.cfg vr 
        | RAddInAssign(vr,_) ->
          ConcCompLib.abs_in s.hwstate.cfg vr 
        | RDisableAssign(vr,expr) ->
          remove_disabled s vr expr
    end;
    s

  let step2str (a:rstep) = match a with
    | RAddParAssign(vr,asgn) ->
          "+par-asgn "^(vr)^"="^(string_of_number asgn)
    | RAddOutAssign(vr,asgn) ->
          "+out-asgn "^(vr)^"="^(ConcCompLib.varcfg2str asgn)
    | RAddInAssign(vr,asgn) ->
          "+inp-asgn "^(vr)^"="^(ConcCompLib.varcfg2str asgn)
    | RDisableAssign(vr,rhs) ->
          "-asgn "^(vr)^"="^(ASTLib.ast2str rhs unid2str)

  let step2restrict (step:rstep) :rstep option =  match step with
          | RAddInAssign(vr,cfg) -> Some (RDisableAssign(vr,cfg.expr))
          | RAddOutAssign(vr,cfg) -> Some (RDisableAssign(vr,cfg.expr))
          | RDisableAssign(_) -> Some (step)
          | _ -> None

  let order_steps a b = 0

  let score_uniform steps : sscore =
      let delta = 0. in
      let state = 0. in
      SearchLib.mkscore delta state

  let score_random steps : sscore =
      let delta = RAND.rand_norm () in
      let state = RAND.rand_norm () in
      SearchLib.mkscore delta state

  let score_steps_uniform steps : sscore = 
    let delta = LIST.fold steps (fun x (r:float) ->
        let restrict_weight = get_weight x in
        restrict_weight +. r
      ) (RAND.rand_norm())
      in
      let state = 0. in
      SearchLib.mkscore (delta /.(float_of_int (List.length steps))) state
 
  let score_restrictions steps : sscore = 
      let delta = LIST.fold steps (fun x (r:float) -> match x with
        | RDisableAssign(lhs,rhs) ->
          let ast_size = (ASTLib.size rhs) in
          let restrict_weight = get_weight x in
          (1. +. (float_of_int ast_size))*.restrict_weight +. r
        | _ -> r
      ) (RAND.rand_norm())
      in
      let state = 0. in
      SearchLib.mkscore delta state

  let get_score ()  =
      match get_glbl_string "uast-selector-branch" with
      | "uniform" -> score_uniform
      | "random" -> score_random
      | "restrict" -> score_restrictions
      | "steps-uniform" -> score_steps_uniform
      | _ -> error "get_score" "unknown strategy"

    let is_wildcard (comp:hwcomp_state) (vr:unid) = match vr with
      | HwId(HNPort(_,HCMLocal(hname),hwport,_)) -> true
      | HwId(HNPort(_,HCMGlobal(hname),hwport,_)) -> true
      | _ -> false

    let mk_comp_search (hwenv:hwvid hwenv) (menv:mid menv) (comp:hwvid hwcomp) (inst) (cfg:hwcompcfg) (hvar:string) =
      let search : (rstep, rtbl) ssearch =
        SearchLib.mksearch apply_step unapply_step
          order_steps (get_score()) (step2str)
      in
      let hw_st : hwcomp_state = {
        env=hwenv;
        comp=comp;
        inst=inst;
        target=hvar;
        cfg=cfg;
        disabled=MAP.make();
      } in
      let math_st : math_state = {
        env=menv;
        solved=[];
      } in
      let sym_st : symcaml_env = {
        s=SymCaml.init (None) (SV100) (None);
        cnv= ASTUnifySymcaml.unid2symvar;
        icnv= ASTUnifySymcaml.symvar2unid;
        is_wildcard = is_wildcard hw_st;
      } in
      SymCaml.clear sym_st.s;
      let tbl : rtbl = {
        symenv = sym_st;
        hwstate = hw_st;
        mstate = math_st;
        target=TRGNone;
      } in
      {
        tbl=tbl;
        search=search;
      }

  let init_root st init_steps =
    SearchWeights.clear_weights weights;
    match st.tbl.target with
    | TRGMathVar(name) ->
      let mvar = MathLib.getvar st.tbl.mstate.env name in
      let hvar = HwLib.comp_getvar st.tbl.hwstate.comp st.tbl.hwstate.target in
      let mcfg = ConcCompLib.mkvarcfg (Term(MathId(MNVar(mvar.knd,name)))) in 
      let asgn = RAddOutAssign(st.tbl.hwstate.target, mcfg) in
      begin
      match hvar.bhvr,mvar.bhvr with
      | HWBAnalogState(h),MBhvStateVar(s) ->
        let icport,_ = h.ic in
        let iccfg = ConcCompLib.mkvarcfg (number_to_ast s.ic) in 
        let ic_asgn = RAddInAssign(icport,iccfg) in
        SearchLib.setroot st.search st.tbl (ic_asgn::asgn::init_steps)
      | _ -> 
        SearchLib.setroot st.search st.tbl (asgn::init_steps)
      end
    | TRGHWVar(hwexpr) ->
      let asgn = RAddOutAssign(st.tbl.hwstate.target, {expr=hwexpr}) in
      SearchLib.setroot st.search st.tbl (asgn::init_steps)
    | TRGNone -> error "init_root" "must have a target at root creation"
      
  let rec get_best_valid_node (type a) (sr:runify) (root:(rnode) option)  : (rnode) option =
    SearchLib.select_best_node sr.search root 
    



end

module ASTUnifier =
struct

  let tempvar = ASTUnifySymcaml.tempvar

  let tempmid = ASTUnifySymcaml.tempmid
                 

  let mkmenu (sr : runify) =
    let menu_desc = "t=search-tree,i=info" in
    let rec menu_handle inp on_finished=
      if STRING.startswith inp "t" then
        let _ = Printf.printf "\n%s\n\n" (SearchLib.search2str sr.search) in
        let _ = on_finished() in
        ()
      else if STRING.startswith inp "i" then
        let chan = stdout in
        let _ = Printf.fprintf chan "# TODO\n" in
        let _ = on_finished() in
        ()
      else
        ()
    in
    let internal_menu_handle x = menu_handle x (fun () -> ()) in
    let rec user_menu_handle () = auni_menu "ast-unify" (fun x -> menu_handle x user_menu_handle) menu_desc in
    internal_menu_handle,user_menu_handle


  (*
     Parameter scoping and expansion
  *)
  let get_involved_vars (type b) (cmp:hwvid hwcomp) (cfg:hwcompcfg)
      (startvar:string) (f:hwvid->b option) : b list =
    let outvars : string set = SET.make_dflt () in
    let explored : string set= SET.make_dflt () in
    let coll = SET.make_dflt () in
    let rec _get_involved_vars ()=
      let target_maybe : string option=
        SET.fold outvars (fun x t -> if SET.has explored x = false then Some(x) else t) None
      in
      match target_maybe with
      | Some(target) ->
        begin
          HwLib.portvar_iter_vars cmp target (fun (v:hwvid) ->
              match f v with
              |Some(q) -> noop (SET.add coll q)
              |None -> ();
                match v with
                | HNPort(HWKOutput,_,pname,_) ->
                  if ConcCompLib.is_conc cfg pname = false then
                    noop (SET.add outvars pname)
                | _ -> ()
            );
          SET.add explored target;
          _get_involved_vars ()
        end
      | None -> ()
    in
    SET.add outvars startvar;
    _get_involved_vars();
    SET.to_list coll


  (*prune params based on target hwvar*)
  let expand_params_tree (env:runify) =
    (*compute closed set of parameters*)
    let params
      = get_involved_vars env.tbl.hwstate.comp env.tbl.hwstate.cfg env.tbl.hwstate.target
        (fun x -> match x with
           | HNParam(_,x) -> Some(x)
           | _ -> None
        )
    in
    (*compute list of possibilities of values for params*)
    let options : (rstep list) list = List.fold_right (fun (paramname:string) opts ->
        debug ("adding options for "^paramname);
        let paramvals : number list=
          HwLib.comp_get_param_values env.tbl.hwstate.comp paramname in
        let opt : rstep list= List.map
            (fun (v:number) -> RAddParAssign(paramname,v)) paramvals in
        opt::opts 
      ) params []
    in
    let permutes : (rstep list) list= LIST.permutations options in
    let rootnode = SearchLib.root env.search in
    List.iter ( fun (steps: rstep list) ->
        SearchLib.mknode_from_steps env.search env.tbl steps;
        ()
      ) permutes;
    ()
  (*============ EXPAND PARAMS END ===================*)
  (*============ UNIFY  START ===================*)
  let mkcompid (s:runify)  : compid =
    HwLib.mkcompid s.tbl.hwstate.comp.name s.tbl.hwstate.inst

  let find_entanglements s assigns : (string*unid ast) list =
    let hwstate = s.tbl.hwstate in
    let cmpid = mkcompid s in 
    let get_port_from_id (x:unid) : hwvkind*string = match x with
      | HwId(HNPort(knd,cmp,port,prop)) ->
        if cmp = cmpid then knd,port else
          error "get_port_from_id" "can only set properties inside component"
      | _ ->
        error "get_port_from_id" "can only set hardware ports"
    in
    let get_entanglement lhs rhs =
      let mrhs = uast2mast rhs in
      match (get_port_from_id lhs) with
      | HWKInput,port -> None
      | HWKOutput,port ->
        if ConcCompLib.is_conc hwstate.cfg port = false
        then Some port
        else error "get_entanglement" "cannot re-assign variable"

    in
    List.fold_right (fun (lhs,rhs) (lst:(string*unid ast) list) ->
        match get_entanglement lhs rhs with
        | Some(v) -> (v,rhs)::lst
        | _ -> lst
      ) assigns []

  type unify_expr =
    (*entangled with another math variable*)
    | UNIMathVar of string
    (*entangled with an expression of math variables*)
    | UNIMathExpr of mid ast
    (*entangled with another state variable*)
    | UNIUnunifiable of unid ast

  type unify_assign = {
    port: string;
    expr: unify_expr;
  }

  (*concretization stack*)
  type unify_op = {
    steps:rstep list;
    entang:unify_assign list;
    rslvd:unify_assign list;
  }
  type unify_ctx = (unify_op) stack
  let mkunifyctx () = STACK.make()

  let unifyassign2str (e:unify_assign) =
    let estr = match e.expr with
      | UNIMathExpr(e) -> "math-expr "^(ASTLib.ast2str e mid2str)
      | UNIMathVar(v) -> "math-var "^v
      | UNIUnunifiable(e) -> "deadend "^(ASTLib.ast2str e unid2str)
    in
    e.port^" = "^estr

  let unifyexpr2uast (st:runify) (a:unify_expr) =
    match a with
    | UNIMathExpr(e) -> (mast2uast e)
    | UNIMathVar(v) ->
      let knd = MathLib.getkind st.tbl.mstate.env v in
      (Term(MathId(MNVar(knd,v))))
    | UNIUnunifiable(e) -> (e)

  let op2str (op:unify_op) =
    let str =
       List.fold_right (fun x str ->
          (ASTUnifyTree.step2str x)^"\n"^str) op.steps ""
    in
    let str = List.fold_right (fun x str ->
        "entg "^(unifyassign2str x)^"\n"^str) op.entang str
    in
    let str = List.fold_right (fun x str ->
        "rslv "^(unifyassign2str x)^"\n"^str) op.rslvd str
    in
    str

  let ctx2str (ctx:unify_ctx) =
    STACK.fold ctx (fun el str ->
        str^"\n"^(op2str el)^"---------\n"
      ) "== CTX =="

 
  (*get all the resolved entanglements*)
  let get_resolutions (ctx:unify_ctx) :(string,unify_assign) map =
    let rsls = MAP.make () in
    STACK.iter ctx (fun (op:unify_op)  ->
        List.iter (fun r ->
            noop (MAP.put rsls r.port r)
          ) op.rslvd;
         ()
    );
    rsls

 
  let get_entanglements (ctx:unify_ctx) :(string,unify_assign) map =
    let ents = MAP.make () in
    let rslvd = get_resolutions ctx in 
    STACK.iter ctx (fun (op:unify_op)  ->
        List.iter (fun ent ->
            if MAP.has rslvd ent.port then
              ()
            else
              noop (MAP.put ents ent.port ent )
          ) op.entang;
         ()
    );
    ents

  (*unifying an output hwvar with...*)
  let uast_to_unify_expr (st:runify) (port:string) (a:unid ast) : unify_expr =
    let mstate = st.tbl.mstate and hwstate = st.tbl.hwstate in
    match a with
    (*unifying with an input variable. This is unifiable provided we can pass-through the var*)
    | Term(MathId(MNVar(MInput,name))) ->
      UNIMathExpr(uast2mast a)
    (*unifying with an output variable*)
    | Term(MathId(MNVar(_,name))) ->
      begin
      match MathLib.isstvar mstate.env name, HwLib.comp_isstvar hwstate.comp port with
      | true,true -> UNIMathVar(name)
      | false,false -> UNIMathVar(name)
      | _ -> UNIUnunifiable(a)
      end
    | expr -> UNIMathExpr(uast2mast expr)


  (*given the configuration, find any entanglements, negating the already resolved ones*)
  let addctx_derive_entanglements (st:runify) (ctx:unify_ctx)
      (asgns:(string*unid ast) list) (new_rslvd:unify_assign list) =
    let resolved = get_resolutions ctx in
    let is_resolved ovar oexpr : bool =
      if MAP.has resolved ovar then
        if (MAP.get resolved ovar).expr = oexpr then
          true
        else
          error "addctx_derive_entanglements" "cannot add entanglement when variable has been reoslved"
      else
        LIST.fold new_rslvd (fun x found ->
          if ovar = x.port && oexpr = x.expr
          then true else found
        ) false
    in
    let is_output_port (ovar:string) =
      (HwLib.comp_getvar st.tbl.hwstate.comp ovar).knd = HWKOutput
    in
    let entang = List.fold_right (fun (ovar,oexpr) (entangs) ->
        let unify_expr = uast_to_unify_expr st ovar oexpr in
        if is_resolved ovar unify_expr = false && is_output_port ovar then
          ({port=ovar;expr=unify_expr}::entangs)
        else 
          entangs   
      ) asgns ([]) in
    entang
        
  (*add assignments to the context*)
  let addctx (st:runify) (ctx:unify_ctx)
      (asgns:(string*unid ast) list) (new_rslvd:unify_assign list) : unify_ctx =
    let to_step port expr :rstep =
      match (HwLib.comp_getvar st.tbl.hwstate.comp port).knd with
      | HWKInput -> RAddInAssign(port,ConcCompLib.mkvarcfg expr)
      | HWKOutput -> RAddOutAssign(port,ConcCompLib.mkvarcfg expr)
    in
    let entang = addctx_derive_entanglements st ctx asgns new_rslvd in 
    let steps : rstep list = List.map (fun (port,expr) ->
        let stp = to_step port expr in
        ASTUnifyTree.apply_step st.tbl stp;
        stp
      ) asgns
    in
    let op : unify_op = {steps=steps;entang=entang;rslvd=new_rslvd} in
    STACK.push ctx op;
    ctx

  (*remove the last set of assignments*)
  let popctx (st:runify) (ctx:unify_ctx) =
    let op : unify_op = STACK.peek ctx in
    List.iter (fun step ->
        ASTUnifyTree.unapply_step st.tbl step;
        ()
      ) op.steps;
    STACK.pop ctx;
    ctx

  let rec clear_ctx (st:runify) (ctx:unify_ctx) =
    if STACK.size ctx > 0 then
      begin
      popctx st ctx;
      clear_ctx st ctx
      end
    else
      ()
  (*entanglements*)
  let get_ununifiable (ctx:unify_ctx) : unify_assign list =
    let entang = get_entanglements ctx in
    MAP.fold entang (fun k v lst -> match v.expr with
         | UNIUnunifiable(_) -> v::lst
         | _ -> lst
      ) []

  type unify_result =
    | UNIRESSuccess of rstep list
    | UNIRESFailure of unify_assign list
    | UNIRESCompleteFailure

  let unapply_ctx (st:runify) (ctx) =
    let steps = STACK.fold ctx (fun ops lst ->
        ops.steps @ lst) []
    in
    clear_ctx st ctx;
    steps

  let ctx_ununifiable (st:runify) (ctx:unify_ctx) =
    unapply_ctx st ctx;
    UNIRESFailure(get_ununifiable ctx)

  
  let ctx_no_solution (st:runify) (ctx:unify_ctx) =
    let subseq_steps = STACK.fold (STACK.pop_bottom ctx) (fun ops lst ->
        ops.steps @ lst ) []
    in
    (*enumerate all of the assignments that we should ban*)
    let assigns = List.fold_right (fun (s:rstep) (asgns:unify_assign list) ->
        match s with
        | RAddOutAssign(lhs,rhs) ->
          let unify_expr = uast_to_unify_expr st lhs (rhs.expr) in
          {port=lhs;expr=unify_expr}::asgns
        | RAddInAssign(lhs,rhs) ->
          let unify_expr = uast_to_unify_expr st lhs (rhs.expr) in
          {port=lhs;expr=unify_expr}::asgns
        | _ -> asgns
      ) subseq_steps []
    in
    unapply_ctx st ctx;
    if List.length assigns = 0 then
      UNIRESCompleteFailure
    else
      UNIRESFailure(assigns)



  let ctx_unified (st:runify) (ctx:unify_ctx) =
    let steps = unapply_ctx st ctx in 
    UNIRESSuccess(steps)



  let ctx_unsolvable (st:runify) (ctx:unify_ctx) =
    (List.length (get_ununifiable ctx))  > 0



  let unify_expr (st:runify) (expr:unid ast) = 
    error "unify_expr" "unimpl"



  let strip_port_from_list st (lst:(unid*unid ast) list) : (string*unid ast) list =
    let hcmp = mkcompid st in 
    let strip_port_from_id x = match x with
      | HwId(HNPort(k,cmp,port,prop)) -> if cmp = hcmp then
          port else error "strip_port_from_Id" "cannot set another component's port"
      | _ -> error "strip_port_from_Id" "cannot set another variable"
    in
    List.map (fun (k,v) -> (strip_port_from_id k,v)) lst

  let unify_math_expr (st:runify) (port:string) (expr:mid ast) =
    let hwstate = st.tbl.hwstate and mstate = st.tbl.mstate in 
    let hvar = HwLib.comp_getvar hwstate.comp port in
    let cmpid : compid = mkcompid st in 
    match hvar.bhvr with
    | HWBAnalog(abhv) ->
      let hexpru :unid ast =
        ConcCompLib.concrete_hwexpr_from_compid cmpid hwstate.cfg (abhv.rhs)
      in
      (*TODO*)
      let hvaru :unid ast =
        ConcCompLib.concrete_hwexpr_from_compid cmpid hwstate.cfg (StochLib.get_expr abhv.stoch)
      in
      let mexpru :unid ast= mast2uast
          (MathLib.replace_params mstate.env expr)
      in
      ASTUnifySymcaml.unify st hexpru mexpru
    | HWBAnalogState(_) ->
      warn "unify_math_expr" ("cannot unify math expression with analog state variable");
      None
    | HWBDigital(_) ->
      error "unify" "unify var with digital"
    | _ ->
      error "unify_math_expr" "unify unsupported"


  (*unify with math variable*)
  let unify_math_var (st:runify) (port:string) (mvar:string) =
    let hwstate = st.tbl.hwstate and mstate = st.tbl.mstate in 
    let hvar = HwLib.comp_getvar hwstate.comp port in
    let mvar = MathLib.getvar mstate.env mvar in 
    let cmpid = mkcompid st in 
    match mvar.bhvr,hvar.bhvr with
    | MBhvVar(mbhv),HWBAnalog(abhv) ->
      let mexpru : unid ast = mast2uast
          (MathLib.replace_params mstate.env mbhv.rhs)
      in
      let hexpru : unid ast =
        ConcCompLib.concrete_hwexpr_from_compid cmpid hwstate.cfg abhv.rhs
      in
      ASTUnifySymcaml.unify st hexpru mexpru

    | MBhvStateVar(mbhv),HWBAnalogState(abhv) ->
      let mexpru :unid ast= mast2uast
          (MathLib.replace_params mstate.env mbhv.rhs)
      in
      let hexpru :unid ast =
        ConcCompLib.concrete_hwexpr_from_compid cmpid hwstate.cfg abhv.rhs
      in
      ASTUnifySymcaml.unify st hexpru mexpru 

    | MBhvVar(_),HWBDigital(_) ->
      error "unify" "unify var with digital"
    | _ ->
      error "unify_math_var" "unify unsupported"

  (*recursively unify*) 
  let rec unify_recurse (st:runify) (ctx:unify_ctx) : unify_result =
    let entangled = get_entanglements ctx in
    if ctx_unsolvable st ctx then
      begin
        debug "==== Ununifiable ====";
        debug (ctx2str ctx);
        ctx_ununifiable st ctx
      end
    else
      match MAP.to_values entangled with
      | ent::t ->
        begin
          debug ("solving entanglement: "^unifyassign2str ent);
          let maybe_assigns = 
              match ent.expr with
                | UNIMathExpr(expr) ->
                  unify_math_expr st ent.port expr 
                | UNIMathVar(v) ->
                    unify_math_var st ent.port v
                | UNIUnunifiable(_) ->
                  error "maybe_assigns" "cannot see ununifiable here"
          in
          begin
            match maybe_assigns with
            | Some(assigns) ->
              begin
                addctx st ctx (strip_port_from_list st assigns) [ent];
                debug (ctx2str ctx);
                unify_recurse st ctx
              end 
            | None ->
              debug "==== No Solution ====";
                debug (ctx2str ctx);
                ctx_no_solution st ctx
            end
        end
      | [] ->
        debug "==== Unified ====";
        debug (ctx2str ctx);
        ctx_unified st ctx

  let unify (env:runify) = 
    (* get concretized version of component with config substituted in*)
    (* get bhvr of hardware *)
    let hwstate = env.tbl.hwstate in 
    if ASTUnifySymcaml.make_symcaml_env env = false then
      let currnode :rnode = SearchLib.cursor env.search in
      noop (SearchLib.deadend env.search currnode env.tbl)
    else
      let ctx = mkunifyctx () in
      let req_assign : (string*unid ast) ref = REF.mk ("?",Integer(0)) in
      let result = match env.tbl.target with
        | TRGMathVar(mname) ->
          begin
            let mvar = MathLib.getvar env.tbl.mstate.env mname in
            let rhs = Term(MathId(MathLib.var2mid mvar)) in
            addctx env ctx [(hwstate.target,rhs)] [];
            REF.set req_assign (hwstate.target,rhs);
            unify_recurse env ctx
          end
        | TRGHWVar(expr) ->
          addctx env ctx[(hwstate.target,expr)] [];
          REF.set req_assign (hwstate.target,expr);
          unify_recurse env ctx

        | _ -> error "unify" "unhandled"
      in
      match result with
      | UNIRESSuccess(steps) ->
        let currnode :rnode = SearchLib.cursor env.search in
        let slnnode : rnode =
          SearchLib.mknode_child_from_steps env.search env.tbl steps
        in
        ASTUnifyTree.update_weights env slnnode; 
        SearchLib.solution env.search slnnode;
        List.iter (fun step ->
            match ASTUnifyTree.step2restrict step with
            | Some(RDisableAssign(lhs,rhs)) ->
              let init_lhs,init_rhs = REF.dr req_assign in
              if lhs = init_lhs && rhs = init_rhs then
                ()
              else
                let restrict = RDisableAssign(lhs,rhs) in
                let restrict_node =
                  SearchLib.mknode_child_from_steps env.search env.tbl [restrict]
                in
                ASTUnifyTree.update_weights env restrict_node
            | Some(_) -> error "unify" "expected restriction steps only"
            | None -> ()
        ) steps 


      (*add child*)
      | UNIRESFailure(assigns) ->
        let restricts = List.map (fun x ->
            RDisableAssign(x.port,unifyexpr2uast env x.expr)
          ) assigns
        in
        let currnode :rnode = SearchLib.cursor env.search in
        List.iter (fun restrict ->
            SearchLib.mknode_child_from_steps env.search env.tbl [restrict];
            ()
          ) restricts;
        SearchLib.visited env.search currnode

      | UNIRESCompleteFailure ->
        let currnode :rnode = SearchLib.cursor env.search in
        noop (SearchLib.deadend env.search currnode env.tbl)


  (*============ UNIFY END ===================*)





  let normalize_n_slns (sr:runify) nonnorm_n : int =
    let cmp = sr.tbl.hwstate.comp in
    let factor = REF.mk 1 in
    HwLib.comp_iter_params cmp (fun (par:hwparam) ->
        let n = List.length par.value in
        REF.upd factor (fun x -> x * n)
      );
    nonnorm_n * (REF.dr factor)

  (*============ TREE START ===================*)
  (*select the next node to solve*)
  let _depr_solve (type a) (sr:runify) nslns =
    let desired_nslns = normalize_n_slns sr nslns in 
    let sysmenu,usrmenu = mkmenu sr in
    let _mnext () =
        let maybe_next_node = ASTUnifyTree.get_best_valid_node sr None in
        match maybe_next_node with
        | Some(next_node) ->
            (*if we're going really deep*)
            SearchLib.move_cursor sr.search sr.tbl next_node;
            true 
        | None ->false 
    in
    let exceeded_depth (curs) solve_fxn =
      debug "exceeded depth on branch.";
      SearchLib.deadend sr.search curs sr.tbl;
      if _mnext ()
      then begin solve_fxn() end
      else ()
    in
    let found_enough_solutions (curs) =
      debug "!--> Found Enough Solutions, Exiting <--!";
      ()
    in
    let get_num_slns () =
      SearchLib.num_solutions sr.search None
    in
    let report_num_slns () =
      let nslns : int = get_num_slns () in
      debug ("# solutions: "^(string_of_int nslns));
      nslns
    in
    let find_more_solutions (curs) solve_fxn =
          unify sr;
          usrmenu ();
          if _mnext () then
            begin
            debug "--> Continuing Search <--";
            solve_fxn ()
            end
          else
            debug "--> Finishing AST Search <--";
           ()
    in
    let rec _solve () =
      let curs = SearchLib.cursor sr.search in
      let depth : int =  SearchLib.depth sr.search curs in
      if depth >= get_glbl_int "uast-depth" then
        exceeded_depth curs (fun () ->
            begin
              _mnext ();
              usrmenu ();
              _solve ()
            end
          )
      else
        begin
        (*get the next node*)
          let nslns : int = get_num_slns() in
          if nslns >= desired_nslns then
            begin
              report_num_slns ();
              found_enough_solutions curs
            end
          else
            find_more_solutions curs _solve
        end
    in
    _mnext ();
    usrmenu ();
    _solve ();
    (*let _ = sysmenu "t" in*)
    ()
(*
  let unify_with_hwvar (env:runify) (hexpr: unid ast) steps =
    let nslns = Globals.get_glbl_int "eqn-unifications" in
    env.tbl.target <- TRGHWVar(hexpr);
    ASTUnifyTree.init_root env steps;
    expand_params_tree env;
    solve env nslns;
    get_solutions env 

  let unify_with_mvar (env:runify) (mvar:string) steps =
    let nslns = Globals.get_glbl_int "eqn-unifications" in
    env.tbl.target <- TRGMathVar(mvar);
    ASTUnifyTree.init_root env steps;
    expand_params_tree env;
    solve env nslns;
    get_solutions env 
  *)


  let construct_hw_comp : unid AlgebraicLib.UnifyEnv.t -> hwvid hwcomp -> hwcompcfg -> int option -> string -> unit =
    fun env comp cfg inst_maybe hwvar ->
    (*==== HARDWARE ====*)
      let proc_expr (e:hwvid ast) : unid ast =
        hwast2uast (ASTLib.map e (HwLib.try_toglbl inst_maybe))  in
      let proc_var (e:hwvid) =
        HwId (HwLib.try_toglbl inst_maybe e)
      in
      let cmpid = HwLib.mkcompid comp.name inst_maybe in 
      (*inputs are wildcards*)
      MAP.iter comp.ins (fun portname portd ->
        let portid : unid =
            proc_var (HwLib.port2hwid
               portd.knd portd.comp portd.port portd.prop portd.typ)
        in

        match ConcCompLib.get_var_config cfg portname with
        | None -> 
          begin
            AlgebraicLib.UnifyEnv.define_pat env portid 
          end
        | Some(expr) ->
            begin
            AlgebraicLib.UnifyEnv.define_pat env portid;
            AlgebraicLib.UnifyEnv.init_pat env portid 
              (expr);
            ()
          end
      );
      (* parameters are lists of possible values *)
      MAP.iter comp.params (fun paramn paramd ->
        AlgebraicLib.UnifyEnv.define_pat_param env
          (HwId(HNParam(cmpid,paramn))) paramd.value 
        );

      (*outputs are wildcards*)
      MAP.iter comp.outs (fun (portname:string) (portd :hwvid hwportvar)->
        let portid : unid =
            proc_var (HwLib.port2hwid
               portd.knd portd.comp portd.port portd.prop portd.typ)
        in

        match ConcCompLib.get_var_config cfg portname with 
        | None ->
          begin
            AlgebraicLib.UnifyEnv.define_pat env portid;
            match portd.bhvr with
            | HWBAnalog(expr) ->
              AlgebraicLib.UnifyEnv.define_pat_expr env portid
                (proc_expr expr.rhs)
            | HWBDigital(expr) ->
              AlgebraicLib.UnifyEnv.define_pat_expr env portid
                (proc_expr expr.rhs)
            | HWBAnalogState(expr) ->
              let ic_port,ic_prop = expr.ic in 
              let ic_id =
                proc_var (HwLib.port2hwid portd.knd
                            portd.comp ic_port ic_prop portd.typ)
              in
              AlgebraicLib.UnifyEnv.define_pat env ic_id;
              AlgebraicLib.UnifyEnv.define_pat_deriv_expr env portid
                (proc_expr expr.rhs) (Term(ic_id)) 
            | _ -> ()
          end
        | Some(expr) ->
            begin
            AlgebraicLib.UnifyEnv.define_pat env portid;
            AlgebraicLib.UnifyEnv.init_pat env portid expr;
            ()
          end
      );
    let hwvarport = HwLib.comp_getvar comp hwvar in
    let hwvarid = HwLib.port2hwid
        hwvarport.knd hwvarport.comp hwvarport.port hwvarport.prop
        hwvarport.typ
    in
    AlgebraicLib.UnifyEnv.pat_prioritize env (proc_var hwvarid);
   () 

  (*construct the hardware expression you wish to unify.
    This is always an input, so it does not have any dependencies
  *)
  let construct_hw_expr : unid AlgebraicLib.UnifyEnv.t -> hwvid hwenv ->
    hwvid -> unid ast -> unit =
    fun env hwenv portid hexpr ->
      AlgebraicLib.UnifyEnv.define_sym env (HwId portid);
      AlgebraicLib.UnifyEnv.define_sym_expr env (HwId portid) hexpr;
      ()

  (*
     this is the math expression.
  *)
  let construct_math : unid AlgebraicLib.UnifyEnv.t -> mid menv -> 
    string -> unit
    =
      fun (env) (menv) mname ->
        let mid = MathLib.str2mid menv mname in
        AlgebraicLib.UnifyEnv.define_sym env (MathId mid);
        MathLib.iter_vars menv (fun mvar ->
            let mid = MathLib.var2mid mvar in
            AlgebraicLib.UnifyEnv.define_sym env (MathId mid); 
            match mvar.bhvr with
            | MBhvStateVar(bhv) ->
              begin
                AlgebraicLib.UnifyEnv.define_sym_deriv_expr env
                  (MathId mid) (mast2uast bhv.rhs)
                  (ASTLib.number2ast bhv.ic);
                ()
              end
            | MBhvVar(bhv) ->
              begin
                AlgebraicLib.UnifyEnv.define_sym_expr env
                  (MathId mid) (mast2uast bhv.rhs);
                ()
              end
            | MBhvInput ->
              begin
                AlgebraicLib.UnifyEnv.define_sym_expr env
                  (MathId mid) (Term (MathId mid))
              end
            | _ ->
              error "construct_math" "unexpected"
          );
        MAP.iter menv.params (fun _ mparam ->
            let paramid = MathLib.str2mid menv mparam.name in
            AlgebraicLib.UnifyEnv.define_sym_param env
              (MathId paramid) [mparam.value]
          );
        AlgebraicLib.UnifyEnv.sym_prioritize env (MathId mid);
        ()


  let to_rsteps : (unid*unid ast) list -> rstep list
    -> rstep list =
    fun asgns init_steps ->
      print_string "--------\n";
      let new_steps = List.map (fun (v,e) ->
          let cfg = {expr=e} in
          print_string ((unid2str v)^"="^(uast2str e)^"\n");
          match v with
          | HwId(HNPort(HWKInput,cmp,port,prop)) ->
            RAddInAssign(port,cfg)
          | HwId(HNPort(HWKOutput,cmp,port,prop)) ->
            RAddOutAssign(port,cfg)
          | HwId(HNParam(cmp,param)) ->
            begin
              match e with
              | Integer(i) ->
                RAddParAssign(param,Integer i)
              | Decimal(d) ->
                RAddParAssign(param,Decimal d)
            end
        ) asgns
      in
      init_steps @ new_steps


  let solve_math menv comp cfg inst hwvar mvar steps : rstep list list =
    let un_env = AlgebraicLib.UnifyEnv.init () in
    construct_hw_comp un_env comp cfg inst hwvar;
    construct_math un_env menv mvar;
    let alg_env = AlgebraicLib.init () in
    let branching = Globals.get_glbl_int "unify-branch" in
    let restrict_size = Globals.get_glbl_int "unify-restrict-size" in
    let asgns = AlgebraicLib.unify alg_env un_env branching restrict_size in 
    List.map (fun asgn -> to_rsteps asgn steps) asgns

  let solve_hw hwenv comp cfg inst hwvar htargvar hexpr steps: rstep list list =
    let nslns = Globals.get_glbl_int "eqn-unifications" in
    let un_env = AlgebraicLib.UnifyEnv.init () in
    construct_hw_comp un_env comp cfg inst hwvar;
    construct_hw_expr un_env hwenv htargvar hexpr;
    let alg_env = AlgebraicLib.init () in 
    let asgns = AlgebraicLib.unify alg_env un_env nslns 1 in
    (*asgns to rsteps*)
    List.map (fun asgn -> to_rsteps asgn steps) asgns

  (* take the set of assignments, and convert to steps *)
  let get_solutions (env:runify) : (rstep list) list=
    let results : rnode list = SearchLib.get_solutions env.search None in
    (* convert to eqn steps*)
    List.map (fun result ->
        let steps : rstep list =
          SearchLib.get_path env.search result in
        LIST.uniq steps
      ) results

  
  let unify_comp_with_hwvar (hwenv:hwvid hwenv) (menv:mid menv)
      (comp:hwvid hwcomp) (cfg:hwcompcfg) (inst:int option)
      (hvar:string) (hwtargvar:hwvid) (hexpr:unid ast) (steps:rstep list) =
    (*let uenv :runify = ASTUnifyTree.mk_comp_search hwenv menv comp inst cfg hvar in*)
    (*unify_with_hwvar uenv hexpr steps*)
    solve_hw hwenv comp cfg inst hvar hwtargvar hexpr steps 

  let unify_comp_with_mvar (hwenv:hwvid hwenv) (menv:mid menv)
      (comp:hwvid hwcomp) (cfg:hwcompcfg) (inst:int option)
      (hvar:string)
      (mvar:string) =
    (*
    let uenv :runify = ASTUnifyTree.mk_comp_search hwenv menv comp inst cfg hvar in
    unify_with_mvar uenv mvar []
    *)
    solve_math menv comp cfg inst hvar mvar []

end
