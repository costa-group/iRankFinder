#!/bin/bash

benchfile=$1
srcdir=$2
outdir=$3
pe=$4


#
sf[0]=""
sf[100]="_cfr1_with_invpolyhedra"
sf[101]="_cfr1_with_invpolyhedra"
sf[102]="_cfr1_with_invpolyhedra"
sf[103]="_cfr1_with_invpolyhedra"
sf[104]="_cfr1_with_invpolyhedra"
sf[105]="_cfr1_with_invpolyhedra"
sf[106]="_cfr1_with_invpolyhedra"


for fn in `cat $benchfile`; do
    echo $fn
    file=`echo $(basename "${fn%.*}")`
    dir=`dirname $fn`
    tsp -n ./run_cofloco.sh $srcdir/$pe/$dir/$file${sf[$pe]}.koat.ces $outdir/$pe/$fn
done
