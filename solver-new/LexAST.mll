{

open ParseAST;;

}
rule expr = parse
   |[' ''\t''\n'] {expr lexbuf}
   | "-"    {SUB}
   | "*"    {MULT}
   | "("    {OPAR}
   | ")"    {CPAR}
   | "["    {OBRAC}
   | "]"    {CBRAC}
   | "."    {DOT}
   | "/"    {DIV}
   | ","    {COMMA}
   | "^"    {POW}
   | "deriv" {DERIV}
   | "exp" {EXP}
   | ['0'-'9']*"."['0' - '0']+ as tok {let v = float_of_string tok in DECIMAL(v)}
   | ['0'-'9']+  as tok               {let v = int_of_string tok in INTEGER(v)}
   | ['A'-'Z']['A'-'Z' 'a'-'z' '0' - '9' ':' ';']* as tok {TOKEN(tok)}
   | eof {EOF}
