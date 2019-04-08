#!/bin/bash

benchfile=$1
shift
outdir=$1
shift
sep=$1
shift
alg=$1
shift
prf=$1
shift
pes=$1
shift

echo -n -e "bench"
for pr in $@; do
    echo -n -e "$sep$pr"
done

echo ""

for bn in `cat $benchfile`; do
    fn="${bn##*/}"
    echo -n -e "$fn"
    for pe in $@; do
	fnn="$outdir/$fn.irank.$alg.$prf.$pes.$pe"
	if [ ! -f $fnn ]; then
	    res="U"
	    time=0
	else
	    token="`head -3 $fnn | tail -1`"
	    res=`( ( echo $token | grep ^YES > /dev/null && echo -n Y) || (echo $token | grep ^NO > /dev/null && echo -n N) || (echo $token | grep ^MAYBE > /dev/null && echo -n M) || echo -n T )`
	    time=`grep usertime $fnn | awk '{print $2}'`
	fi
	#echo -n -e "$sep$res"
	echo -n -e "$sep$res ($time)"
    done
    echo ""
done
