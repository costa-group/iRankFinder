#!/bin/bash
TMPDIR=$1/_ei_tmp


${HOME:="/var/www"}
export HOME=$HOME
${PYRANKFINDER_HOME:="$TOOLS_HOME/iRankFinder"}
pyRF=$PYRANKFINDER_HOME/irankfinder.py

OUTSDIR=$TMPDIR/outs
mkdir -p $OUTSDIR
# mkdir -p $TMPDIR/t2
echo "<eiout>"

python3 $pyRF ${@:2} --ei-out -of fc svg -od "$OUTSDIR/" 2> "$TMPDIR/errors"


echo "<eicommands>"
if [ -s "$TMPDIR/errors" ]; then
    echo "<printonconsole consoleid='errors' consoletitle='Errors'><content><![CDATA["
    echo "========== Command line ====================================="
    echo ${@:2} --ei-out -of fc svg -od "$OUTSDIR/"
    echo "=============================================================="
    cat "$TMPDIR/errors"
    echo "]]></content></printonconsole>"
else
    echo "<printonconsole><content><![CDATA[]]></content></printonconsole>"
fi
echo "</eicommands>"
echo "</eiout>"
