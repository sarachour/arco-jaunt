open HWLib
open HWData
open GenericData
open GenericLib
open ConfigSearchGenerator
open ConfigSearchDeriver

open Util

exception ConfigSearchException of string;;


module ConfigSearch : 
sig
   type analogy  = GenericHWLib.analogy
   type goaltree  = ConfigSearchDeriver.goaltree

   type gencfg = {
      analogy: analogy;
      arch: hwarch; 
      components: hwcomp list; 
      mutable goals: goaltree;
      mutable config: hwconfig; 
   }

   val init : analogy -> hwarch -> gencfg
   val convert : gencfg -> genv -> hwconfig
end =
struct
   type analogy  = GenericHWLib.analogy
   type goaltree  = ConfigSearchDeriver.goaltree
   type goal  = ConfigSearchDeriver.goal
   type goalnode  = ConfigSearchDeriver.goalnode

   type gencfg = {
      analogy: analogy;
      arch: hwarch; 
      components: hwcomp list; 
      mutable goals: goaltree;
      mutable config: hwconfig; 
   }
   

   let init anlgy arch : gencfg = 
      let rec proc_comps (e:hwelem) : hwcomp list = match e with
         | Component(c) -> c::[]
         | Schematic(s) -> 
            List.fold_right (fun (n,x) r -> (proc_comps x) @ r) s.elems []
         | _ -> raise (ConfigSearchException "unimplemented proc_comps")
      in
      let c = HWArch.create_config() in
      let comps = proc_comps (Schematic arch.schem) in 
      let g : goaltree = GNoSolutionNode in
      {analogy=anlgy; arch=arch; config=c; components=comps; goals=g}

   let traverse (c:gencfg) = 
      let traverse_elem (gl:goal) : goalnode = 
         let res = ConfigSearchGenerator.find c.components gl in 
         res
      in
      ConfigSearchDeriver.traverse c.goals traverse_elem

   let convert (c:gencfg) (rel:genv)= 
      let hrel = GenericHWLib.genv2hwcomp (c.analogy) rel in
      let initial_goal =  ConfigSearchDeriver.make_goal None hrel in
      c.goals <- GUnsolvedNode(initial_goal);
      let _ = traverse c in 
      c.config



end