#!/bin/bash

dir="/opt/tools/iRankFinder/examples/koat/cofloco"

files=$1
shift
outdir=$1
shift

echo -n "Bench"
for r in $@; do
    echo -n ";$r"
done
echo ""

for fn in `cat $files`; do
    echo -n "$fn"
    for r in $@; do
	res=`head -1 $outdir/$r/$fn | grep WORST_CASE | sed s/WORST_CASE\(\?,\ O\(1\)\)/0/g | sed s/WORST_CASE\(\?,\ O\(//g | sed s/\)\)//g | sed s/MAYBE/100/g | sed s/n\^//g`
	if [ "$res" == "" ]; then
	    res="200"
	fi
	echo -n ";$res"
    done
    echo ""
done


