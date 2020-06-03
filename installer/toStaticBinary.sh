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
        Path to sources, by default: \$TOOLS_HOME (actual value: '$TOOLS_HOME')
EOF
}

toStatic(){
    path=$1
    version=`cat $path/pyRankFinder/version.txt`

    echo "Building binary for version: $version"

    # 1 - Path to sources:

    sources_path=$path/pplpy/ppl/:$path/pyLPi/lpi/:$path/pyParser/genericparser/:$path/pyRankFinder/partialevaluation/:$path/pyRankFinder/nodeproperties/:$path/pyRankFinder/termination/


    # 2 - Run pyinstaller:
    pyinstaller $path/pyRankFinder/irankfinder.py --hidden-import networkx --hidden-import gmpy2 --hidden-import cython --hidden-import cysignals --hidden-import z3 --hidden-import eiol --hidden-import lark --hidden-import pkg_resources.extern.packaging.version --hidden-import genericparser --hidden-import genericparser.Parser_c --hidden-import genericparser.Parser_smt2 --hidden-import genericparser.Parser_fc --hidden-import genericparser.Parser_koat --hidden-import termination --hidden-import termination.algorithm --hidden-import nodeproperties --hidden-import nodeproperties.abstractStates --hidden-import lpi --hidden-import ppl -p $sources_path --distpath $path/pyRankFinder/dist/$version/ --workpath $path/pyRankFinder/build -y

    pyinstaller $path/pyRankFinder/CFRefinement.py --hidden-import networkx --hidden-import gmpy2 --hidden-import cython --hidden-import cysignals --hidden-import z3 --hidden-import eiol --hidden-import lark --hidden-import pkg_resources.extern.packaging.version --hidden-import genericparser --hidden-import genericparser.Parser_smt2 --hidden-import genericparser.Parser_c --hidden-import genericparser.Parser_fc --hidden-import genericparser.Parser_koat --hidden-import termination --hidden-import termination.algorithm --hidden-import nodeproperties --hidden-import nodeproperties.abstractStates --hidden-import lpi --hidden-import ppl -p $sources_path --distpath $path/pyRankFinder/dist/$version/ --workpath $path/pyRankFinder/build -y

    # 3 - Add no python files:

    #     - all grammar files of genericparser
    mkdir -p $path/pyRankFinder/dist/$version/irankfinder/lark/grammars/
    lark_path=`python3 -c "import os; import lark; print(os.path.dirname(lark.__file__))"`
    cp $lark_path/grammars/common.* $path/pyRankFinder/dist/$version/irankfinder/lark/grammars/

    #     - z3 lib
    z3_path=`python3 -c "import os; import z3; print(os.path.dirname(z3.__file__))"`
    cp $z3_path/lib/libz3.so $path/pyRankFinder/dist/$version/irankfinder/libz3.so
    
    #     - Parser binaries
    mkdir -p $path/pyRankFinder/dist/$version/irankfinder/genericparser/bin
    cp $path/pyParser/genericparser/bin/* $path/pyRankFinder/dist/$version/irankfinder/genericparser/bin/

    #     - PE binary
    mkdir -p $path/pyRankFinder/dist/$version/irankfinder/partialevaluation/bin/
    cp $path/pyRankFinder/partialevaluation/bin/* $path/pyRankFinder/dist/$version/irankfinder/partialevaluation/bin/

    #     - CFRefinement entry point
    cp $path/pyRankFinder/dist/$version/CFRefinement/CFRefinement $path/pyRankFinder/dist/$version/irankfinder/
    rm -rf $path/pyRankFinder/dist/$version/CFRefinement/


    # 4 - Check python lib
    pname=$path/pyRankFinder/dist/$version/irankfinder/libpython3*.so.*
    pdest=$path/pyRankFinder/dist/$version/irankfinder/libpython3*.so
    if [ ! -f $pdest ]; then
	if [ -f $pname ]; then
	    pdest=`echo $pname`
	    cp $pname ${pdest/.1.0/}
	fi
    fi

    plat=`uname`
    mach=`uname -m`
    # 5 - zip all
    pushd $path/pyRankFinder/dist
    zip -r irankfinder_$version_${plat,,}_$mach.zip ./$version/irankfinder/
    popd
}

check_sources(){
    if [ -d "$path/pyRankFinder/.git/" ]; then
	ok=true
    else
	ok=false
	help "Sources not found at $path.\n ERROR" >&2
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

toStatic $path

