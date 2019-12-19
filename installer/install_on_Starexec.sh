#!/bin/bash

ssudo(){

}

install_pkg(){
    ssudo yum -y install $@
}

install_python(){
    install_pkg epel-release
    install_pkg python34 python34-devel python34-setuptools
    easy-install-3.4 pip
}

install_ppl(){
    install_pkg gmp-devel mpfr-devel libmpc-devel
    ...
}

install_pip_pkgs(){
    ssudo pip3 install virtualenv
    ssudo pip3 install z3-solver "Cython==0.28.2"
    ssudo CFLAGS="-Wp,-U_FORTIFY_SOURCE" pip3 install cysignals
    ssudo pip3 install "git+https://github.com/aleaxit/gmpy.git@gmpy2-2.1.0a0#egg=gmpy2"
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
