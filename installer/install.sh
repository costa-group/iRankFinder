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
        Install 'stable' or 'clone' mode. ('dev' or 'static' not ready)
        By default: stable

    -b | --branch [BRANCH] )
        For 'clone' mode, choose the branch that you want.
        By default: master

    -s | --sudo )
        Install with sudo rights.

EOF
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
	    help "ERROR" >&2  
	    exit -1
	    version=$2
	    shift 2
	    ;;
	-b|--branch )
	    branch=$2
	    shift 2
	    ;;
	-ne| --no-externals)
	    externals=false
	    shift
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

if [ "$externals" == "true" ]; then
    ex_flags=""
    if [ "$sudo" == "true" ]; then
	ex_flags=$ex_flags" --sudo"
    fi
    $basedir/install_externals.sh $ex_flags
fi

mod_flags=""
if [ "$sudo" == "true" ]; then
    mod_flags=$mod_flags" --sudo"
fi
$basedir/install_modules.sh -p $path -m $mode -v $version -b $branch $mod_flags
