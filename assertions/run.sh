#!/bin/bash

ca="-ca"
lrf="-t lrf_pr"
qnlrf2="-t lrf_pr qnlrf_2"
sif="-sif"
dtalways="-dt always"
rniv="-rniv"
inv="-i polyhedra"
tsh="-inv-thre"
tshh="project_head"
tshhv="project_head_var"
tshc="project_call"
tshcv="project_call_var"
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
prf[0]=""
prf[1]="$tsh $tshh"
prf[2]="$tsh $tshhv"
prf[3]="$tsh $tshc"
prf[4]="$tsh $tshcv"


#
pes[0]=""
pes[1]="$cfrb"

#
pe[0]=""
pe[100]="$cfr1 $cfrc"
pe[101]="$cfr1 $cfrh"
pe[102]="$cfr1 $cfrc $crfh"
pe[103]="$cfr1 $cfrallprops"
pe[104]="$cfr1 $cfrjpg"
pe[105]="$cfr1 $cfrjpg $cfrc"
pe[106]="$cfr1 $cfrjpg $cfrh"

rankfinder="/opt/tools/pyRankFinder/irankfinder.sh" 

cmd="$rankfinder -f $4 ${prf[$1]} ${pes[$2]} ${pe[$3]} $ca $inv"

echo "CMD: $cmd" > $5
echo "" >> $5
/usr/bin/time -f "\n-- stats\nrealtime %E\nusertime %U\nsystime %S\n" timeout 300s $cmd 2>&1 | cat >> $5

