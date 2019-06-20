#!/bin/bash

TABID=$1
shift
benchfile=$1
shift
name=$1
irankoutdir="out/nt/"$name
veryoutdir="../../VeryMaxTerm/out/"$name"/nopar"
t2outdir="../../T2/out"
shift
#alg=$1
shift
prf=1


##########################################################
##########################################################


function build_table(){
    echo "<div><table class=\"fixed_header termination\" id=\"$TABID\">"
    echo "<thead>"
    # echo "<tr><th></th><th></th> <th colspan=\"7\"> CFR BEFORE </th> <th colspan=\"7\"> CFR SCC </th>  <th colspan=\"7\"> CFR After </th> </tr>"
    echo -n -e "<tr><th>File</th>"
    echo -n -e "<th>iRankFinder Q</th>"
    echo -n -e "<th>iRankFinder Z</th>"
    echo -n -e "<th>VeryMax</th>"
    echo -n -e "<th>T2</th>"
    # for pes in before scc after; do
    #     for pe in 1 2 3 4 5 6 7; do
    # 	echo -n -e "<th>P<span class=\"foot\">$pe</span></th>"
    #     done
    # done
    echo "</tr>"
    echo "  </thead>"
    echo "  <tbody>"

    for bn in `cat $benchfile`; do
	fn="${bn##*/}"
	echo -n -e "    <tr><td>$fn</td>"
	irankfinder_result $fn 113 $prf 0 0
	irankfinder_result $fn 123 $prf 0 0
	verymax_result $fn
	t2_result $fn
	# if [[ "$det" == "True" ]]; then
	#     echo "<td>DET</td>"
	# else
	#     echo "<td>no</td>"
	# fi
	# for pes in 1 2 3; do
	#	for pe in 100 101 102 103 104 105 106; do
	#       irankfinder_result $fn $alg $prf $pes $pe
	# 	done
	# done
	echo "</tr>"
    done
    echo "  </tbody>"
    echo "</table>"
    echo "<script>init_table(\"$TABID\");</script>"

    echo "</div>"

}


##########################################################
##########################################################


function t2_result(){
    fn_=$1
    fnn="$t2outdir/$fn_.T2cache"
    if [ ! -f $fnn ]; then
	res="U"
	time=0
    else
	token="`head -1 $fnn`"
	res=`( ( echo $token | grep ^Termination\ proof\ succeeded > /dev/null && echo -n Y) || (echo $token | grep ^Nontermination\ proof\ succeeded > /dev/null && echo -n N) || (echo $token | grep ^Termination\/nontermination\ proof\ failed > /dev/null && echo -n M) || echo -n T )`
	time=`cat -v $fnn | grep usertime | awk '{print $2}'`
    fi

    print_cell $res $time
}

function verymax_result(){
    fn_=$1
    fnn="$veryoutdir/$fn_.verymax"
    if [ ! -f $fnn ]; then
	res="U"
	time=0
    else
	token="`head -2 $fnn | tail -1`"
	res=`( ( echo $token | grep ^YES > /dev/null && echo -n Y) || (echo $token | grep ^NO > /dev/null && echo -n N) || (echo $token | grep ^MAYBE > /dev/null && echo -n M) || echo -n T )`
	time=`cat -v $fnn | grep usertime | awk '{print $2}'`
    fi

    print_cell $res $time
}

function irankfinder_result(){
    fn_=$1
    alg_=$2
    prf_=$3
    pes_=$4
    pe_=$5
    fnn="$irankoutdir/$fn_.irank.$alg_.$prf_.$pes_.$pe_"
    if [ ! -f $fnn ]; then
	res="U"
	time=0
    else
	token="`head -3 $fnn | tail -1`"
	res=`( ( echo $token | grep ^YES > /dev/null && echo -n Y) || (echo $token | grep ^NO > /dev/null && echo -n N) || (echo $token | grep ^MAYBE > /dev/null && echo -n M) || echo -n T )`
	time=`grep usertime $fnn | awk '{print $2}'`
	det=`grep deterministic $fnn | awk '{print $2}'`
    fi

    print_cell $res $time
}

function print_cell(){
    res=$1
    time=$2
    cell_class=""
    if [[ "$res" == "T" ]]; then
	res="M"
    fi
    if [[ "$res" == "T" ]]; then
	cell_class="timeout"
	time="300.00"
    elif [[ "$res" == "U" ]]; then
	cell_class="error"
    elif [[ "$res" == "Y" ]]; then
	cell_class="terminate"
    elif [[ "$res" == "N" ]]; then
	res="No"
	cell_class="nonterminate"
    elif [[ "$res" == "M" ]]; then
	res="Maybe"
	cell_class="maybe"
    fi	    
    # echo -n -e "<td class=\"$cell_class\">$res ($time)</td>"
    echo -n -e "<td class=\"$cell_class\">$res</td>"
}


##########################################################
##########################################################


build_table
