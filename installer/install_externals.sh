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
EOF
}

sudo=false
while [ $# -gt 0 ]; do
    case $1 in
	-s|--sudo)
	    sudo=true
	    shift
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

ssudo(){
    if [ "$sudo" == "true" ]; then
	sudo -H $@
    else
	$@
    fi
}

install_apt(){
    ssudo apt-get install -y $@
}

install_dependencies(){
    ssudo python3 -m pip install z3-solver 'Cython==0.28.2' virtualenv
    ssudo python3 -m pip install cysignals
    ssudo python3 -m pip install "git+https://github.com/aleaxit/gmpy.git@gmpy2-2.1.0a0#egg=gmpy2"
}

install_ppl(){
    mkdir /tmp/ppl
    pushd /tmp/ppl > /dev/null
    wget http://bugseng.com/products/ppl/download/ftp/releases/1.2/ppl-1.2.tar.gz
    gunzip ppl-1.2.tar.gz
    tar xvfp ppl-1.2.tar
    cd ppl-1.2
    ./configure --prefix=/usr/local --with-gmp=/usr/local --enable-interfaces="swi_prolog,c++"
    make
    ssudo make install
    popd > /dev/null
    # chmod a+rwx -R /usr/local/lib/ppl
    install_apt libppl-dev graphviz
    echo "PPL Installed"
}

install_z3(){
    mkdir -p /tmp/z3
    pushd /tmp/z3 > /dev/null
    echo -n  "Cloning z3..."
    vers=4.8.1
    wget https://github.com/Z3Prover/z3/archive/z3-$vers.tar.gz
    tar -xvzf z3-$vers.tar.gz
    cd z3-z3-$vers
    echo "DONE"
    echo "mk_make... ml and python bindings" 
    ssudo python3 scripts/mk_make.py --python
    cd build
    echo "Make"
    make
    echo "Make Install"
    ssudo make install
    popd > /dev/null
    rm -rf /tmp/z3
    echo "Z3 Installed"
}

install_externals(){
    ssudo apt-get -y update
    install_apt python3 python3-dev python3-nose python3-pip
    install_apt libgmp-dev libmpfr-dev libmpc-dev
    install_ppl
    # install_z3
    install_dependencies
}

install_externals

