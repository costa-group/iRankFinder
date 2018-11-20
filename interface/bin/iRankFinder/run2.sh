#!/bin/bash
TMPDIR=$1/_ei_tmp
pyRF=/home/friker/Systems/pyRankFinder/runOne.py


python2.7 $pyRF ${@:2} 2> $TMPDIR/errors

echo "ERRORS?"
cat $TMPDIR/errors


echo ${@:2}
