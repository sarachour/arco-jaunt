open Util
open Unit
open AST
open Common

exception HwCstrError of string


type propid = string

type hcvid =
  | HCNPort of hwvkind*compid*string*propid*untid
  | HCNPortErr of hwvkind*compid*string*propid*untid
  | HCNParam of string*float*unt
  | HCNTime of untid

type hcrel =
  | HCRFun of hcvid ast
  | HCRState of hcvid ast

type hcinst =
  | HCInstFinite of int
  | HCInstInfinite

type hcconn =
 | HCConnInstPort of (string*string*int)
 | HCConnCompPort of (string*string)

type hwcstrs = {
  conns: (string*string*int,hcconn set) map;
  mags: (string*string*string,range) map;
  errs: (string*string*string, hcrel) map;
  insts: (string,hcinst) map;
}

let error s n =
  raise (HwCstrError (s^": "^n))

exception HwCstrLibException of string

let error s n = raise (HwCstrLibException (s^": "^n))

module HwCstrLib =
struct
  let mkcstrs ()  : hwcstrs=
    {
      conns= MAP.make();
      mags= MAP.make();
      errs = MAP.make();
      insts = MAP.make()
    }

  let mkinst e iname cnt =
    if MAP.has e.insts iname then
      error "mkinst" "already exists"
    else
      let _ = MAP.put e.insts iname cnt in
      ()

  let mkmag e iname portname propname rng =
    let key = (iname,portname,propname) in
    if MAP.has e.mags key then
      let orng = MAP.get e.mags key in
      let nrng = RANGE.resolve orng rng in
      let _ = MAP.put e.mags key nrng in
      ()
    else
      let _ = MAP.put e.mags key rng in
      ()

  let mkglblmag e rng =
    let _ = MAP.map e.mags (fun k v -> RANGE.resolve v rng) in
    ()

  let print e =
    let pr_inst k v = match v with
      | HCInstFinite(x) -> k^" has "^(string_of_int x)^" instances"
      | HCInstInfinite -> k^" has infinite instances"
    in
    let pr_mag (c,port,prop) v =
      "comp "^c^"."^port^" prop "^prop^" in "^(RANGE.range2str v)
    in
    let apply f k x r = r^"\n"^(f k x) in
    let istr = MAP.fold e.insts (apply pr_inst) "" in
    let mstr = MAP.fold e.mags (apply pr_mag) "" in
    let _ = Printf.printf "%s\n%s\n" istr mstr in
    ()

end
