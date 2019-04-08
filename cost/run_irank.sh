#!/bin/bash


cfr1="-i polyhedra -cfr-inv -cfr-it 1"
cfr2="-i polyhedra -cfr-inv -cfr-it 2"
cfrh="-cfr-head"
cfrhv="-cfr-head-var"
cfrc="-cfr-call"
cfrcv="-cfr-call-var"
cfrjpg="-cfr-john"
cfrusr="-cfr-usr"
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
pe[107]="$cfr1 $cfrusr"


echo "" >> /tmp/crf.log
echo "python3 /opt/tools/pyRankFinder/CFRefinement.py  -f $1 -of koat -od $3 ${pe[$2]}" >> /tmp/cfr.log

pid=$$
tmp="/tmp/bla/$pid"
mkdir $tmp

/opt/tools/pyRankFinder/irankfinder.sh -f $1 -t qnlrf_2 -i polyhedra -rniv -dt iffail -od $tmp -rfs-as-cfr-props  >> /tmp/cfr.log

file1=`find $tmp -name "*.fc"`
file2=${file1/_rfs_as_cfr/}
cp $file1 $file2
cp $file2 $3 

python3 /opt/tools/pyRankFinder/CFRefinement.py  -f $file2 -of koat -od $3 ${pe[$2]} >> /tmp/cfr.log

rm -rf $tmp


#rm -f /tmp/*.koat /tmp/xx

