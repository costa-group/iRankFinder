#!/bin/bash

srcdir="in"
benchfile=$1
shift
params=$@

rm -f /tmp/cfr.log

for fn in `cat $benchfile`; do
    echo $fn
    d=`dirname $fn`
    for pe in $params; do
	tsp -n ./run_cfr.sh $srcdir/0/$fn $pe in/$pe/$d
    done
done




