%{
  open Util
  open Unit
  open Common
  open HWData
  open HWLib
  open HWConnLib
  open HWInstLib
  open HWCstrLib
  
  open AST
  open CompileUtil

  type parser_meta = {
    mutable comp : string option;
  }

  let dat = HwLib.mkenv()
  let meta = {comp=None}



  type conn =
    | AllConn
    | CompConn of string
    | CompPortConn of string*string
    | InstConn of string*(index list)
    | InstPortConn of string*(index list)*string


  type conntype = Input | Output

  type pid =  (string*string*int)

  let conn_iter (c:conn) (conntype:conntype) (fxn:(string*string)->index->unit)  =
    let conntype = if conntype = Input then HNInput else HNOutput in
    (*determine if this is what we're filtering against*)
    let isconntype v = v.knd = conntype in
    let itercmp cmp (idx:index option) =
      let gidx = if idx = None then IToEnd 0 else OPTION.force_conc idx in
      let _ = MAP.iter cmp.vars (fun vname vr -> if isconntype vr then fxn (cmp.name,vname) gidx else ()) in
      ()
    in
    match c with
    | AllConn ->
      let cmps = HwLib.getcomps dat in
      let itercmp cmp = List.iter (fun cmp -> itercmp cmp None) cmps in
      ()
    | CompConn(c) ->
      let cmp = HwLib.getcomp dat c in
      itercmp cmp None
    | CompPortConn(c,p) ->
      let ident = (c,p) in
      fxn ident (IToEnd 0)
    | InstConn(c,i) ->
      let cmp = HwLib.getcomp dat c in
      let _ = List.iter (fun idx ->
        itercmp cmp (Some idx)) i
      in
      ()
    | InstPortConn(c,i,p) ->
      let _ = List.iter (fun idx ->
        fxn (c,p) idx
        ) i
      in
      ()

  let idx2hcconn (c:string) (idx:index) : hcconn =
    let comp = HwLib.getcomp dat c in
    let res = match idx with
    | IIndex(i) -> HCCIndiv(i)
    | IRange(r) -> HCCRange(r)
    | IToStart(i) -> HCCRange(0,i)
    | IToEnd(i) -> HCCRange(i,comp.insts)
    in
    res

  let add_conns (src:conn) (snk:conn)=
    let handle_conns sc sp sidx dc dp didx =
      let sconn = idx2hcconn sc sidx in
      let dconn = idx2hcconn dc didx in
      let _ = HwConnLib.mkconn dat sc sp dc dp sconn dconn in
      ()
    in
    let _ = conn_iter src Output (fun (sc,sp) sconn ->
      conn_iter snk Input (fun (dc,dp) dconn ->
        handle_conns sc sp sconn dc dp dconn
    ))
    in
    ()



  exception ParseHwError of string*string

  let error s n =
    let _ = Printf.printf "==== %s ====\n%s\n========\n" s n in
    let _ = flush_all () in
    raise (ParseHwError(s,n))

  let set_cmpname n =
    meta.comp <- Some(n)

  let get_cmpname () =
    match meta.comp with
    | Some(v) -> v
    | None -> error "get_cmpname" "no component name defined"

  let print_expr e =
    ASTLib.ast2str e (fun x -> HwLib.hwvid2str x)

let mkdfl cname iname =
    let mk p = HwConnLib.mk dat cname iname p in
    MAP.iter (dat.props) (fun k v -> mk k); 
    ()
%}


%token EOF EOL
%token EQ COLON QMARK COMMA STAR ARROW OBRACE CBRACE OPARAN CPARAN OBRAC CBRAC DOT
%token TYPE LET NONE INITIALLY IN WHERE

%token PROP TIME
%token COMP INPUT OUTPUT PARAM REL END SIM

%token CSTR SAMPLE MAG ERR

%token COPY

%token SCHEMATIC INST CONN

%token DIGITAL 

%token <string> STRING TOKEN OP
%token <float> DECIMAL
%token <int> INTEGER

%type<number list> numlist
%type<string list> strlist
%type <string> sexpr
%type <range> rng
%type <hwvid ast> expr
%type <hevid ast> errexpr
%type <unt> typ
%type <(string*untid) list> proptyplst
%type <Util.number> number

%type <index> ind
%type <index list> inds
%type <conn> connterm
%type <string> compname
%type <string*hwvid hwbhv> rel
%type <unit> schem
%type <unit> comp
%type <unit> block
%type <unit> st
%type <unit> seq
%type <HWData.hwvid HWData.hwenv option> env

%start env

%%
strlist:
  | TOKEN                    {let e = $1 in [e]}
  | TOKEN COMMA strlist      {let lst = $3 and e = $1 in e::lst }

tokenlist:
  | TOKEN           {[$1]}
  | TOKEN tokenlist {$1::$2}

number:
  | DECIMAL   {let e = $1 in Decimal(e)}
  | INTEGER   {let e = $1 in Integer(e)}

numlist:
  | number                    {let e = $1 in [e]}
  | number COMMA numlist      {let lst = $3 and e = $1 in e::lst}

sexpr:
  | OP          {let e = $1 in e}
  | TOKEN             {let e = $1 in e}
  | INTEGER           {let e = $1 in string_of_int e}
  | DECIMAL           {let e = $1 in str_of_float e}
  | OPARAN            {"("}
  | OBRAC             {"["}
  | sexpr INTEGER      {let rest = $1 and e = string_of_int $2 in rest^e}
  | sexpr DECIMAL      {let rest = $1 and e = str_of_float $2 in rest^e}
  | sexpr TOKEN        {let rest = $1 and e = $2 in rest^e}
  | sexpr OP     {let rest = $1 and e = $2 in rest^e}
  | sexpr COMMA        {let rest = $1 in rest^"," }
  | sexpr STAR         {let rest = $1 in rest^"*"}
  | sexpr OBRAC        {let rest = $1 in rest^"["}
  | sexpr CBRAC        {let rest = $1 in rest^"]"}
  | sexpr OPARAN       {let rest = $1 in rest^"("}
  | sexpr CPARAN       {let rest = $1 in rest^")"}


rng:
  | OPARAN number COMMA number CPARAN {(float_of_number $2,float_of_number $4)}

errexpr:
  | sexpr {
    let exprstr = $1 in
    let strast : string ast = string_to_ast exprstr in
    let cname = get_cmpname() in
    let tname,ttypes = HwLib.gettime dat in
    let str2hwid x : hevid=
      if x = tname then HENTime("?") else
      let x = HwLib.getvar dat cname x in
      let xn = x.name in
      match x.typ with
      | HPortType(k, _) ->
        HENPort(k,HCMLocal(cname),xn,"?","?")
      | HParamType(vl, un) -> HENParam(xn,vl,un)
    in
    let getcmpid c =
      match c with
      | HCMLocal(v) -> v
      | HCMGlobal(v,i) -> v
    in
    let hwid2propid x =
      match x with
      | OpN(Func("E"), [Term(HENPort(k,c,v,pr,unt))]) ->
          Some(Term(HENPortErr(k,c,v,pr,unt)))
      | OpN(Func(nprop), [Term(HENPort(k,c,v,pr,unt))]) ->
        let nunt = HwLib.getunit dat (getcmpid c) v nprop in
        Some(Term(HENPort(k,c,v,nprop,nunt)))
        | OpN(Func(nprop), [Term(HENPortErr(k,c,v,pr,unt))]) ->
          let nunt = HwLib.getunit dat (getcmpid c) v nprop in
          Some(Term(HENPortErr(k,c,v,nprop,nunt)))
      | OpN(Func(s),_) -> error "errexpr" ("cannot have function with name "^s)
      | Acc(_,_) -> error "errexpr" "cannot have accesses"
      | _ -> None
    in
    let hwast = ASTLib.map strast str2hwid in
    let hwpropast = ASTLib.trans hwast hwid2propid  in
    hwpropast
  }

erel:
| errexpr EQ errexpr {
  let lhs = $1 and rhs = $3 in
  match lhs with
  | Term(HENPortErr(HNOutput,x,oname,z,w)) -> ((x,oname,z),HERFunction(rhs))
  | Deriv(Term(HENPortErr(HNOutput,x,oname,z,w)),Term(HENTime(_))) -> ((x,oname,z), HERState(rhs))
  | _ ->  error "erel" "must provide a term or derivative for lhs."
  | _ -> error "erel" "left hand side is too complex."
}
expr:
  | sexpr {
    let exprstr = $1 in
    let strast : string ast = string_to_ast exprstr in
    let cname = get_cmpname() in
    let tname,ttypes = HwLib.gettime dat in
    let str2hwid x =
      if x = tname then HNTime else
      if HwLib.hasvar dat cname x
        then
          let v = HwLib.getvar dat cname x in
          HNPort(v.knd,HCMLocal(cname),v.port,"?")
        else if HwLib.hasparam dat cname x
        then
          let v = HwLib.getparam dat cname x in
          HNParam(HCMLocal(cname),v.name)
        else
          error "expr" ("variable "^x^" not found in "^cname)
    in
    let getcmpid c =
      match c with
      | HCMLocal(v) -> v
      | HCMGlobal(v,i) -> v
    in
    let hwid2propid x =
      match x with
      | OpN(Func(nprop), [Term(HNPort(k,cmp,vname,prop))]) ->
        begin
        Some(Term(HNPort(k,cmp,vname,nprop)))
        end
      | OpN(Func(x),_) -> error "expr" ("cannot have function with name "^x)
      | Acc(_,_) -> error "expr" "cannot have accesses"
      | _ -> None
    in
    let hwast = ASTLib.map strast str2hwid in
    let hwpropast = ASTLib.trans hwast hwid2propid  in
    hwpropast
  }

rel:
    | expr EQ expr {
      let lhs = $1 and rhs = $3 in
      match lhs with
      | Term(HNPort(HNOutput,x,oname,z)) ->
        let bhvr : hwvid hwavar = {
            rhs=rhs;
            mag_cstr=CMAGNone
        } in
        (oname,HWBhvAnalogVar(bhvr))
      | Deriv(_,_) -> error "fnrel" "must provide an initial condition for derivative."
      | _ -> error "fnrel" "left hand side is too complex."
    }
    | expr EQ expr INITIALLY expr {
      let lhs = $1 and rhs = $3 and icn = $5 in
      let istime x = match x with HNTime(_) -> true | _ -> false in
      match lhs with
      | Deriv(Term(HNPort(HNOutput,_,oname,oprop)), Term(r)) ->
        if istime r = false then
          error "strel" "derivative must be with respect to time."
        else
          begin
          match icn with
          | Term(HNPort(HNInput,_,icname,icprop)) ->
            let bhvr : hwvid hwaderiv = {
                rhs=rhs;
                ic=(icname,icprop);
                mag_cstr=CMAGNone
            } in 
          (oname,HWBhvAnalogStateVar(bhvr))
          | _ -> error "strel" ""
          end
      | Term(v) -> error "strel" "left hand side must by deriv if initial condition is specified."
      | _ -> error "strel" ("left hand side must be simple derivative or term of output: "^(print_expr lhs))
    }

typ:
  | sexpr {UExpr(string_to_ast $1)}
  | NONE {UNone}
  | QMARK {UVariant}


mag_expr:
  | OBRAC numlist CBRAC TOKEN {match $2 with
    |[min;max] -> CMAGRange(min,max,$4)
    |_ -> error "mag_expr" "range expression has to be two elements"
    }

proptyplst:
  | TOKEN COLON TOKEN                      {let prop = $1 and unt = $3 in [(prop,unt)]}
  | TOKEN COLON TOKEN COMMA proptyplst     {let rest = $5 and prop = $1 and unt = $3 in (prop,unt)::rest}


digital:
  | DIGITAL INPUT TOKEN EOL {
    let name = HwLib.input_cid $3 in
    let _ = set_cmpname name in
    let _ = HwLib.mkcomp dat name in
    ()
  }
  | DIGITAL OUTPUT TOKEN EOL {
    let name = HwLib.output_cid $3 in
    let _ = set_cmpname name in
    let _ = HwLib.mkcomp dat name in
    ()
  }
  | digital INPUT TOKEN WHERE proptyplst EOL  {
    let iname = $3 in
    let typlst = $5 in
    let cname = get_cmpname() in
    let _ = HwLib.mkport dat cname HNInput iname typlst in
    let _ = mkdfl cname iname in
    ()
  }
  | digital OUTPUT TOKEN WHERE proptyplst EOL  {
    let iname = $3 in
    let typlst = $5 in
    let cname = get_cmpname() in
    let _ = HwLib.mkport dat cname HNOutput iname typlst in
    let _ = mkdfl cname iname in
    ()
  }
  | digital INPUT TOKEN EOL {
    let iname = $3 in
    let cname = get_cmpname() in
    let _ = HwLib.mkport dat cname HNInput iname [] in
    let _ = mkdfl cname iname in
    ()
  }
  | digital OUTPUT TOKEN EOL {
    let iname = $3 in
    let cname = get_cmpname() in
    let _ = HwLib.mkport dat cname HNOutput iname [] in
    let _ = mkdfl cname iname in
    ()
  }
  | digital REL rel EOL {
    let pname,r = $3 and cname = get_cmpname() in
    let _ = HwLib.mkrel dat cname pname r in
    ()
  }
  | digital CSTR MAG expr IN mag_expr EOL {
      let lhs = $4 and cstr = $6 in
      let cname,pname,prop = match lhs with
      | Term(HNPort(_,HCMLocal(cmpname),portname,prop)) -> (cmpname,portname,prop)
      | Term(HNPort(_,HCMGlobal(cmpname,_),portname,prop)) -> (cmpname,portname,prop)
      | _ -> error "magparse" "unknown term to constrain."
      in
      HwCstrLib.mk_mag_cstr dat cname pname prop cstr
  }
  | digital CSTR SAMPLE expr IN DECIMAL TOKEN EOL {
      let lhs = $4 and cstr = $6 and typ = $7 in
      let cmpname,portname,prop = match lhs with
      | Term(HNPort(_,HCMLocal(cmpname),portname,prop)) -> (cmpname,portname,prop)
      | Term(HNPort(_,HCMGlobal(cmpname,_),portname,prop)) -> (cmpname,portname,prop)
      | _ -> error "magparse" "unknown term to constrain."
      in
      let cstr = CSAMPFreq(Decimal cstr,typ) in
      HwCstrLib.mk_sample_cstr dat cmpname portname prop cstr
  }
  | digital SIM TOKEN tokenlist EOL {
      let cname = get_cmpname() in
      let spname = $3 in
      let args = $4 in
      let _ = HwLib.mksim dat cname spname args in
      ()
  }

  | digital EOL {()}


comp:
  | COMP TOKEN EOL {
    let name = $2 in
    let _ = set_cmpname name in
    let _ = HwLib.mkcomp dat name in
    ()
  }
  | COMP COPY TOKEN EOL {
    let name = HwLib.copy_cid  $3 in
    let _ = set_cmpname name in
    let _ = HwLib.mkcomp dat name in
    ()
  }
  | comp INPUT TOKEN WHERE proptyplst EOL  {
    let iname = $3 in
    let typlst = $5 in
    let cname = get_cmpname() in
    let _ = HwLib.mkport dat cname HNInput iname typlst in
    let _ = mkdfl cname iname in
    ()
  }
  | comp OUTPUT TOKEN WHERE proptyplst EOL  {
    let iname = $3 in
    let typlst = $5 in
    let cname = get_cmpname() in
    let _ = HwLib.mkport dat cname HNOutput iname typlst in
    let _ = mkdfl cname iname in
    ()
  }
  | comp PARAM TOKEN COLON typ EQ OBRACE numlist CBRACE EOL {
    let iname = $3 in
    let typ = $5 in
    let vls = $8 in
    let cname = get_cmpname() in
    let _ = HwLib.mkparam dat cname iname vls typ in
    ()
  }
  | comp REL rel EOL {
    let pname,r = $3 and cname = get_cmpname() in
    let _ = HwLib.mkrel dat cname pname r in
    ()
  }
  | comp CSTR MAG expr IN mag_expr typ EOL {
      let lhs = $4 and cstr = $6 and typ = $8 in
      let cmpname,portname,prop = match lhs with
      | Term(HNPort(_,HCMLocal(cmpname),portname,prop)) -> (cmpname,portname,prop)
      | Term(HNPort(_,HCMGlobal(cmpname,_),portname,prop)) -> (cmpname,portname,prop)
      | _ -> error "magparse" "unknown term to constrain."
      in
      HwCstrLib.mk_mag_cstr dat cmpname portname prop cstr
  }
  | comp SIM TOKEN tokenlist EOL {
      let cname = get_cmpname() in
      let spname = $3 in
      let args = $4 in
      let _ = HwLib.mksim dat cname spname args in
      ()
  }
  | comp EOL   {}

ind:
  | INTEGER COLON {let s = $1 in IToEnd(s)}
  | COLON INTEGER {let s = $2 in IToStart(s)}
  | INTEGER COLON INTEGER {let s = $1 and e = $3 in IRange(s,e)}
  | INTEGER           {let i = $1 in IIndex(i)}

inds:
  | ind {let a = $1 in [a]}
  | ind COMMA inds {let a = $1 and lst = $3 in a::lst}

connterm:
  | STAR                      {AllConn}
  | TOKEN                     {let name = $1 in CompConn name}
  | COPY OPARAN TOKEN CPARAN { let name = HwLib.copy_cid $3 in CompConn name }
  | INPUT OPARAN TOKEN CPARAN { let name = HwLib.input_cid $3 in CompConn name}
  | OUTPUT OPARAN TOKEN CPARAN { let name = HwLib.output_cid $3 in CompConn name}
  | connterm OBRAC inds CBRAC {
    let basic = $1 and inds = $3 in
    match basic with
    | CompConn(name) -> InstConn(name,inds)
    | _ -> error "connterm" "unsupported term as instance"
  }
  | connterm DOT TOKEN {
    let basic = $1 and port = $3 in
    match basic with
    | CompConn(name) -> CompPortConn(name,port)
    | InstConn(name,inds) -> InstPortConn(name,inds,port)
    | _ -> error "connterm" "unsupported port of term."
  }
compname:
  | COPY TOKEN    {let prop = $2 in HwLib.copy_cid prop}
  | INPUT TOKEN   {let prop = $2 in HwLib.input_cid prop}
  | OUTPUT TOKEN  {let prop = $2 in HwLib.output_cid prop}
  | TOKEN         {let name = $1 in name }

schem:
  | SCHEMATIC EOL {
    ()
  }
  | schem INST compname COLON INTEGER EOL {
    let cname = $3 and amt = ($5) in
    let _ = HwInstLib.mkinst dat cname amt in
    ()
  }
  | schem CONN connterm ARROW connterm EOL {
    let src = $3 and snk = $5 in
    let _ = add_conns src snk in
    ()
  }
  | schem EOL {
    ()
  }

block:
  | comp END EOL       {()}
  | digital END EOL    {()}
  | schem END EOL      {()}

st:
  | TYPE TOKEN EOL  {
    let t = $2 in
    dat.units <- UnitLib.define dat.units t
  }
  | LET number TOKEN EQ number TOKEN EOL  {
    let u1 = $3 and n1 = float_of_number $2 in
    let u2 = $6 and n2 = float_of_number $5 in
    dat.units <- UnitLib.mkrule (dat.units) u1 n1 u2 n2
  }
  | PROP TOKEN COLON strlist EOL {
    let units = $4 and name = $2 in
    let _ = HwLib.mkprop dat name units in
    ()
  }
  | TIME TOKEN COLON strlist EOL {
    let units = $4 and name = $2 in
    let _ = HwLib.mktime dat name units in
    ()
  }
  | block {

  }
  | EOL             {}

seq:
  | st              {}
  | seq st          {}

env:
  | seq EOF {Some (dat)}
  | EOF     {None}
