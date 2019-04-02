#!/bin/bash
C2KOAT=$TOOLS_HOME/llvm2kittel/build/c2koat
TMPDIR=$1/_ei_tmp
BASE=$1/_ei_files/
shift

FILENAME=$1
NAME=`basename $FILENAME`

KOATNAME=`basename $FILENAME .c`
KOATNAME=${KOATNAME/$BASE/}
KOATNAME=${KOATNAME/User_Projects/}
KOATFILE=$KOATNAME.koat

echo "<eiout>"
echo "<eicommands>"
if [[ "$NAME" == *.c ]]; then
    $C2KOAT $TMPDIR $FILENAME > $TMPDIR/file.koat 2> $TMPDIR/errs
    if [ -f $TMPDIR/errs ]; then
	echo "<printonconsole consoleid='stderr' consoletitle='Errors and Warnings'><content><![CDATA["
	cat $TMPDIR/errs
	echo "]]></content></printonconsole>"
    fi
    if [ -f $TMPDIR/file.koat ]; then
	echo "<printonconsole consoleid='result' consoletitle='Koat Source'><content><![CDATA["
	cat $TMPDIR/file.koat
	echo "]]></content></printonconsole>"
	echo "<writefile filename='"$KOATFILE"'><![CDATA["
	cat $TMPDIR/file.koat
	echo "]]></writefile>"
    fi
else
    echo "<printonconsole consoleid='stderr' consoletitle='Errors and Warnings'><content><![CDATA["
    echo "WRONG FILE EXTENSION: " $NAME
    echo "]]></content></printonconsole>"
fi

echo "</eicommands>"
echo "</eiout>"
