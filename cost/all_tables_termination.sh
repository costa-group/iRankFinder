#!/bin/bash

files="files.com_1"
outdir="../termination/out/koat"
pe="100 101 102 103 104 105 106"

# Normal

echo "No CFR"
echo " - lrf"
./table_termination.sh $files $outdir 1 1 0 0 > x1.1.0
echo " - lrf qnlrf"
./table_termination.sh $files $outdir 2 1 0 0 > x2.1.0
echo " - qnlrf"
./table_termination.sh $files $outdir 3 1 0 0 > x3.1.0

# CFR Before
echo "CFR BEFORE"
echo " - lrf"
./table_termination.sh $files $outdir 1 1 1 $pe > x1.1.1
echo " - lrf qnlrf"
./table_termination.sh $files $outdir 2 1 1 $pe > x2.1.1
echo " - qnlrf"
./table_termination.sh $files $outdir 3 1 1 $pe > x3.1.1

# CFR SCC
echo "CFR SCC"
echo " - lrf"
./table_termination.sh $files $outdir 1 1 2 $pe > x1.1.2
echo " - lrf qnlrf"
./table_termination.sh $files $outdir 2 1 2 $pe > x2.1.2
echo " - qnlrf"
./table_termination.sh $files $outdir 3 1 2 $pe > x3.1.2

# CFR After
echo "CFR AFTER"
echo " - lrf"
./table_termination.sh $files $outdir 1 1 3 $pe > x1.1.3
echo " - lrf qnlrf"
./table_termination.sh $files $outdir 2 1 3 $pe > x2.1.3
echo " - qnlrf"
./table_termination.sh $files $outdir 3 1 3 $pe > x3.1.3
