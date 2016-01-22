open Common
open Globals

open HW
open HWData
open HWCstr

open Math
open MathCstr

open AST
open Util
open Unit

open SymCamlData

open Interactive

open SolverData
open SolverUtil
open SolverSln
open SolverSearch
open SolverRslv

open SpiceLib

(*
A solution is a set of connections  and components. A solution
may additionally contain any pertinent error and magnitude mappings
*)
exception SolverError of string

let error n m = raise (SolverError (n^":"^m))




module SolveLib =
struct
  let goals2str (g:goal set) =
    let goal2str g v =
      v^"\n"^(UnivLib.goal2str g)
    in
    SET.fold g goal2str ""


  let mkmenu (s:slvr) (v:gltbl) (g:goal option) =
    let menu_desc = "t=search-tree, s=sol, g=goals, any-key=continue, q=quit" in
    let rec menu_handle inp on_finished=
      if STRING.startswith inp "t" then
        let _ = Printf.printf "\n%s\n\n" (SearchLib.buf2str v.search) in
        let _ = on_finished() in
        ()
      else if STRING.startswith inp "s" then
        let _ = Printf.printf "\n%s\n\n" (SlnLib.tostr v.sln) in
        let _ = on_finished() in
        ()
      else if STRING.startswith inp "goto" then
        let _ = match STRING.split inp " " with
        | [_;id] ->
          let nid = int_of_string id in
          let _ = SearchLib.move_cursor s v (SearchLib.id2node v.search nid) in
          ()
        | _ -> ()
        in
        let _ = on_finished() in
        ()
      else if STRING.startswith inp "g" then
        let _ = Printf.printf "==== Goals ===" in
        let _ = Printf.printf "%s\n" (goals2str v.goals) in
        let _ = Printf.printf "============\n\n" in
        ()
      else if STRING.startswith inp "c" then
        let _ = match g with
          | Some(g) -> let _ = Printf.printf ">>> target goal: %s\n\n" (UnivLib.goal2str g)  in ()
          | None -> Printf.printf "<no goal>"
        in
        ()
      else
        ()
    in
    let internal_menu_handle x = menu_handle x (fun () -> ()) in
    let rec user_menu_handle () = menu s (fun x -> menu_handle x user_menu_handle) menu_desc in
    internal_menu_handle,user_menu_handle


  let goal2str g = UnivLib.urel2str g

  let mkslv h p i = {interactive=i; hw=h; prob=p; max_depth=__max_depth; cnt=0;}

  let mktbl s : gltbl =
    (* add all relations to the tableau of goals. *)
    let rm_pars x : unid ast option =
      match x with
      | Term(HwId(HNParam(c,n,v,p))) -> Some (ast_of_number (v))
      | Term(MathId(MNParam(n,v,u))) ->Some (ast_of_number (v))
      | _ -> None
    in

    let simpl v : unid ast =
      (*let declunid = Shim.unid2sym "N/A" (-1) in
      let _ = Printf.printf "simplify: %s -> " (UnivLib.uast2str v) in
      let vq = ASTLib.simpl v UnivLib.unid2var (UnivLib.var2unid s) declunid in
      let _ = Printf.printf "%s\n" (UnivLib.uast2str vq) in
      vq
      *)
      v
    in
    let math2goal (x:mvar) =
      let m2u = UnivLib.mid2unid in
      let tf x =
        let t = ASTLib.trans (ASTLib.map x m2u) rm_pars in
        let tsimpl = simpl t in
        tsimpl
      in
      match x.rel with
      | MRFunction(l,r) -> UFunction(m2u l, tf r)
      | MRState(l,r,x) ->
        let time = (MathLib.getvar s.prob (OPTION.force_conc s.prob.time)).typ in
        UState(m2u l, tf r, m2u x, m2u time)
      | MRNone -> error "math2goal" "impossible."
    in
    let fltmath x = x.rel <> MRNone in
    let comp2node (c:hwcomp) =
      let nvars = List.filter (fun (x:hwvar) -> x.rel <> HRNone) (MAP.to_values (c.vars)) in
      let var2urel (x:hwvar) =
        let h2u = UnivLib.hwid2unid in
        let tf x = ASTLib.trans (ASTLib.map x h2u) rm_pars in
        match x.rel with
        | HRFunction(l,r) -> UFunction(h2u l, tf r)
        | HRState(l,r,i) ->
          let time = HNTime(HCMLocal(c.name),c.time) in
          UState(h2u l, tf r, h2u i, h2u time)
        | _ -> error "math2goal.comp2node" "impossible"
      in
      let nrels = List.map var2urel nvars in
      let n = {rels=SET.from_list nrels; name=c.name} in
      n
    in
    let nodetbl : (unodeid,unode) map = MAP.make () in
    let rels : urel list = List.map math2goal (List.filter fltmath (MAP.to_values s.prob.vars)) in
    let sln = SlnLib.mksln () in
    let nodes : unode list = List.map comp2node (MAP.to_values s.hw.comps) in
    let handle_node (x) =
       let nid = UnivLib.name2unodeid x.name in
       let _ = MAP.put nodetbl nid x in
       let _ = SlnLib.mkcomp sln nid in
       ()
    in
    let _ = List.iter (fun x -> handle_node x) nodes in
    let init_cursor,search= SearchLib.mkbuf (rels) in
    let tbl = {goals=SET.make (fun x y -> x = y); dngl=MAP.make(); nodes=nodetbl; sln=sln; search=search} in
    let tbl = SearchLib.move_cursor s tbl init_cursor in
    tbl


  let mkconn s t sw dw pr =
    if sw = dw then [] else
    [SSolAddConn(sw,dw)]
    (*
    match ifover_mkcopier s t sw pr with
    | Some(steps,nsw) ->
      SSolAddConn(nsw,dw)::steps
    | None ->
      [SSolAddConn(sw,dw)]
    *)



  let is_trivial g =
    match g with
    | UFunction(id,Decimal(_)) -> true
    | UFunction(id,Integer(_)) -> true
    | UFunction(HwId(HNPort(k1,c1,v1,prop1,u1)),Term (HwId(HNPort(k2,c2,v2,prop2,u2))) )  ->
        if prop1 = prop2 then true else false
    | UFunction(MathId(v),Term(HwId(_))) -> true
    | UFunction(HwId(v),Term(MathId(_))) -> true
    | _ -> false
    (*
    determine if a label is mapping
  *)
  let hwkind2wire (slvr:slvr) (sln:sln) (id:unodeid) (inst:int) (knd:hwvkind) =
    let identname = UnivLib.unodeid2name id in
    let ivar = HwLib.get_port_by_kind slvr.hw knd identname in
    let wire : wireid = (id,inst,ivar.name) in
    let prop,_ = MAP.singleton (HwLib.getprops slvr.hw identname ivar.name) in
    let wid = SlnLib.wire2uid slvr.hw wire prop in
    wid, wire, prop

  let mkinp  (slvr:slvr) (sln:sln) wire prop (lbl:label) =
    let ident = UNoInput(prop) in
    if (SlnLib.usecomp_valid slvr sln ident) = false then
      error "mkinp" "cannot make input port."
    else
      (*let comp = HwLib.getcomp s.hw node.name in*)
      let inst = SlnLib.usecomp sln ident in
      let usenode = SSolUseNode(ident,inst) in
      let wid = SlnLib.wire2uid slvr.hw wire prop in
      let iid,iwire,iprop = hwkind2wire slvr sln ident inst HNInput in
      let oid,owire,oprop = hwkind2wire slvr sln ident inst HNOutput in
      let connport = SAddGoal(UFunction(oid,Term(wid))) in
      let bindlbl = SSolAddLabel(iwire, iprop, lbl) in
      let bindlbl2 = SSolAddLabel(owire, oprop, lbl) in
      [usenode; connport;bindlbl;bindlbl2]

  let mkout (slvr:slvr) (sln:sln) wire prop (lbl:label) =
    let ident = UNoOutput(prop) in
    if (SlnLib.usecomp_valid slvr sln ident) = false then
      error "mkinp" "cannot make input port."
    else
      (*let comp = HwLib.getcomp s.hw node.name in*)
      let inst = SlnLib.usecomp sln ident in
      let usenode = SSolUseNode(ident,inst) in
      let wid = SlnLib.wire2uid slvr.hw wire prop in
      let iid,iwire,iprop = hwkind2wire slvr sln ident inst HNInput in
      let oid,owire,oprop = hwkind2wire slvr sln ident inst HNOutput in
      let connport = SAddGoal(UFunction(iid,Term(wid))) in
      let bindlbl = SSolAddLabel(owire, oprop, lbl) in
      let bindlbl2 = SSolAddLabel(iwire, iprop, lbl) in
      [usenode;connport;bindlbl;bindlbl2]

  let rslv_label (slvr:slvr) (sln:sln) (wire:wireid) (prop:propid) (name:mid) (knd:hwvkind) : step list =
    (*find all pending input connections with same label*)
    let conn_inputs nwire nprop (nm:mid) =
      let conv w p l =
        let snk : unid = SlnLib.wire2uid slvr.hw wire prop in
        let src : unid = SlnLib.wire2uid slvr.hw nwire nprop in
        let add_goal = SAddGoal(UFunction(src,Term(snk))) in
        let rm_lbl = SSolRemoveLabel(w,p,l) in
        [add_goal; rm_lbl]
      in
      let lbls : (wireid*propid*label) list = SlnLib.get_labels sln
        (fun w p x -> match x with LBindVar(_,v) -> v = nm | _ -> false)
      in
      let steps : step list = List.fold_right (fun (w,p,l) r -> r @ (conv w p l)) lbls [] in
      steps
    in
    (*find all existing inputs with same label*)
    let find_input nwire nprop nm =
      let lbls : (wireid*propid*label) list = SlnLib.get_labels sln
        (fun w p x -> match x with LBindVar(_,v) -> v = nm && p = nprop | _ -> false)
      in
      match lbls with
      | [] ->
        let stps = mkinp slvr sln nwire nprop (LBindVar(HNInput,name)) in
        stps
      | [(w,p,l)] ->
        let snk : unid = SlnLib.wire2uid slvr.hw w p in
        let src : unid = SlnLib.wire2uid slvr.hw nwire nprop in
        let add_goal = SAddGoal(UFunction(src,Term(snk))) in
        let rm_lbl = SSolRemoveLabel(w,p,l) in
        [add_goal; rm_lbl]
      | _ ->
        error "rslv_label.find_input" "too many labels."
    in
    let conn_if_exists wire prop name =
      (*Find any output labels*)
      let lbls : (wireid*propid*label) list = SlnLib.get_labels sln
        (fun w p x -> match x with LBindVar(k,v) -> v = name && p = prop && k = HNOutput | _ -> false)
      in
      match lbls with
      | [(ow,op,ol)] ->
        let snk : unid = SlnLib.wire2uid slvr.hw ow op in
        let src : unid = SlnLib.wire2uid slvr.hw wire prop in
        let add_goal = SAddGoal(UFunction(src,Term(snk))) in
        [add_goal]
      | [] ->
        let stp = SSolAddLabel(wire,prop,LBindVar(HNInput, name)) in
        [stp]
    in
    (*all the wires that needed to be assigned labels*)
    match (knd, (MathLib.getkind slvr.prob (MathLib.mid2name name)) ) with
    (*output value, resolve labels that are buffering on this by making connections back.
    if this variable is marked as an output by the menv, connect to an output port*)
    | (HNOutput, Some MOutput) ->
      let conn_outs = conn_inputs wire prop name in
      let outport = mkout slvr sln wire prop (LBindVar (HNOutput,name)) in
      conn_outs @ outport
      (*create an output port and map all inputs*)
    | (HNOutput, Some MLocal) ->
      let conn_outs = conn_inputs wire prop name in
      conn_outs
    (*input value, add to buffer if variable is also local. Otherwise, map to a port.*)
    | (HNInput, Some MInput) ->
      let conn_ins = find_input wire prop name in
      conn_ins
      (*determine if the input is already mapped.*)
    | (HNInput, Some MLocal) ->
      let stps = conn_if_exists wire prop name in
      stps
      (*add label to this wire, do not create input*)
    | (HNInput, Some MOutput) ->
      let stps = conn_if_exists wire prop name in
      stps
    | (HNInput, None) ->
      let conn_ins = find_input wire prop name in
      conn_ins
      (* add label to this wire, don't create an input *)
    | (_,None) -> error "rslv_label" ("bound label is not a variable: "^
          "wire <-> "^(MathLib.mid2name name))

    | (_,Some MLocal) -> error "rslv_label" ("bound label is a local variable: "^
          "wire <-> "^(MathLib.mid2name name))

    | (_,Some MOutput) -> error "rslv_label" ("bound label is a output variable: "^
          "wire <-> "^(MathLib.mid2name name))

    | (_,Some MInput) -> error "rslv_label" ("bound label is an input variable: "^
          "wire <-> "^(MathLib.mid2name name))


  let rslv_value (slvr:slvr) (sln:sln) (wire:wireid) (prop:propid) (valu:number) knd =
    let find_input (nwire:wireid) (nprop:propid) (nval:number) =
      let print_labels lbls : unit =
        let _ = List.iter (fun (w,p,l) ->
          Printf.printf "%s %s %s\n" (SlnLib.wire2str w) p (SlnLib.label2str l)
        ) lbls in ()
      in
      let is_input_comp c = match c with
      | UNoInput(_) -> true
      | _ -> false
      in
      let lbls : (wireid*propid*label) list = SlnLib.get_labels sln
        (fun w p x -> match x with LBindValue(v) ->
          let c,_,_ = w in
          p = nprop && is_input_comp c &&
          MATH.cmp_numbers v valu 0.000000000001
          | _ -> false)
      in
      let nlbl = LBindValue(nval) in
      let _ = print_labels lbls in
      match lbls with
      | [] ->
        let stps = mkinp slvr sln nwire nprop (nlbl) in
        let rm_lbl = SSolRemoveLabel(nwire,nprop,nlbl) in
        let _ = Printf.printf "# Make New: %s\n" (string_of_number valu) in
        rm_lbl::stps
      | (w,p,l)::[] ->
        let _ = Printf.printf "# Reuse : %s\n" (string_of_number valu) in
        let src : unid = SlnLib.wire2uid slvr.hw w p in
        let snk : unid = SlnLib.wire2uid slvr.hw nwire nprop in
        let add_goal = SAddGoal(UFunction(snk,Term(src))) in
        let rm_lbl = SSolRemoveLabel(nwire,nprop,nlbl) in
        [add_goal; rm_lbl]
      | h::t ->
        let _ = Printf.printf "# Failed : %s\n" (string_of_number valu) in
        let _ = print_labels lbls in
        error "rslv_value" "too many bindings."
    in
    match knd with
    (*impossible to map an output to a value*)
    | HNOutput ->
      error "rslv_value" "impossible situation."
    (*impossible to map an input to a value*)
    | HNInput ->
      let stps = find_input wire prop (valu) in
      stps


  let get_trivial_step (s:slvr) (t:gltbl) g : step list =
    let apply_steps stps =
      let res =
        let _ = SearchLib.apply_steps s t {s=stps;id=0} in
        stps
      in
      res
    in
    match g with
      (*check for duplicates*)
    | UFunction(HwId(HNPort(k1,c1,v1,prop1,u1)),Term (HwId(HNPort(k2,c2,v2,prop2,u2))) )  ->
        if prop1 = prop2 then
          let src = SlnLib.hwport2wire c1 v1 in
          let snk = SlnLib.hwport2wire c2 v2 in
          let conn = mkconn s t src snk prop1 in
          conn
        else error "get_trivial_step" "is nontrivial."
    | UFunction(HwId(HNPort(k,c,v,prop,u)),Decimal(q)) ->
        let wire = SlnLib.hwport2wire c v in
        let stps = rslv_value s t.sln wire prop (Decimal q) k in
        apply_steps stps

    | UFunction(HwId(HNPort(k,c,v,prop,u)),Integer(q)) ->
        let wire = SlnLib.hwport2wire c v in
        let stps = rslv_value s t.sln wire prop (Integer q) k in
        apply_steps stps

    | UFunction(HwId(HNPort(k,c,v,prop,u)), Term(MathId(q)) ) ->
        let wire = SlnLib.hwport2wire c v in
        let stps = rslv_label (s) t.sln wire prop q k in
        apply_steps stps

    | UFunction(MathId(q), Term(HwId(HNPort(k,c,v,prop,u))) ) ->
        let wire = SlnLib.hwport2wire c v in
        let stps = rslv_label (s) (t.sln) wire prop q k in
        apply_steps stps

    | UFunction(MathId(MNTime(um)), Term (HwId(HNTime(cmp,uh))) ) ->
        let tc = () in
        []

    | UFunction(HwId(HNTime(cmp,uh)), Term (MathId(MNTime(um))) ) ->
        let tc = () in
        []

    | _ -> []

  let resolve_trivial s t goals =
    let handle_goal g =
      if is_trivial g then
        let _ = SearchLib.add_step t.search (SRemoveGoal g) in
        let steps = get_trivial_step s t g  in
        let _ = List.iter (fun x -> let _ = SearchLib.add_step t.search x in ()) steps in
        ()
    in
    let goal_cursor = SearchLib.cursor t.search in
    if (SET.fold goals (fun x r -> if is_trivial x then r+1 else r) 0) > 0 then
      let _ = SearchLib.start t.search in
      let _ = SET.iter goals handle_goal in
      let trivial_cursor = SearchLib.commit t.search in
      (*let _ = SearchLib.deadend t.search goal_cursor in*)
      let _ = SearchLib.move_cursor s t trivial_cursor in
      trivial_cursor
    else
    goal_cursor

  let canon_hw_assign lhs rhs : (unid*(unid ast)) option =
    match rhs with
    | Term(rhs_term) ->
      begin
        match lhs,rhs_term with
        | (HwId(HNPort(k1,c1,v1,p1,u1)),HwId(HNPort(k2,c2,v2,p2,u2))) ->
          (*hw ports must have an input = output pattern*)
          if k1 = HNOutput && k2 = HNInput then
            Some (HwId(HNPort(k2,c2,v2,p2,u2)),Term(HwId(HNPort(k1,c1,v1,p1,u1))))
          else if k1 = HNInput && k2 = HNOutput then
              Some(lhs,rhs)
          else if k1 = HNOutput && k2 = HNOutput && lhs <> rhs_term then
            None
          else if k1 = HNInput && k2 = HNInput  && lhs <> rhs_term then
            None
          else
            Some (lhs,rhs)
        | _ ->
            Some (lhs,rhs)
      end
    | _ -> Some(lhs,rhs)

  let unify_exprs (s:slvr) (name:string) (inst_id:int) (gl:unid) (gr:unid ast) (nl:unid) (nr:unid ast) : ((unid,unid ast) map) list option =
    (*declare event*)
    let declwcunid = Shim.unid2wcsym name inst_id in
    let n_tries = __pattern_depth in
    let res = ASTLib.pattern nr gr UnivLib.unid2var (UnivLib.var2unid (s)) declwcunid n_tries in
    (*let _ = match res with
      Some(res) ->
      (Printf.printf "%s | %s <-> %s // count %d\n"
      name (UnivLib.uast2str gr) (UnivLib.uast2str nr) (List.length res)
      | _ -> Printf.printf "%s | %s <-> %s // count %d\n"
      name (UnivLib.uast2str gr) (UnivLib.uast2str nr) (0)
    in*)
    res

  let unify_rels (s:slvr) (name:string) (inst_id:int) (g:urel) (v:urel) : (unid,unid ast) map list option=
    match (Shim.rel_lcl2glbl inst_id g),(Shim.rel_lcl2glbl inst_id v) with
    | (UFunction(gl,gr), UFunction(nl,nr))->
      let res = unify_exprs s name inst_id gl gr nl nr in
      let ret = match res with
          | Some(res) ->
            let lhs = canon_hw_assign (nl) (Term gl) in
            begin
            match lhs with
            | Some(gllhs,glrhs) ->
              let _ = List.iter (fun mp -> let _ = MAP.put mp gllhs glrhs in () ) res in
              Some(res)
            | _ -> None
            end
          | None -> None
      in
        ret

    | (UState(gl,gr,gic,gt), UState(nl,nr,nic,nt))->
      let res = unify_exprs s name inst_id gl gr nl nr in
      let ret = match res with
        | Some(res) ->
            let lhs = canon_hw_assign (nl) (Term gl) in
            let ic = canon_hw_assign (nic) (Term gic) in
            let t = canon_hw_assign (nt) (Term gt) in
            begin
            match lhs,ic,t with
            | (Some(glhs,nlhs),Some(gic,nic),Some(gt,nt)) ->
              let _ = List.iter (fun mp -> let _ = MAP.put mp glhs nlhs in () ) res in
              let _ = List.iter (fun mp -> let _ = MAP.put mp gic nic in () ) res in
              let _ = List.iter (fun mp -> let _ = MAP.put mp gt nt in () ) res in
              Some(res)
            | (_) -> None
            end
        | None -> None
      in
        ret
    | _ ->
      None


  let resolve_assigns  s (name:string) (iid:int) (rel:urel) (g:goal) (all_rels:urel set) (all_goals:goal set) (assigns: (unid,unid ast) map) : (step list) option=
    (*get an id, given a goal*)
    let get_id urel =
      match urel with
      | UFunction(l,_) -> l
      | UState(l,_,_,_) -> l
    in
    let get_rel id lst = List.fold_right (fun q r -> if (get_id q) = id then Some(q) else r) lst None in
    (*substitute expression with concretized goals*)
    let sub_rel (rel:urel) assigns : urel =
      let mksubs (repls: (unid*unid ast) list) =
        let nassigns = MAP.map assigns (
            fun k v ->
              let ll = List.filter (fun (q,v) -> q = k) repls
              in
              if (List.length ll) > 0
              then let k2,v2 = List.nth ll 0 in v2
              else v
            )
        in
        nassigns
      in
      let repl_var (n)  : unid =
        if MAP.has assigns n then
          let res =
            match MAP.get assigns n with
            | Term(v) -> v
            | _ -> n
          in
            res
        else n
      in
      match rel with
      | UFunction(nl,nr) ->
        let snl = repl_var nl in
        (*let asgn = mksubs [(nl,Term(snl))] in*)
        let asgn = assigns in
        let snr = ASTLib.sub nr asgn in
        UFunction(nl,snr)

      | UState(nl,nr,nic,nt) ->
        let snl = repl_var nl in
        let snic = repl_var nic in
        let snt = repl_var nt in
        (*let asgn = (mksubs
          [
          (nl,Term(snl));
          (nic,Term(snic));
          (nt,Term(snt))
          ])
        in*)
        let asgn = assigns in
        let snr = ASTLib.sub nr asgn in
        UState(nl,snr,snic,snt)

    in
    let resolve_goal curr_goal others =
      match curr_goal with
      | UFunction(HwId(q),Term(MathId(z))) ->
        let res = match get_rel (MathId z) others with
        | Some(new_goal) -> new_goal
        | None -> curr_goal
        in
        res
      | _ -> curr_goal
    in
    (*
    ========
    MAIN ROUTINE
    ========
    *)
    let other_goals = SET.filter all_goals (fun x -> x <> g)  in
    let other_rels = List.map
      (fun q -> Shim.rel_lcl2glbl iid q) (SET.filter all_rels (fun x -> x <> rel))
    in
    (*determine if the assignment is ever on the left hand side of a relation*)
    (*take a mapping*)
    let rec solve_assign id expr assigns other_rels other_goals : (step list) option =
      let goal = UFunction(id,expr) in
      match get_rel id other_rels with
      | Some(orel) ->
        (* this is the concretized version of the relation
          if this fails  *)
        let orelsub = sub_rel orel assigns in
        let ngoal = resolve_goal goal other_goals in
        (*force unification between the expression and goal *)
        let un = unify_rels s name iid ngoal orelsub in
        (*id this works, we have resolved the goal of interest successfully by applying another node.*)
        let psteps = [SRemoveGoal(ngoal)] in
        let res = match un with
          | Some(sols) ->
            let other_rels = List.filter (fun x -> x <> orel) other_rels in
            let other_goals = List.filter (fun x -> x <> ngoal) other_goals in
            let try_sln sln =
              (*create a new map containg the new bindings and old bindings*)
              let cassigns = MAP.copy assigns in
              let _ = MAP.iter sln (fun k v -> let _ = MAP.put cassigns k v in ())  in
              (*ensure each assignment is acceptable*)
              let result = MAP.fold sln (fun id expr lst ->
                let res = solve_assign id expr cassigns other_rels other_goals in
                match res,lst with
                | (Some(goals),Some(rest)) -> Some(goals@rest)
                | (None,_) -> None
                | (_,None) -> None
              ) (Some psteps)
              in
              result
            in
            (*find one valid solution out of all possible solutions*)
            let result = List.fold_right ( fun sln curr ->
                let psln = try_sln sln in
                match psln with
                | (Some(s)) ->  psln
                | None -> curr
              ) sols None
            in
            result
          (*no solution: this entire solution doesn't apply*)
          | None ->
            None
        in
          res
      | None ->
        (*not bound locally.*)
        Some([SAddGoal(UFunction(id,expr))])
    in
    let proc k v rest =
      let res = solve_assign k v assigns other_rels other_goals in
      match res,rest with
      | (None,_) ->
        None
      | (Some(lst),Some(rest)) ->
        Some(lst @ rest)
      | _ -> None
    in
    (*
    All the add goals are new assignments. THerefore, let's weed out all the rels
    that exist in the goal list.
    *)
    let leftovers gls  =
      let asg = MAP.make () in
      let _ = List.iter (fun x ->
        match x with
          | SAddGoal(UFunction(id,expr)) -> let _ = MAP.put asg id expr in ()
          | _ -> ()
      ) gls
      in
      let rrels = List.filter (fun x -> (MAP.has asg (get_id x)) = false ) other_rels in
      let srrels = List.map (fun x ->  sub_rel x asg) rrels in
      if List.length srrels > 0 then
        [SAddNode(UnivLib.name2unodeid name,iid,srrels)]
      else
        []
    in
    let final = MAP.fold assigns (fun k v r -> proc k v r ) (Some [])  in
    let res = match final with
    | Some(q) ->
      let l = leftovers q in
      let q = l @ q in
      (*this means that all mappings that are outputs have been resolved. We should compute the rest*)
      Some(q)
    | None ->  None
    in
    res




  let apply_node (s:slvr) (gtbl:gltbl) (g:goal) (node_id:unodeid) (node:unode) : int option =
    (*see if it's possible to use the component. If it iscontinue on. If not, do not apply node*)
    if (SlnLib.usecomp_valid s gtbl.sln node_id) = false then None else
    (*let comp = HwLib.getcomp s.hw node.name in*)
    let inst_id = SlnLib.usecomp gtbl.sln node_id in
    (*update search algorithm to include the usage*)
    let _ = SearchLib.start gtbl.search in
    let _ = SearchLib.add_step gtbl.search (SSolUseNode(node_id,inst_id)) in
    (*the cursor associated with the goal*)
    let goal_cursor = SearchLib.cursor gtbl.search in
    (*the cursor associated with the component*)
    let comp_cursor : steps = SearchLib.commit gtbl.search in
    (*use node*)
    let _ = SearchLib.move_cursor s gtbl comp_cursor in
    (*
      this tries to find a set of solutions for the particular node. Each of these solutions is a branch.
    *)
    let add_sln (rls:urel set) (gl:goal) (r:urel) (assigns: (unid,unid ast) map)  =
      let _ = SearchLib.start gtbl.search in
      (*say you have attained the goal*)
      let ngoals = resolve_assigns s (node.name) inst_id r gl rls gtbl.goals assigns in
      match ngoals with
      | Some(sts) ->
        let _ = SearchLib.move_cursor s gtbl comp_cursor in
        let _ = SearchLib.add_step gtbl.search (SRemoveGoal gl) in
        let _ = List.iter (fun x -> SearchLib.add_step gtbl.search x) sts in
        let sol_cursor = SearchLib.commit gtbl.search in
        let _ = SearchLib.move_cursor s gtbl sol_cursor in
        let triv = resolve_trivial s gtbl gtbl.goals in
        let _ = SearchLib.move_cursor s gtbl triv in
        true

      | None ->
        false
    in
    let apply_rel rel amt =
      let res : (unid,unid ast) map list option = unify_rels s node.name inst_id g rel in
      match res with
      | Some(assigns) ->
        let cnt = List.fold_right (fun asn cnt -> if add_sln node.rels g rel asn then cnt + 1 else cnt) assigns 0 in
        cnt+amt
      | None -> amt
    in
    let cnt = SET.fold node.rels apply_rel 0 in
    let _ = SearchLib.move_cursor s gtbl goal_cursor in
    let _ = Printf.printf "comp %s: %d\n" node.name cnt in
    if cnt = 0 then
        let _ = SearchLib.rm gtbl.search comp_cursor in
        let _ = SlnLib.usecomp_unmark gtbl.sln node_id inst_id in
        None
      else
        let _ = SearchLib.visited gtbl.search comp_cursor in
        Some(cnt)



  let apply_nodes (slvenv:slvr) (tbl:gltbl) (g:goal) : unit =
    let comps = MAP.filter tbl.nodes (fun k v -> match k with UNoComp(_) -> true | _ -> false)  in
    let rels = MAP.filter tbl.nodes (fun k v -> match k with UNoConcComp(_) -> true | _ -> false)  in
    let handle_node (id,x) status =
      let yielded_results = apply_node slvenv tbl g id x in
      match yielded_results with
      | Some(q) -> Some(q)
      | None -> status
    in
    let res = List.fold_right handle_node rels None  in
    let res = List.fold_right handle_node comps res  in
    (*mark goal as explored.*)
    let goal_cursor = SearchLib.cursor tbl.search in
    (*let _ = SearchLib.deadend tbl.search goal_cursor in*)
    (* failed to find any solutions.. *)
    if res = None then
      let _ =  SearchLib.deadend tbl.search goal_cursor in
      ()
    else ()

  let path_is_impossible (s:slvr) (v:gltbl) =
    let is_valid = if HwConnRslvr.is_valid_shallow s v.sln
      then true else false
    in
     is_valid = false


  let path_is_useless v n =
    let build_gl (x:step) (adds,reds) = match x with
      | SAddGoal(g) -> let gl = Shim.rel_glbl2lcl g in
        if is_trivial g = false then (gl::adds, reds) else (adds,reds)
      | SRemoveGoal(g) -> let gl = Shim.rel_glbl2lcl g in
        if is_trivial g = false then (adds, gl::reds) else (adds,reds)
      | _ -> (adds,reds)
    in
    let judge adds reds =
      let cycle_set = List.filter (fun q -> LIST.count adds q > 1) reds  in
      let red_set = List.filter (fun q -> LIST.count adds q > 1 ) reds  in
      let print set =
        let str = List.fold_right (fun x r -> r^(goal2str x)^"\n") set "" in
        Printf.printf "%s\n" str
      in
      match cycle_set,red_set with
      | [],[] -> false
      | _,[] ->
        let _ = print cycle_set in
        let _ = Printf.printf "cycle detected\n" in
        true
      | [],_ ->
        let _ = print red_set in
        let _ = Printf.printf "redundent pattern detected\n" in
        true
      | _,_ ->
        let _ = print cycle_set in
        let _ = Printf.printf "cycle detected\n" in
        let _ = print red_set in
        let _ = Printf.printf "redundent pattern detected\n" in
        true
    in
    let icgl = ([],[]) in
    let adds,reds  = SearchLib.fold_path v.search n build_gl icgl in
    judge adds reds

  let select_best_path (v:gltbl) (cnode:steps option) : steps option =
    let ngoals (s:steps) =
      let score g =
        let cplx = (UnivLib.goal2complexity g) in
        (*let lru = ((float_of_int (ftbl_lru g))) in
        let lru = if lru > 30. then 30. else lru in
        let lru = float_of_int (RAND.rand_int(10)) in*)
        let lru = 0. in
        let score = cplx+.lru in
        score
      in
      SearchLib.fold_path v.search s (fun x r ->
        match x with
        | SAddGoal(g) -> r-.(score g)
        | SRemoveGoal(g) -> r+.(score g)
        | _ -> r
        ) 0.
    in
    let score_path (s:steps) : float =
      let score = ngoals s in
      match cnode with
      | Some(n) ->
        (*)
        if s = n && RAND.rand_norm() < 0.99 then
          100000.
        else
        *)
        score
      | None -> score
    in
    let paths = SearchLib.get_paths v.search in
    let _ = Printf.printf "# Paths Left: %d\n" (List.length paths) in
    match paths with
    | [] -> None
    | h::t ->
      let _,best = LIST.max (fun x -> score_path x) paths in
      Some(best)





  let rec get_next_path s v c =
    match select_best_path v c with
    | Some(p) ->
      let depth =  List.length (TREE.get_path v.search.paths p) in
      if depth >= s.max_depth
        then
          let _ = Printf.printf "hit max depth for path\n" in
          let _ = SearchLib.deadend v.search p in
          match c with
          |Some(q) ->
            if p = q then get_next_path s v None
            else get_next_path s v (Some q)
          | None ->
            get_next_path s v None
        else
          Some (p)
    | None ->
      let _ = Printf.printf "no valid paths left\n" in
      None


  let is_goal_in_play gs (targ:mid) = match gs with
  | UState(MathId(q),_,_,_) -> q = targ
  | UFunction(MathId(q),_) -> q = targ
  | _ -> true

  let choose_goal (gs:goal set) (target:mid) =
    let gflt = SET.filter gs (fun g -> is_goal_in_play g target ) in
    let g = LIST.rand gflt in
    g

  let is_no_goals_left (gs:goal set) target =
    let gnum = SET.fold gs (fun g r ->
        if is_goal_in_play g target then r+1 else r) 0
    in
    gnum = 0


  let rec solve_sim_eqn (_s:slvr ref) (v:gltbl) (target:mid) : steps option=
    let s = REF.dr _s in
    (*apply the current step in the search algorithm*)
    (*choose a goal in the table*)
    let move_to_next c =
      match get_next_path s v c with
        | Some(p) ->
          let _ = SearchLib.move_cursor s v p in
          true
        | None ->
          false
    in
    let failed solve_goal =
      (*mark this path as visited*)
      let goal_cursor = SearchLib.cursor v.search in
      let _ = SearchLib.deadend v.search goal_cursor in
      let succ = move_to_next None in
      if succ = false
        then
          None
        else
          let res = solve_goal () in
          res
    in
    let no_goals_left solve_goal =
      let _ = Printf.printf "SOLVER ==> Testing Solution\n" in
      let mint,musr = mkmenu s v None in
      let _ = flush_all() in
      let _ = mint "s" in
      if SlnLib.usecomp_cons s v.sln  then
        if SlnLib.mkconn_cons s v.sln then
          let _ = Printf.printf "SOLVER ==> Found valid solution.\n" in
          let _ = flush_all() in
          let cnode = SearchLib.cursor v.search in
          Some cnode
        else
          let _ = Printf.printf "SOLVER ==> Solution does not satisfy connection constraints.\n" in
          let _ = flush_all() in
          let _ = wait s in
          let x = failed solve_goal in
          x
      else
        let _ = Printf.printf "SOLVER ==> Solution does not satisfy component count constraints.\n" in
        let _ = flush_all() in
        let x = failed solve_goal in
        x
    in
    let rec solve_goal () =
      let _  = flush_all() in
      let triv = resolve_trivial s v v.goals in
      let _ = SearchLib.move_cursor s v triv in
      let goal_cursor = SearchLib.cursor v.search in
      (*if this cursor is dead for some reason*)
      if SearchLib.is_deadend v.search goal_cursor then
        let _ = Printf.printf "SOLVER => Path is deadend.\n" in
        failed solve_goal
      else
      (*please don't enable me, i have issues with deleting te current cursor*)
      (*let _ = SearchLib.cleanup v.search in*)
      (*print goals*)
      let mint,musr= mkmenu s v None in
      (*let _ = mint "g" in*)
      (*do we have any goals. *)
      if is_no_goals_left v.goals target then
        let res = no_goals_left solve_goal in
        res
      else
        (*check for repeated patterns*)
        if path_is_impossible s v || false
          (* path_is_useless v goal_cursor*)
        then
          let _ = Printf.printf "SOLVER => Path is impossible.\n" in
          let mint,musr= mkmenu s v None in
          let _ = SearchLib.deadend v.search goal_cursor in
          let succ = move_to_next (None) in
          if succ = false then None else
            let res = solve_goal () in
            res
        else
          let g = choose_goal v.goals target in
          (*mark this goal as used*)
          (*let _ = ftbl_use g in*)
          let mint,musr = mkmenu s v (Some g) in
          (*show goals and current solution*)
          (*let _ = mint "s" in*)
          let _ = mint "c" in
          let _ = apply_nodes s v g in
          let _ = musr () in
          let succ = move_to_next (Some goal_cursor) in
          (*if could not move to next, exit*)
          if succ = false then None else
            let res = solve_goal () in
            res
    in
    let r = solve_goal () in
    r

    let search2tbl s (rf) icurs (st) :gltbl =
      let sln = SlnLib.mksln () in
      let nodetbl : (unodeid,unode) map = MAP.make () in
      let handle_node (x) =
         let nid = UnivLib.name2unodeid x.name in
         let _ = MAP.put nodetbl nid x in
         let _ = SlnLib.mkcomp sln nid in
         ()
      in
      let _ = List.iter (fun x -> handle_node x) (MAP.to_values rf.nodes) in
      let v =  {
         goals = SET.make (fun x y -> x = y);
         nodes = nodetbl;
         dngl = MAP.make();
         search= st;
         sln= sln;
      } in
      let v = SearchLib.move_cursor s v icurs in
      v

    (*
    Continue working on this.
    *)
    let solve_topology _s v =
      let s = REF.dr _s in
      let init_goals = LIST.shuffle (SET.to_list v.goals) in
      let _ = Printf.printf "====Solving===\n" in
      (*makes a new table, where the node immediately following the goalnode is a sequence of steps.*)
      let mknewtbl (steps: step list)  (gls:goal list)=
        (*new buffer*)
        let start,stree = SearchLib.mkbuf gls in
        let tbl = search2tbl s v start stree in
        let _ = SearchLib.start stree in
        (*new initial node*)
        let _ = List.iter (fun x -> SearchLib.add_step stree x) steps in
        let p = SearchLib.commit stree in
        let _ = SearchLib.move_cursor s tbl p in
        tbl
      in
      (*get the steps from a particular node*)
      let get_steps v n =
        (*given a node and the table, get the delta between the solution node and the current node*)
        let path = SearchLib.get_path v.search n in
        path
      in
      let get_mid g = match g with
      | UState(MathId(m),_,_,_) -> m
      | UFunction(MathId(m),_) -> m
      | _ -> error "get_mid" "expected goal with mid on the other end."
      in
      let rec try_solve (ctx:step list) goals =
        let rec attempt (new_tbl:gltbl) (g:goal) (rest:goal list) : step list option =
          let _ = Printf.printf "Attempt To Solve: %s\n" (UnivLib.goal2str g) in
          let gid = get_mid g in
          let result = solve_sim_eqn _s new_tbl gid in
          let _ = Printf.printf "Returned To: %s : %s\n" (UnivLib.goal2str g)
            (if result = None then "no solution" else "has solution") in
          match result with
          | Some(node) ->
            let _ = Printf.printf "[%d] Successfully Solved: %s. solve children\n" (node.id) (UnivLib.goal2str g) in
            let steps = get_steps new_tbl node in
            if List.length rest = 0 then
              Some(steps)
            else
              let next_result = try_solve (steps) rest in
              begin
              match next_result with
              | Some(steps) ->
                let _ = Printf.printf "Successfully Solved children of: %s\n" (UnivLib.goal2str g) in
                Some(steps)
              | None ->
                let _ = Printf.printf "Failed to Solve children of: %s\n" (UnivLib.goal2str g) in
                (*mark the current solution a dead end and try again*)
                let _ = SearchLib.deadend new_tbl.search node in
                let res = attempt new_tbl g rest in
                res
              end
          | None ->
            let _ = Printf.printf "No solutions found: %s\n" (UnivLib.goal2str g) in
            None
        in
        match goals with
        | g::t ->
          let new_tbl = mknewtbl ctx init_goals in
          let result = attempt new_tbl g t in
          result
        | [] -> None
    in
      let result = try_solve ([]) init_goals in
      let _ = Printf.printf "Completed search.\n" in
      match result with
      | Some(steps) ->
        let ntbl :gltbl = mknewtbl steps init_goals in
        let _ = Printf.printf "Result has %d elements \n" (List.length steps) in
        let mint,musr= mkmenu s ntbl None in
        let _ = mint "s" in
        Some(s,ntbl)
      | None ->
      let _ = Printf.printf "No Result\n" in
        None



    let solve (_s) (v) =
      let res = solve_topology _s v in
      res

end



let solve (hw:hwenv) (prob:menv) (out:string) (interactive:bool) =
  let _ = init_utils() in
  let sl = SolveLib.mkslv hw prob interactive in
  let tbl = SolveLib.mktbl sl in
  let _ = pr sl "===== Beginning Interactive Solver ======\n" in
  let spdoc = SolveLib.solve (REF.mk sl) (tbl) in
  match spdoc with
    | Some(s,tbl) ->
    let _ = Printf.printf "===== Concretizing to Spice File ======\n" in
      let _ = try
        let sp = SpiceLib.to_spice s tbl.sln in
        IO.save out (SpiceLib.to_str sp)
      with
        | SpiceLibException(m) -> Printf.printf "ERROR: SPICE Generation Failed. %s" m
      in
      let _ = Printf.printf "===== Concretizing to summary file =====\n" in
      let _ = IO.save (out^".summary") (SlnLib.tostr tbl.sln) in
      let _ = SlnLib.repr2file (out^".caml") tbl.sln in
      let _ = Printf.printf "===== Solution Found ======\n" in
      ()
    | None ->
      let _ = flush_all () in
      error "solve" " no solution Found."
  ()
