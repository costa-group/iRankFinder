#!/bin/bash

EI_HOME=~/Systems/easyinterface
INSTALL_EI=false
basedir=$(dirname "$(readlink -f "$0" )")
EX_HOME=~/tmp/examples
EX_REMOTE=/tmp/examples
examples=false
EI_BR="master"
DOMAIN="iRankFinder"
for i in "$@"; do
    case $i in
	--ei-home=*)
	    EI_HOME="${i#*=}"
	    shift
	    ;;
	--install-ei)
	    INSTALL_EI=true
	    shift
	    ;;
	--ei-branch=*)
	    EI_BR="${i#*=}"
	    shift
	    ;;
	--examples=* )
	    examples="${i#*=}"
	    shift
	    ;;
	--ex-home=* )
	    EX_HOME="${i#*=}"
	    shift
	    ;;
	--ex-remote=* )
	    EX_REMOTE="${i#*=}"
	    shift
	    ;;
	*)
	    >&2 cat  <<EOF
ERROR: easyinterface-config/install.sh [OPTIONS]

[OPTIONS]

    --ei-home=[PATH] )
        Path to easyinterface. Default: ~/Systems/easyinterface

    --install-ei )
        Install easyinterface with personal config.

    --ei-branch=[NAME] )
        Branch from where you want easyinterface installation
        Default: master

    --examples=[PATH] )
        Script wich install examples

    --ex-home=[PATH] )
        Local path were remote examples will be download

    --ex-remote=[PATH] )
        server path where the examples will be accesible from


EOF
	    exit -1
            # unknown option
	    ;;
    esac
done


install_ei(){
    if [ ! -d $EI_HOME ]; then
	mkdir -p $EI_HOME
	git clone https://github.com/abstools/easyinterface.git $EI_HOME
    fi
    pushd $EI_HOME
    git checkout $EI_BR
    popd
    echo -e "Alias /ei \""$EI_HOME"\"\n\
\n\
<Directory \""$EI_HOME"\">\n\
   Options FollowSymlinks MultiViews Indexes IncludesNoExec\n\
   AllowOverride All\n\
   Require all granted\n\
</Directory>\n" > /etc/apache2/sites-available/easyinterface-site.conf
    chmod -R 755 $EI_HOME
    echo -e "RUN: \n\
    \ta2ensite easyinterface-site \n\
    \tservice apache2 reload \n\
    \ta2enmod headers \n\
    \tservice apache2 restart"
}

install_ex(){
    mkdir -p $EX_HOME
    $examples $EX_HOME $EX_REMOTE > $basedir/config/examples_remote.cfg
    echo -e "Alias "$EX_REMOTE" \""$EX_HOME"\"\n\
\n\
<Directory \""$EX_HOME"\">\n\
   Options FollowSymlinks MultiViews Indexes IncludesNoExec\n\
   AllowOverride All\n\
   Require all granted\n\
</Directory>\n" > /etc/apache2/sites-available/example-site.conf
    chmod -R 755 $EX_HOME
    echo -e "RUN: \n\
    \ta2ensite example-site \n\
    \tservice apache2 reload \n\
    \ta2enmod headers \n\
    \tservice apache2 restart"
}
if [ "$INSTALL_EI" == "true" ]; then
    install_ei
fi

if [ "$examples" != "false" ]; then
    install_ex
fi

echo "Link folders"

if [ ! -L "$EI_HOME/server/config/$DOMAIN" ] ; then
	ln -s $basedir/config $EI_HOME/server/config/$DOMAIN
fi

if [ ! -L "$EI_HOME/server/bin/$DOMAIN" ] ; then
        ln -s $basedir/bin $EI_HOME/server/bin/$DOMAIN
fi

RND=$(date +%s)
if [ -f "$EI_HOME/server/config/eiserver.cfg" ] ; then
	mv $EI_HOME/server/config/eiserver.cfg $EI_HOME/server/config/eiserver_old_$RND.cfg
fi

if [ -f "$EI_HOME/clients/web/webclient.cfg" ] ; then
        mv $EI_HOME/clients/web/webclient.cfg $EI_HOME/clients/web/webclient_old_$RND.cfg
fi
RND=""

echo "Moving config files"

cp $basedir/server.cfg $EI_HOME/server/config/eiserver.cfg
cp $basedir/web.cfg $EI_HOME/clients/web/webclient.cfg

echo "Finished!"

