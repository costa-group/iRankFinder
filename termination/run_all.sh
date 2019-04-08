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

for bn in `cat $benchfile`; do
    fn="${bn##*/}"
    for pe in $@; do
	echo "Analyzing $fn with profile $pe"
	tsp -n ./run.sh $alg $prf $pes $pe $bn $outdir/$fn.irank.$alg.$prf.$pes.$pe
    done
done
