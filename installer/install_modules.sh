#!/bin/bash

set -e

help(){
    #    -v | --version [VERSION])
    #        For 'stable' and 'static' modes, choose the version that you want to install.
    #        By default: Version that appears on file 'version.txt'
    cat  <<EOF 
$1: $0 ([OPTIONS])

[OPTIONS]

    -m | --mode [MODE] )
        Install 'stable' or 'clone' mode. ('static' not ready)
        By default: stable

    -b | --branch [BRANCH] )
        For 'clone' mode, choose the branch that you want.
        By default: master

    -s | --sudo )
        Install with sudo rights.

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
	pushd /tmp/
    fi
    git clone --quiet https://github.com/abstools/easyinterface.git ./pyeiol > /dev/null
    pushd pyeiol > /dev/null
    git checkout develop > /dev/null
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
}



install_iRankFinder_clone(){
    clone_and_install(){
	name=$1
	b=$2
	echo -n "Cloning $name..."
	git clone --quiet https://github.com/jesusjda/$name.git > /dev/null
	git checkout $b
	echo " DONE."
	pushd $name > /dev/null
	echo -n "Installing $name..."
	#ssudo python3 -m pip install -U .
	echo " DONE."
	popd > /dev/null
	echo "Finished installation of $name."
	echo "==============================="
	echo ""
    }
    mkdir -p $path
    pushd $path > /dev/null
    # pyeiol
    install_pyeiol false
    # pplpy
    clone_and_install pplpy master
    # pyLPi
    clone_and_install pyLPi master
    # pyParser
    clone_and_install pyParser master
    # pyRankFinder
    clone_and_install pyRankFinder $branch
    popd > /dev/null
}


basedir=$(dirname "$(readlink -f "$0" )")
externals=true
mode=stable
version=latest
branch=master
sudo=false
path=/tmp/tools
while [ $# -gt 0 ]; do
    case $1 in
	-m|--mode )
	    mode=$2
	    shift 2
	    ;;
	-v|--version )
	    version=$2
	    shift 2
	    ;;
	-b|--branch )
	    branch=$2
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


case $mode in
    stable)
	install_iRankFinder_remote
	;;
    clone)
	install_iRankFinder_clone $path
	;;
    *)
	help "ERROR" >&2  
	exit -1
	;;
esac
      
echo "Succeeded!"
