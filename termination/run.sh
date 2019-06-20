#!/bin/bash

lrf="lrf_pr"
qnlrf2="qnlrf_2"
recset="monotonicrecset"
ntreach="--nt-reachability"
sif="-sif"
dtalways="-dt always"
dtnever="-dt never"
dtscheme="-dt-scheme inhomogeneous"
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
domainZ="--domain Z"
domainQ="--domain Q"

#
alg[0]=""
alg[1]="-t $lrf"
alg[2]="-t $lrf $qnlrf2"
alg[3]="-t $qnlrf2"
alg[101]="-t $lrf -nt $recset"
alg[102]="-t $lrf $qnlrf_2 -nt $recset"
alg[103]="-t $qnlrf2 -nt $recset"
alg[111]="-t $lrf -nt $recset $domainQ"
alg[112]="-t $lrf $qnlrf_2 -nt $recset $domainQ"
alg[113]="-t $qnlrf2 -nt $recset $domainQ"
alg[121]="-t $lrf -nt $recset $domainZ"
alg[122]="-t $lrf $qnlrf_2 -nt $recset $domainZ"
alg[123]="-t $qnlrf2 -nt $recset $domainZ"
alg[201]="-t $lrf -nt $recset $ntreach"
alg[202]="-t $lrf $qnlrf_2 -nt $recset $ntreach"
alg[203]="-t $qnlrf2 -nt $recset $ntreach"
alg[211]="-t $lrf -nt $recset $ntreach $domainQ"
alg[212]="-t $lrf $qnlrf_2 -nt $recset $ntreach $domainQ"
alg[213]="-t $qnlrf2 -nt $recset $ntreach $domainQ"
alg[221]="-t $lrf -nt $recset $ntreach $domainZ"
alg[222]="-t $lrf $qnlrf_2 -nt $recset $ntreach $domainZ"
alg[223]="-t $qnlrf2 -nt $recset $ntreach $domainZ"

#
prf[0]="$inv $sif $dtnever $rniv"
prf[1]="$inv $sif $dtalways $rniv"
prf[2]="$inv $sif $dtalways $tsh $rniv"
prf[3]="$inv $sif $dtalways $dtscheme $rniv"

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
echo ${alg[$1]}
echo "CMD: $cmd" > $6
echo "" >> $6
/usr/bin/time -f "\n-- stats\nrealtime %E\nusertime %U\nsystime %S\n" timeout 300s $cmd 2>&1 | cat >> $6

