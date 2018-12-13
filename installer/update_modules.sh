#!/bin/bash

set -e

help(){
    #    -v | --version [VERSION])
    #        For 'stable' and 'static' modes, choose the version that you want to install.
    #        By default: Version that appears on file 'version.txt'
    cat  <<EOF 
$1: $0 ([OPTIONS])

[OPTIONS]

    -s | --sudo )
        Install with sudo rights.

    -p | --path )
        Path to tools root. By defualt:  \$TOOLS_HOME='$TOOLS_HOME'

EOF
}

ssudo(){
    if [ "$sudo" == "true" ]; then
	sudo -H $@
    else
	$@
    fi
}

install_pyeiol(){
    temporal=$1
    if [ "$temporal" == "true" ]; then
	pushd /tmp/ > /dev/null
	git clone --quiet https://github.com/abstools/easyinterface.git ./pyeiol > /dev/null
	pushd pyeiol > /dev/null
	git checkout develop > /dev/null
    else
	pushd pyeiol > /dev/null
	git pull
    fi
    cd ./outputlanguage/python
    ssudo python3 -m pip install -U .
    popd > /dev/null
    if [ "$temporal" == "true" ]; then
	popd > /dev/null
	rm -rf /tmp/pyeiol
    fi
}

install_iRankFinder_remote(){
    install_pyeiol true
    ssudo python3 -m pip install -U "git+https://github.com/jesusjda/pplpy.git#egg=pplpy" --process-dependency-links
    ssudo python3 -m pip install -U "git+https://github.com/jesusjda/pyLPi.git#egg=pyLPi" --process-dependency-links
    ssudo python3 -m pip install -U "git+https://github.com/jesusjda/pyParser.git#egg=genericparser" --process-dependency-links
    ssudo python3 -m pip install -U "git+https://github.com/jesusjda/pyRankFinder.git#egg=pytermination" --process-dependency-links
    mkdir -p $1/pyRankFinder
    pushd $1/pyRankFinder > /dev/null
    wget -q "https://raw.githubusercontent.com/jesusjda/pyRankFinder/master/irankfinder.py"
    wget -q "https://raw.githubusercontent.com/jesusjda/pyRankFinder/master/CFRefinement.py"
    popd > /dev/null
}



install_iRankFinder_clone(){
    clone_and_install(){
	name=$1
	echo -n "Update repository $name..."
	pushd $name > /dev/null
	git pull > /dev/null
	echo " DONE."
	echo -n "Updating $name..."
	ssudo python3 -m pip install -U .
	echo " DONE."
	popd > /dev/null
	echo "Finished update of $name."
	echo "========================="
	echo ""
    }
    mkdir -p $path
    pushd $path > /dev/null
    # pyeiol
    install_pyeiol false
    # pplpy
    clone_and_install pplpy
    # pyLPi
    clone_and_install pyLPi
    # pyParser
    clone_and_install pyParser
    # pyRankFinder
    clone_and_install pyRankFinder
    popd > /dev/null
}


basedir=$(dirname "$(readlink -f "$0" )")
mode=false
version=latest
sudo=false
path=$TOOLS_HOME
while [ $# -gt 0 ]; do
    case $1 in
	-m|--mode )
	    mode=$2
	    shift 2
	    ;;
	-s|--sudo)
	    sudo=true
	    shift
	    ;;
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

if [ "$mode" == "false" ]; then
    if [ -d "$path/pyRankFinder/.git/" ]; then
	mode=dev
    elif [ -f "$path/pyRankFinder/irankfinder.py" ]; then
	mode=stable
    else
	mode=static
    fi
fi

case $mode in
    stable)
	install_iRankFinder_remote $path
	;;
    dev)
	install_iRankFinder_clone $path
	;;
    *)
	help "ERROR unknown mode: $mode\n Usage:" >&2  
	exit -1
	;;
esac

echo "Succeeded!"
