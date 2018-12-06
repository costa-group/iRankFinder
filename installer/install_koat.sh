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
        Path to install koat.
EOF
}
basedir=$(dirname "$(readlink -f "$0" )")
sudo=false
path=/opt/tools
while [ $# -gt 0 ]; do
    case $1 in
	-s|--sudo)
	    sudo=true
	    shift
	    ;;
	-p|--path)
	    if [ "${2:0:1}" = "/"]; then
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

install_opam(){
    install_apt opam
    opam init -y
    eval `opam config env`
    echo ". /root/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true" >> ~/.profile
    echo "      let () =" >> ~/.ocamlinit
    echo '        try Topdirs.dir_directory (Sys.getenv "OCAML_TOPLEVEL_PATH")' >> ~/.ocamlinit
    echo "        with Not_found -> ()" >> ~/.ocamlinit
    echo "      ;;" >> ~/.ocamlinit
    opam switch 4.04.0 -y
    eval `opam config env`
}

install_opam_libs(){
    opam install -y ocamlfind camlp4 ocamlgraph yojson apron
    opam install -y z3
    export LD_LIBRARY_PATH=~/.opam/system/lib/Z3:$LD_LIBRARY_PATH
}

install_dependencies(){
    ssudo apt-get -y update
    install_apt libgmp-dev libmpfr-dev libmpc-dev m4
    install_opam
    install_opam_libs
}

install_koat(){
    mkdir -p $path
    pushd $path >/dev/null
    echo -n "Cloning Koat repository..."
    git clone --quiet https://github.com/draperlaboratory/cage-koat.git > /dev/null
    pushd cage-koat > /dev/null
    echo " DONE."
    echo -n "Installing Koat..."
    make koat
    echo " DONE."
    popd > /dev/null
    echo "Finished installation of Koat."
    echo "==============================="
    echo ""
    popd > /dev/null
}

install_dependencies
install_koat

echo "Succeeded!"
