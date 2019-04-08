#!/bin/bash

files="files.com_1"
outdir="../termination/out/koat"
pe="100 101 102 103 104 105 106"

# Normal
echo "" > ./launch.log
echo "No CFR"
echo " - lrf"
# ./run_all_termination.sh $files $outdir 1 1 0 0 >> ./launch.log
echo " - lrf qnlrf"
# ./run_all_termination.sh $files $outdir 2 1 0 0 >> ./launch.log
echo " - qnlrf"
# ./run_all_termination.sh $files $outdir 3 1 0 0 >> ./launch.log

# CFR Before
echo "CFR BEFORE"
echo " - lrf"
# ./run_all_termination.sh $files $outdir 1 1 1 $pe >> ./launch.log
echo " - lrf qnlrf"
# ./run_all_termination.sh $files $outdir 2 1 1 $pe >> ./launch.lo
echo " - qnlrf"
./run_all_termination.sh $files $outdir 3 1 1 $pe >> ./launch.log

# CFR SCC
echo "CFR SCC"
echo " - lrf"
./run_all_termination.sh $files $outdir 1 1 2 $pe >> ./launch.log
echo " - lrf qnlrf"
./run_all_termination.sh $files $outdir 2 1 2 $pe >> ./launch.log
echo " - qnlrf"
./run_all_termination.sh $files $outdir 3 1 2 $pe >> ./launch.log

# CFR After
echo "CFR AFTER"
echo " - lrf"
./run_all_termination.sh $files $outdir 1 1 3 $pe >> ./launch.log
echo " - lrf qnlrf"
./run_all_termination.sh $files $outdir 2 1 3 $pe >> ./launch.log
echo " - qnlrf"
./run_all_termination.sh $files $outdir 3 1 3 $pe >> ./launch.log
