open Util
open Unit
open AST

exception HwCstrError of string

type compid =
  | HCCMLocal of string

type propid = string
type hcvkind = HCNInput | HCNOutput | HCNInputErr | HCNOutputErr
type hcvid =
  | HCNPort of hcvkind*compid*string*propid*untid
  | HCNParam of string*float*unt
  | HCNTime

type hcrel =
  | HCRFun of hcvid ast
  | HCRState of hcvid ast

type hcinst =
  | HCFinite of int
  | HCInfinite

type hwcstrs = {
  conns: (string*string*int, (string*string*int) set) map;
  mags: (string*string,range) map;
  errs: (string*string, hcrel) map;
  insts: (string,hcinst) map;
}

let error s n =
  raise (HwCstrError (s^": "^n))

module HwCstrLib =
struct
  let mkcstrs ()  : hwcstrs=
    {
      conns= MAP.make();
      mags= MAP.make();
      errs = MAP.make();
      insts = MAP.make()
    }

end
