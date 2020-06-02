#!/bin/bash

set -e

install_pkg(){
    yum -y install $@
}

install_python(){
    install_pkg epel-release
    install_pkg python3 python3-devel python3-setuptools
    easy_install-3.6 pip
}

install_ppl(){
    install_pkg gmp-devel mpfr-devel libmpc-devel
    mkdir /tmp/ppl
    pushd /tmp/ppl > /dev/null
    wget https://bugseng.com/products/ppl/download/ftp/releases/1.2/ppl-1.2.tar.gz
    gunzip ppl-1.2.tar.gz
    tar xvfp ppl-1.2.tar
    cd ppl-1.2
    ./configure --prefix=/usr/local --with-gmp=/usr/local --enable-interfaces="swi_prolog,c++"
    make
    make install
    popd > /dev/null
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
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
    python3 scripts/mk_make.py --python
    cd build
    echo "Make"
    make
    echo "Make Install"
    make install
    popd > /dev/null
    rm -rf /tmp/z3
    echo "Z3 Installed"
}

install_pip_pkgs(){
    pip3 install virtualenv
    pip3 install z3-solver "Cython==0.28.2"
    CFLAGS="-Wp,-U_FORTIFY_SOURCE" pip3 install cysignals
    pip3 install "git+https://github.com/aleaxit/gmpy.git@gmpy2-2.1.0a0#egg=gmpy2"
    ldconfig -v
}


install_ciao(){
    install_pkg glibc-devel.i686 glibc-devel libstdc++-devel.i686
    install_pkg rlwrap
    git clone https://github.com/ciao-lang/ciao/
    pushd ciao
    ./ciao-boot.sh global-install
    popd
}

install_pe(){
    install_ciao
    ciao get ciao_ppl
    install_pkg gperf
    ciao get github.com/jfmc/ciao_yices
    ciao get github.com/bishoksan/chclibs
    ciao get github.com/bishoksan/RAHFT
    git clone https://github.com/jesusjda/pe
}

install_pe_bin(){
    pushd $1/pyRankFinder/partialevaluation/bin > /dev/null
    wget https://github.com/jesusjda/pe/releases/download/v1/pe_rhel7.zip
    unzip -o pe_rhel7.zip
    rm -f pe_rhel7.zip
    cd ../../
    python3 -m pip install -U .
    popd > /dev/null

}


install_python
install_pkg llvm3.9-devel clang.x86_64
install_pip_pkgs
install_ppl
# install_z3
# install_pe
./install_modules.sh -m dev -b unstable -p /opt/tools
install_pe_bin /opt/tools
