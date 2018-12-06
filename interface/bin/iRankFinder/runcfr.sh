#!/bin/bash
TMPDIR=$1/_ei_tmp


${HOME:="/var/www"}
export HOME=$HOME
${PYRANKFINDER_HOME:="$TOOLS_HOME/iRankFinder"}
pyRF=$PYRANKFINDER_HOME/CFRefinement.py

OUTSDIR=$TMPDIR/outs
mkdir -p $OUTSDIR
# mkdir -p $TMPDIR/t2
echo "<eiout>"

python3 $pyRF ${@:2} --ei-out --tmpdir "$TMPDIR" -od "cfr_results" 2> "$TMPDIR/errors"


echo "<eicommands>"
if [ -s "$TMPDIR/errors" ]; then
    echo "<printonconsole consoleid='errors' consoletitle='Errors'><content><![CDATA["
    echo "========== Command line ====================================="
    echo ${@:2} --ei-out -od "$OUTSDIR/"
    echo "=============================================================="
    cat "$TMPDIR/errors"
    echo "]]></content></printonconsole>"
else
    echo "<printonconsole><content><![CDATA["
    echo "Refined program file(s) added to the file manager."
    echo "]]></content></printonconsole>"
fi
echo "</eicommands>"
echo "</eiout>"
