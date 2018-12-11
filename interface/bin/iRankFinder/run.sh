#!/bin/bash
TMPDIR=$1/_ei_tmp


${HOME:="/var/www"}
export HOME=$HOME
${PYRANKFINDER_HOME:="$TOOLS_HOME/iRankFinder"}
pyRF=$PYRANKFINDER_HOME/irankfinder.sh

OUTSDIR=$TMPDIR/outs
mkdir -p $OUTSDIR
# mkdir -p $TMPDIR/t2
echo "<eiout>"

$pyRF ${@:2} --ei-out -of fc svg -od "$OUTSDIR/" --print-graphs 2> "$TMPDIR/errors"


echo "<eicommands>"
if [ -s "$TMPDIR/errors" ]; then
    echo "<printonconsole consoleid='errors' consoletitle='Errors'><content><![CDATA["
    echo "========== Command line ====================================="
    echo ${@:2} --ei-out -of fc svg -od "$OUTSDIR/" --print-graphs
    echo "=============================================================="
    cat "$TMPDIR/errors"
    echo "]]></content></printonconsole>"
else
    echo "<printonconsole><content><![CDATA[]]></content></printonconsole>"
fi
echo "</eicommands>"
echo "</eiout>"
