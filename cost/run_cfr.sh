#!/bin/bash


cfr1="-i polyhedra -cfr-inv -cfr-it 1"
cfr2="-i polyhedra -cfr-inv -cfr-it 2"
cfrh="-cfr-head"
cfrhv="-cfr-head-var"
cfrc="-cfr-call"
cfrcv="-cfr-call-var"
cfrjpg="-cfr-john"
cfrallprops="$cfrh $cfrhv $cfrc $cfrcv"
cfrallprops_and_jpg="$cfrallprops $cfrjpg"

#
pe[0]=""
pe[100]="$cfr1 $cfrc"
pe[101]="$cfr1 $cfrh"
pe[102]="$cfr1 $cfrc $crfh"
pe[103]="$cfr1 $cfrallprops"
pe[104]="$cfr1 $cfrjpg"
pe[105]="$cfr1 $cfrjpg $cfrc"
pe[106]="$cfr1 $cfrjpg $cfrh"



echo "" >> /tmp/crf.log
echo "python3 /opt/tools/pyRankFinder/CFRefinement.py  -f $1 -of koat -od $3 ${pe[$2]}" >> /tmp/cfr.log

python3 /opt/tools/pyRankFinder/CFRefinement.py  -f $1 -of koat -od $3 ${pe[$2]} >> /tmp/cfr.log

#rm -f /tmp/*.koat /tmp/xx

