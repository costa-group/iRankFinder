#!/bin/bash

benchfile=$1
shift
outdir=$1
shift
alg=$1
shift
prf=$1
shift
pes=$1
shift

params=$@

for fn in `cat $benchfile`; do
    d=`dirname $fn`
    mkdir -p $outdir/$d
    for pe in $params; do	
	echo "Analyzing $fn with profile $pe"
	tsp -n ../termination/run.sh $alg $prf $pes $pe in/0/$fn $outdir/$fn.irank.$alg.$prf.$pes.$pe
    done
done




