#!/bin/bash
set -e

help(){
    #    -v | --version [VERSION])
    #        For 'stable' and 'static' modes, choose the version that you want to install.
    #        By default: Version that appears on file 'version.txt'
    cat  <<EOF 
$1: $0 ([OPTIONS])

[OPTIONS]

    -p | --path [PATH] )
        Path to sources, by default: \$TOOLS_HOME ($TOOLS_HOME)
EOF
}

toStatic(){
    version=`cat $TOOLS_HOME/pyRankFinder/version.txt`

    echo "Building binary for version: $version"

    # 1 - Path to sources:

    sources_path=$TOOLS_HOME/pplpy/ppl/:$TOOLS_HOME/pyLPi/lpi/:$TOOLS_HOME/pyParser/genericparser/:$TOOLS_HOME/pyRankFinder/partialevaluation/:$TOOLS_HOME/pyRankFinder/nodeproperties/:$TOOLS_HOME/pyRankFinder/termination/


    # 2 - Run pyinstaller:
    pyinstaller $TOOLS_HOME/pyRankFinder/irankfinder.py --hidden-import networkx --hidden-import gmpy2 --hidden-import cython --hidden-import cysignals --hidden-import z3 --hidden-import eiol --hidden-import lark --hidden-import pkg_resources.extern.packaging.version --hidden-import genericparser --hidden-import genericparser.Parser_smt2 --hidden-import genericparser.Parser_fc --hidden-import genericparser.Parser_koat --hidden-import termination --hidden-import termination.algorithm --hidden-import nodeproperties --hidden-import nodeproperties.abstractStates --hidden-import lpi --hidden-import ppl -p $sources_path --distpath $TOOLS_HOME/pyRankFinder/dist/$version/ --workpath $TOOLS_HOME/pyRankFinder/build -y

    pyinstaller $TOOLS_HOME/pyRankFinder/CFRefinement.py --hidden-import networkx --hidden-import gmpy2 --hidden-import cython --hidden-import cysignals --hidden-import z3 --hidden-import eiol --hidden-import lark --hidden-import pkg_resources.extern.packaging.version --hidden-import genericparser --hidden-import genericparser.Parser_smt2 --hidden-import genericparser.Parser_fc --hidden-import genericparser.Parser_koat --hidden-import termination --hidden-import termination.algorithm --hidden-import nodeproperties --hidden-import nodeproperties.abstractStates --hidden-import lpi --hidden-import ppl -p $sources_path --distpath $TOOLS_HOME/pyRankFinder/dist/$version/ --workpath $TOOLS_HOME/pyRankFinder/build -y

    # 3 - Add no python files:

    #     - all grammar files of genericparser

    mkdir $TOOLS_HOME/pyRankFinder/dist/$version/irankfinder/genericparser/
    cp $TOOLS_HOME/pyParser/genericparser/*.g $TOOLS_HOME/pyRankFinder/dist/$version/irankfinder/genericparser/
    mkdir -p $TOOLS_HOME/pyRankFinder/dist/$version/irankfinder/lark/grammars/
    lark_path=`python3 -c "import os; import lark; print(os.path.dirname(lark.__file__))"`
    cp $lark_path/grammars/common.* $TOOLS_HOME/pyRankFinder/dist/$version/irankfinder/lark/grammars/

    #     - smt2pushdown binary

    cp $TOOLS_HOME/pyParser/genericparser/smtpushdown2 $TOOLS_HOME/pyRankFinder/dist/$version/irankfinder/genericparser/smtpushdown2

    #     - PE binary

    mkdir -p $TOOLS_HOME/pyRankFinder/dist/$version/irankfinder/partialevaluation/bin/
    cp $TOOLS_HOME/pyRankFinder/partialevaluation/bin/* $TOOLS_HOME/pyRankFinder/dist/$version/irankfinder/partialevaluation/bin/

    #     - CFRefinement entry point
    cp $TOOLS_HOME/pyRankFinder/dist/$version/CFRefinement/CFRefinement $TOOLS_HOME/pyRankFinder/dist/$version/irankfinder/
    rm -rf $TOOLS_HOME/pyRankFinder/dist/$version/CFRefinement/

    # 4 - Check python lib
    pname=$TOOLS_HOME/pyRankFinder/dist/$version/irankfinder/libpython3*.so.*
    pdest=$TOOLS_HOME/pyRankFinder/dist/$version/irankfinder/libpython3*.so
    if [ ! -f $pdest ]; then
	if [ -f $pname ]; then
	    pdest=`echo $pname`
	    cp $pname ${pdest/.1.0/}
	fi
    fi

    # 5 - zip all
    zip -r $TOOLS_HOME/pyRankFinder/dist/irankfinder_$version.zip $TOOLS_HOME/pyRankFinder/dist/$version/irankfinder/
}

check_sources(){
    if [ -d "$path/pyRankFinder/.git/" ]; then
	ok=true
    else
	ok=false
	echo "Sources not found at $path" >&2
	exit -1
    fi
}
basedir=$(dirname "$(readlink -f "$0" )")
path=$TOOLS_HOME
while [ $# -gt 0 ]; do
    case $1 in
	-p|--path)
	    if [ "${2:0:1}" = "/" ]; then
		path=$2
	    else
		path=$basedir"/"$2
	    fi
	    shift 2
	    ;;
	-h|--help )
	    help "Usage"
	    exit 0
	    ;;
	*)
	    help "ERROR" >&2  
	    exit -1
	    ;;
    esac
done

check_sources

toStatic
