open Util

open ASTUnifyData
open ASTXUnify

open AST
open Interactive
open Globals

open HWData
open HWLib

open MathData
open MathLib

open Search
open SearchData

open SolverGoalTableFactory
open SolverData
open SolverUtil
open SolverRslv
open SolverMapper
open SolverSearch 
open GoalLib 

open SlnLib


open GoalLib
open SolverCompLib

open HWConnRslvr


exception SolverEqnError of string

let error n m = raise (SolverEqnError (n^":"^m))

let _print_debug = print_debug 2 "eqn"
let debug = print_debug 2 "eqn"
let _menu = menu 2
let _print_inter = print_inter 2
module SolverEqn =
struct


  let mkmenu (v:gltbl) (currgoal:goal option) =
    let menu_desc = "t=search-tree, s=sol, @=curr, g=goals, c=conc-comps\n"^
                    "n=node-steps m=mapping any-key=continue, q=quit" in
    let rec menu_handle inp on_finished=
      if STRING.startswith inp "t" then
        let _ = Printf.printf "\n%s\n\n" (SearchLib.search2str v.search) in
        let _ = on_finished() in
        ()
      else if STRING.startswith inp "s" then
        let _ = Printf.printf "\n%s\n\n" (SlnLib.sln2str v.sln_ctx ident mid2str) in
        let _ = on_finished() in
        ()
      else if STRING.startswith inp "c" then
        let _ = Printf.printf "\n%s\n\n" (SolverCompLib.ccomps2str v ) in
        let _ = on_finished() in
        ()
      else if STRING.startswith inp "goto" then
        let _ = match STRING.split inp " " with
        | [_;id] ->
          let nid = int_of_string id in
          let _ = SearchLib.move_cursor v.search v (SearchLib.id2node v.search nid) in
          ()
        | _ -> ()
        in
        let _ = on_finished() in
        ()
      else if STRING.startswith inp "m" then
        begin
          Printf.printf ("---- Inferring ------\n");
          SolverMapper.infer v
        end
      else if STRING.startswith inp "g" then
        let _ = Printf.printf "==== Goals ===\n" in
        let _ = Printf.printf "%s\n" (GoalLib.goals2str v) in
        let _ = Printf.printf "============\n" in
        let _ = match currgoal with
          | Some(currgoal) -> Printf.printf ">> Current Goal: %s\n" (GoalLib.goal2str currgoal)
          | _ -> Printf.printf ">> CurrentGoal: (none)\n"
        in
        let _ = on_finished() in
        ()
      else if STRING.startswith inp "n" then
        begin
            let path = SearchLib.get_path v.search (SearchLib.cursor v.search) in
            Printf.printf "steps:\n%s\n" (SearchLib.steps2str 1 v.search path);
            ()
        end
      else if STRING.startswith inp "@" then
        begin
          begin
            match currgoal with
            | Some(g) ->
              Printf.printf ">>> target goal: %s\n\n\n" (GoalLib.goal2str g) 
            | None -> Printf.printf "<no goal>\n\n\n"
          end;
          ()
        end
      else
        ()
    in
    let internal_menu_handle x = menu_handle x (fun () -> ()) in
    let rec user_menu_handle () = _menu "goal-solver" (fun x -> menu_handle x user_menu_handle) menu_desc in
    internal_menu_handle,user_menu_handle





  let mark_if_solution (v:gltbl) (curr:(sstep snode)) = 
    debug "[mark-if-solution] testing if solution.";
    if GoalLib.num_active_goals v = 0 then
      if HwConnRslvrLib.consistent v then
        begin
          debug "[mark-if-solution] found concrete hardware. marking as solution.";
          noop (SearchLib.solution v.search curr);
          debug "[mark-if-solution] -> marked as solution."
        end
      else
        begin
          debug "[mark-if-solution] cannot concretize hardware.";
          noop (SearchLib.deadend v.search curr v)
        end
    else
      debug "[mark-if-solution] there are still goals left.";
      ()
  

  let backup_and_move_cursor (tbl:gltbl) (node:sstep snode) =
    let old_cursor = SearchLib.cursor tbl.search in
    let old_depth =  List.length (TREE.get_path tbl.search.tree node) in
    SearchLib.move_cursor tbl.search tbl node;
    (old_cursor,old_depth)


  (*test whether the node is valid, if it is valid, return true. Otherwise, return false*)
  let test_node_validity (tbl:gltbl) (node:sstep snode) (depth:int) : bool=
    begin
      let old_cursor, old_depth = backup_and_move_cursor tbl node in 
      debug ("-> [valid?] testing node "^(string_of_int node.id));
      let is_valid : bool =
        if old_depth >= depth then
          begin
            (*determine if there are any goals left. You must move off of node you're deadending*)
            debug "[test-node-validity] hit max depth:";
            SearchLib.deadend tbl.search node tbl;
            false
          end
        else if (GoalLib.num_active_goals tbl) = 0 then
        begin
          (*found all goals*)
          debug "[test-node-validity] found a valid solution";
          mark_if_solution tbl node;
          true
        end
      else
        true
    in
    debug "[test-node-validity] moved cursor";
    SearchLib.move_cursor tbl.search tbl old_cursor;
    is_valid
  end


  (*get the best valid node. If there is no valid node, return none *)
  let rec get_best_valid_node (tbl:gltbl) (root:(sstep snode) option) (depth:int)  : (sstep snode) option =
    match SearchLib.select_best_node tbl.search root with
    | Some(newnode) ->
        if test_node_validity tbl newnode depth then
          Some(newnode)
        else
          get_best_valid_node tbl root depth
    | None -> None

  (*
    Scoring the goal: higher = better
  *)
  let score_goal_uniform g = 0.

(*
  let score_goal_random g = RAND.rand_norm()

  let score_goal_trivial_preferred g = match g with
    | TrivialGoal(v) -> 1. +. RAND.rand_norm ()
    | NonTrivialGoal(v) -> RAND.rand_norm()

  let score_goal_nontrivial_preferred g = match g with
    | TrivialGoal(v) -> RAND.rand_norm ()
    | NonTrivialGoal(v) -> 1. +. RAND.rand_norm()
*)


  let best_goal_function () =
    let typ = get_glbl_string "eqn-selector-goal" in
    match typ with
    | "trivial" -> ( fun x -> 0. -. GoalLib.goal_difficulty x)
    | _ ->
      error "best_goal_function" ("goal selector named <"^typ^"> doesn't exist")

  let get_best_valid_goal (v:gltbl) : goal =
    let cursor = SearchLib.cursor v.search in
    let goals = GoalLib.get_active_goals v in
    let score_goal = best_goal_function() in
    if List.length goals > 0  then
      let _,targ_goal = LIST.max (fun (x:goal) -> 0. -. (score_goal x.d)) goals in
      targ_goal
    else
      error "get_best_valid_goal" ("non-visited node has no goals: "^(string_of_int cursor.id))

  let no_more_nodes (v:gltbl) (head:(sstep snode) option) =
    (List.length (SearchLib.get_paths v.search head))


  let mknode tbl steps (parent:(sstep snode)) =
        SearchLib.move_cursor tbl.search tbl parent;
        SearchLib.start tbl.search;
        SearchLib.add_steps tbl.search steps;
        let no = SearchLib.commit tbl.search tbl in
        no



  (*=========== RSTEP to SSTEP Conversion ==================*)
  (*specifically for inputs*)
  let rassign_inp_to_goal (stepq:sstep queue) (tbl:gltbl) (comp:ucomp_conc) (v:string) (cfg:hwvarcfg) : unit =
    let enq s = noop (QUEUE.enqueue stepq s) in
    let wire = SlnLib.mkwire comp.d.name comp.inst v in
    match uast2mast cfg.expr with
    | Term(MNVar(knd,name)) ->
      begin
        match knd with
        (*assign a math input to a hardware input*)
        | MInput ->
            if HwLib.is_inblock_reachable tbl.env.hw wire = false
            then
              let goal = GoalLib.mk_inblock_goal tbl wire (uast2mast cfg.expr) in
              enq (SModGoalCtx(SGAddGoal(goal)))
            else
              enq (SModSln(SSlnAddRoute(MInLabel({var=name;wire=wire}))))

        | MLocal ->
          enq (SModSln(SSlnAddRoute(MLocalLabel({var=name;wire=wire}))))

        | MOutput ->
          enq (SModSln(SSlnAddRoute(MOutLabel({var=name;wire=wire}))))
          
      end
    

    | Integer(i) ->
      enq (SModSln(SSlnAddRoute(ValueLabel({value=Integer i;wire=wire}))))

    | Decimal(d)->
      enq (SModSln(SSlnAddRoute(ValueLabel({value=Decimal d;wire=wire}))))

    | Term(MNParam(_)) -> error "rstep_to_goal" "not expecting param"

    (*assignment over inputs to output*)
    | expr ->
      (*note: this should create different solutions*)
      if MathLib.is_input_expr expr  = false
      then
        let goal = GoalLib.mk_hexpr_goal tbl wire expr in
        enq (SModGoalCtx(SGAddGoal(goal)))
      else
        enq (SModSln(SSlnAddRoute(MExprLabel({expr=expr;wire=wire}))))



  (*resolve output port assignments*)
  let rassign_out_to_goal (stepq:sstep queue )(tbl:gltbl) (comp:ucomp_conc) (v:string) (cfg:hwvarcfg) :
    unit =
    let enq s = noop (QUEUE.enqueue stepq s) in
    let wire = SlnLib.mkwire comp.d.name comp.inst v in
    match uast2mast cfg.expr with
    | Term(MNVar(knd,name)) ->
      begin
        match knd with
        (*an output port should not generate an input *)
        |MInput ->
          enq (SModSln(SSlnAddGen(MInLabel({var=name;wire=wire}))))
        
        (*this is a generator for an output. remove the math goal*)
        |MOutput ->
          let goal_to_remove : goal= GoalLib.get_math_goal tbl name in
          enq (SModGoalCtx(SGRemoveGoal(goal_to_remove)));
          enq (SModSln(SSlnAddGen(MOutLabel({var=name;wire=wire}))));
          if HwLib.is_outblock_reachable tbl.env.hw wire = false then
            begin
              let goal = GoalLib.mk_outblock_goal tbl wire (uast2mast cfg.expr) in
              enq (SModGoalCtx(SGAddGoal(goal)))
            end

        (*this is a generator for an local. remove the math goal*)
        |MLocal ->
          let goal_to_remove : goal= GoalLib.get_math_goal tbl name in
          enq (SModGoalCtx(SGRemoveGoal(goal_to_remove)));
          enq (SModSln(SSlnAddGen(MLocalLabel({var=name;wire=wire}))))
      end
    (*if we found a connection*)
    | Term((MNParam(_))) -> error "rstep_to_goal" "not expecting param"
    | expr ->
      enq (SModSln(SSlnAddGen(MExprLabel({expr=expr;wire=wire}))))

  let rsteps_to_ssteps (tbl:gltbl) (comp:ucomp_conc) (rsteps:rstep list) (ssteps:sstep list)=
    let compid = {name=comp.d.name;inst=comp.inst} in 
    let sstepq = QUEUE.make () in
    let enq x = noop (QUEUE.enqueue sstepq x) in
    let add_step (rstep:rstep) : unit =
          match rstep with
          (*input assignments become goals*)
          | RAddInAssign(v,cfg) ->
            enq (SModCompCtx(SCAddInCfg(compid,v,cfg)));
            rassign_inp_to_goal sstepq tbl comp v cfg 
          (*out assignments are already satisfied*)
          | RAddOutAssign(v,cfg) ->
            enq (SModCompCtx(SCAddOutCfg(compid,v,cfg)));
            rassign_out_to_goal sstepq tbl comp v cfg
          | RAddParAssign(v,cfg) ->
            enq (SModCompCtx(SCAddParCfg(compid,v,cfg)))
          | _ -> ()
    in
    List.iter add_step rsteps;
    let steps = QUEUE.to_list sstepq in
    QUEUE.destroy sstepq;
    ssteps @ steps
    

  (*todo, we should automatically *)
  (*
     TODO: Return a set of global steps.
     On MkHWConn ->
           (1) remove route to input port 
           (2) add connection to solution
           (3) copy input port assignment to output port
           (4) remove relevent match statements (use uast2mast cast in to-node)
  *)
  let rslvd_hwingoal_to_ssteps (tbl:gltbl) (comp:ucomp_conc) (hwvar:hwvid hwportvar) (hgoal:goal_hw_expr) = 
    let incomp : ucomp_conc = ConcCompLib.get_conc_comp tbl hgoal.wire.comp in
    let invar : hwvid hwportvar = HwLib.comp_getvar incomp.d hgoal.wire.port in
    let outwire :wireid = SlnLib.mkwire hwvar.comp comp.inst hwvar.port in
    let inid : hwvid = HwLib.var2id invar (Some incomp.inst) in
    let matched_goals : (int*goal) list=
      GoalLib.find_goals tbl (GUnifiable(GUHWInExprGoal(hgoal))) in
    let rm_goal_steps :sstep list=
      List.map (fun (i,x) -> SModGoalCtx(SGRemoveGoal(x))) matched_goals
    in
    [
      SModSln(SSlnAddConn({src=outwire;dst=hgoal.wire}));
      (*SModSln(SSlnRmRoute(MExprLabel({wire=hgoal.wire;expr=hgoal.expr})));*)
      SModSln(SSlnAddGen(MExprLabel({wire=outwire;expr=hgoal.expr})))
    ] @ rm_goal_steps

  let unify_goal_with_comp (tbl:gltbl) (ucomp:ucomp) (hwvar:hwvid hwportvar) (g:unifiable_goal) =
    let results : rstep list list= match g with
      | GUMathGoal(mgoal) ->
        ASTUnifier.unify_comp_with_mvar tbl.env.hw tbl.env.math ucomp hwvar.port mgoal.d.name

      | GUHWInExprGoal(hgoal) ->
        ASTUnifier.unify_comp_with_hwvar tbl.env.hw tbl.env.math ucomp hwvar.port
            (SolverCompLib.wireid2hwid tbl hgoal.wire) (mast2uast hgoal.expr)
      | GUHWConnInBlock(_) -> error "unify_goal_with_comp" "conn-in unimplemented"
      | GUHWConnOutBlock(_) -> error "unify_goal_with_comp" "conn-out unimplemented"
      | GUHWConnPorts(_) -> error "unify_goal_with_comp" "conn-ports unimplemented"
    in
    match results with
    | h::t ->
      begin
        (*create a concrete comp*)
        let comp : ucomp_conc = SolverCompLib.mk_conc_comp tbl ucomp.d.name in
        let inits = [SModCompCtx(SCMakeConcComp(comp))] in
        List.iter (fun rsteps ->
            debug (" -> found unify solution with "^(LIST.length2str rsteps)^" steps");
            begin
              let steps : sstep list =
                match g with
                | GUMathGoal(mgoal) -> rsteps_to_ssteps tbl comp rsteps inits
                | GUHWInExprGoal(hgoal) ->
                  ((rslvd_hwingoal_to_ssteps tbl comp hwvar hgoal) @
                  (rsteps_to_ssteps tbl comp rsteps inits))
                | _ -> error "unify_goal_with_comp" "rstep->sstep conversion unimplemented"
              in
              debug ("    -> converted to "^(LIST.length2str steps)^" ssteps");
              SearchLib.mknode_child_from_steps tbl.search tbl (steps);
              ()
            end
          ) results;
        debug ("[unify!] Found "^(LIST.length2str results)^" results");
        List.length results
      end
    | [] -> 0

  let unify_goal_with_conc_comp (tbl:gltbl) (ucomp:ucomp_conc) (hwvar:hwvid hwportvar) (g:unifiable_goal) =
    let results : rstep list list = match g with
      | GUMathGoal(mgoal) ->
        ASTUnifier.unify_conc_comp_with_mvar tbl.env.hw tbl.env.math ucomp hwvar.port mgoal.d.name
      | GUHWInExprGoal(hgoal) ->
        ASTUnifier.unify_conc_comp_with_hwvar tbl.env.hw tbl.env.math ucomp hwvar.port
          (SolverCompLib.wireid2hwid tbl hgoal.wire) (mast2uast hgoal.expr)
      | GUHWConnInBlock(_) -> error "unify_goal_with_conc_comp" "conn-in unimplemented"
      | GUHWConnOutBlock(_) -> error "unify_goal_with_conc_comp" "conn-out unimplemented"
      | GUHWConnPorts(_) -> error "unify_goal_with_conc_comp" "conn-ports unimplemented"
      | _ -> error "unify_goal_with_conc_comp" "unimplemented"
    in
    match results with
    | h::t ->
      begin
        List.iter (fun rsteps ->
            debug (" -> found unify solution with "^(LIST.length2str rsteps)^" steps");
            begin
             let steps = match g with
              | GUMathGoal(_) -> rsteps_to_ssteps tbl ucomp rsteps []
              | GUHWInExprGoal(hgoal) ->
                  ((rslvd_hwingoal_to_ssteps tbl ucomp hwvar hgoal) @
                  (rsteps_to_ssteps tbl ucomp rsteps []))

              | _ -> error "unify_goal_with_conc_comp" "rstep->sstep conversion unimplemented"
             in
             SearchLib.mknode_child_from_steps tbl.search tbl (steps);
            ()
            end
        ) results;
        debug ("[unify!] Found "^(LIST.length2str results)^" results");
        List.length results
      end
    | [] -> 0


  type slvr_cmp_kind = HWCompNew of hwcompname | HWCompExisting of hwcompinst

  let solve_unifiable_goal (tbl:gltbl) (g:unifiable_goal) =
      (* make a priority queue that grades the component outputs for the goal*)
      let prio_comps = PRIOQUEUE.make (fun (k,p) -> match k with
          | HWCompNew(xname) ->
            let hwcomp = SolverCompLib.get_avail_comp tbl xname in 
            SolverCompLib.grade_hwvar_with_goal hwcomp.d p g
          | HWCompExisting(xinst) ->
            let hwcomp = SolverCompLib.get_conc_comp tbl xinst in 
            SolverCompLib.grade_hwvar_with_goal hwcomp.d p g
        )
    in
      (* add all the compatible available comps *)
      SolverCompLib.iter_avail_comps tbl (fun cmpname cmp ->
        if SolverCompLib.has_available_insts tbl cmpname  then
          match SolverCompLib.compatible_comp_with_goal tbl cmp g with
            | [] -> ()
            | vars -> List.iter (fun v ->
                noop (PRIOQUEUE.add prio_comps (HWCompNew cmpname,v))) vars
      );
      (* add all the compatible used comps*)
      SolverCompLib.iter_used_comps tbl (fun cmpid cmp ->
          match SolverCompLib.compatible_used_comp_with_goal tbl cmp g with
          | [] -> ()
          | vars -> List.iter (fun v ->
              noop (PRIOQUEUE.add prio_comps (HWCompExisting cmpid,v))) vars
        );
      (* iterate over prioritzed list of comps*)
      let nsols : int ref = REF.mk 0 in 
      debug (">>> NUMBER OF COMPATIBLE COMPONENTS  "^
             (string_of_int (PRIOQUEUE.size prio_comps))^" <<<");
      PRIOQUEUE.iter prio_comps (fun (prio:int) (cmpkind,hwvar) ->
          begin
            match cmpkind with
            | HWCompNew(cmpname) ->
              let hwcomp = SolverCompLib.get_avail_comp tbl cmpname in 
              begin
                debug ("new: ["^(string_of_int prio)^"] <"^(HwLib.hwcompname2str hwcomp.d.name)^
                       "> "^(HwLib.hwportvar2str hwvar hwid2str^"\n"));
                let nslns = unify_goal_with_comp tbl hwcomp hwvar g in
                REF.upd nsols (fun x -> x + nslns);
                ()
              end
            | HWCompExisting(compinst) ->
              let hwcomp : ucomp_conc = SolverCompLib.get_conc_comp tbl compinst in 
              begin
              debug "  [existing comp]";
                     debug ("new: ["^(string_of_int prio)^"] <"^(HwLib.hwcompname2str hwcomp.d.name)^
                "> "^(HwLib.hwportvar2str hwvar hwid2str^"\n"));
              let nslns = unify_goal_with_conc_comp tbl hwcomp hwvar g in
              REF.upd nsols (fun x -> x + nslns);
              ()
              end
          end;
          ()

        );
      PRIOQUEUE.delete prio_comps;
      (*if there are any solutions*)
      if REF.dr nsols > 0 then
        begin
          debug ("[FOUND-SOLS] ===> Found some solutions");
          ()
        end
      else
        begin
          debug ("//NO-SOLS// ===> Found no solutions");
          SearchLib.deadend tbl.search (SearchLib.cursor tbl.search) tbl;
          ()
        end


  let solve_goal (tbl:gltbl) (g:goal) =
    let root = SearchLib.cursor tbl.search in
    let mint,musr = mkmenu tbl (Some g) in
    mint "g";
    musr ();
    if g.active = false then error "solve_goal" "cannot solve inactive goal"; 
    match g.d with
    |GUnifiable(g) -> solve_unifiable_goal tbl g 
    | _ -> error "solve_goal" "unimplemented"

  let solve_subtree (tbl:gltbl) (root:(sstep snode)) (nslns:int) (depth:int) : unit =
    let downgrade_enable = get_glbl_bool "downgrade-trivial" in
    let mint,musr = mkmenu tbl (None) in
    let rec rec_solve_subtree (root:(sstep snode)) =
      (*we've exhausted the subtree - there are no more paths to explore*)
      let currslns = SearchLib.num_solutions tbl.search (Some root) in 
      begin
      if currslns >= nslns then
        begin
         debug "[search_tree] Found enough solutions";
         musr ();
         ()
        end
      else
        begin
        debug ("found "^(string_of_int currslns)^" / "^(string_of_int nslns));
        if SearchLib.is_exhausted tbl.search (Some root) then
          begin
            debug "no more nodes left to check.";
            musr ();
            ()
          end
        else
          (*get the next node*)
          let maybe_next_node = get_best_valid_node tbl (Some root) depth in
          match maybe_next_node with
          | Some(next_node) ->
            begin
              (*move to node*)
              SearchLib.move_cursor tbl.search tbl next_node;
              let next_goal = get_best_valid_goal tbl in
              (*solves the goal*)
              musr ();
              solve_goal tbl next_goal;
              rec_solve_subtree root
            end
            (*No more subgoals*)
          | None ->
            debug "[search_tree] could not find another node";
            ()
        end
      end
    in
    debug "[search-tree] starting";
    mint "g";
    musr ();
    let maybe_root = SearchLib.root tbl.search in
    begin
      match maybe_root with
      | Some(root) -> 
        begin
        SearchLib.move_cursor tbl.search tbl root;
        debug "[search-tree] positioned cursor";
        if List.length ( GoalLib.get_active_goals tbl ) = 0 then
          begin
            mark_if_solution tbl root;
            debug "[search-tree] there are no active goals. beginning search anyway";
            rec_solve_subtree root;
            ()
          end
        else
          begin
            debug "[search-tree] get best valid goal";
            let next_goal = get_best_valid_goal tbl in
            debug "[search-tree] solve the best valid goal";
            solve_goal tbl next_goal;
            debug "[search-tree] begin search";
            rec_solve_subtree root;
            ()
          end
        end
      | None -> error "solve_tree" "root is empty/unset"
    end

  let solve (v:gltbl) (nslns:int) (depth:int) : ((sstep snode) list) option =
    debug ("find # solutions: "^(string_of_int nslns));
    match SearchLib.root v.search with
    | Some(root) ->
      begin
        solve_subtree v root nslns depth;
        let slns = SearchLib.get_solutions v.search (Some root) in
        match slns with
        | [] -> None
        | lst -> Some(lst)
      end
    | None -> error "solve" "the tree has no root."

end
