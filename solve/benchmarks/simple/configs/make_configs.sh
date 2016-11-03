#!/bin/bash
make_config () {  
  TARG=$1
  IACTIVE=$2
  DEBUG=$3
  cp default.cfg $TARG
  echo "int debug $DEBUG" >> $TARG
  echo "int interactive $IACTIVE" >> $TARG
}

make_config debug.cfg 3 4
make_config prod.cfg 0 2
make_config prod_debug.cfg 0 4
make_config multi.cfg 1 1 
make_config eq.cfg 2 3
