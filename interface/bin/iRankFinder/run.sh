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

files=""
propsfile=""
counter=2
for f in ${@:2}; do
    counter=$((counter+1))
    if [ "$f" == "|" ]; then
	break;
    fi
    ext="${f##*.}"
    if [ "$ext" == "cfgprops" ]; then
	propsfile=$propsfile" "$f
    else
	files=$files" "$f
    fi
done
files="-f"$files
if [ "$propsfile" != "" ]; then
    propsfile="-cfgpf"$propsfile
fi

params=$files" "$propsfile" "${@:$counter}" --ei-out -of fc svg -od "$OUTSDIR/" --tmpdir "$TMPDIR" --print-graphs"

$pyRF $params 2> "$TMPDIR/errors"


echo "<eicommands>"
if [ -s "$TMPDIR/errors" ]; then
    echo "<printonconsole consoleid='errors' consoletitle='Errors'><content><![CDATA["
    echo "========== Command line ====================================="
    echo $params
    echo "=============================================================="
    cat "$TMPDIR/errors"
    echo "]]></content></printonconsole>"
else
    echo "<printonconsole><content><![CDATA[]]></content></printonconsole>"
fi
echo "</eicommands>"
echo "</eiout>"
