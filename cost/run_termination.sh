#!/bin/bash

lrf="-t lrf_pr"
qnlrf2="-t lrf_pr qnlrf_2"
sif="-sif"
dtalways="-dt always"
rniv="-rniv"
inv="-i polyhedra"
tsh="-inv-thre project_head all_in"
cfr1="-cfr-inv -cfr-it 1"
cfr2="-cfr-inv -cfr-it 2"
cfrb="-cfr-st-before"
cfra="-cfr-st-after -cfr-mx-t 1"
cfrs="-cfr-st-scc -cfr-mx-t 1"
cfrh="-cfr-head"
cfrhv="-cfr-head-var"
cfrc="-cfr-call"
cfrcv="-cfr-call-var"
cfrjpg="-cfr-john"
cfrallprops="$cfrh $cfrhv $cfrc $cfrcv"
cfrallprops_and_jpg="$cfrallprops $cfrjpg"

#
alg[0]=""
alg[1]="-t lrf_pr"
alg[2]="-t lrf_pr qnlrf_2"
alg[3]="-t qnlrf_2"

#
prf[0]=""
prf[1]="$inv $sif $dtalways $rniv"

#
pes[0]=""
pes[1]="$cfrb"
pes[2]="$cfrs"
pes[3]="$cfra"


#
pe[0]=""
pe[7]="--rfs-as-cfr-props -od $6"
pe[100]="$cfr1 $cfrc"
pe[101]="$cfr1 $cfrh"
pe[102]="$cfr1 $cfrc $crfh"
pe[103]="$cfr1 $cfrallprops"
pe[104]="$cfr1 $cfrjpg"
pe[105]="$cfr1 $cfrjpg $cfrc"
pe[106]="$cfr1 $cfrjpg $cfrh"

rankfinder="/opt/tools/pyRankFinder/irankfinder.sh" 

cmd="$rankfinder -f $5 ${alg[$1]} ${prf[$2]} ${pes[$3]} ${pe[$4]}"

echo "CMD: $cmd" > $6
echo "" >> $6
/usr/bin/time -f "\n-- stats\nrealtime %E\nusertime %U\nsystime %S\n" timeout 300s $cmd 2>&1 | cat >> $6

