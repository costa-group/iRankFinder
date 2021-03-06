FROM php:5.6-apache
# docker build -t rankfinder .
# docker run -d -p 8081:80 --name rankfinder rankfinder
# docker exec -it rankfinder bash

ARG TOOLS_HOME=/opt/tools
ARG mode=stable
ARG dev_branch=unstable
ARG version=latest
ARG interface=true
ENV TOOLS_HOME $TOOLS_HOME
ENV PYRANKFINDER_HOME $TOOLS_HOME/pyRankFinder
ENV PATH $PYRANKFINDER_HOME/:$PATH

RUN apt-get -y update \
 && apt-get -y install git emacs wget \
 && apt-get -y install make tar curl \
 && apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
                       libreadline-dev libsqlite3-dev wget curl llvm \
		       libncurses5-dev libncursesw5-dev xz-utils tk-dev

ADD https://api.github.com/repos/costa-group/iRankFinder/git/refs/heads/master version2.json

RUN mkdir $TOOLS_HOME && chmod -R 755 $TOOLS_HOME && \
    git clone https://github.com/costa-group/iRankFinder $TOOLS_HOME/iRankFinder && \
     $TOOLS_HOME/iRankFinder/installer/install_externals.sh
RUN $TOOLS_HOME/iRankFinder/installer/install_modules.sh -m $mode -b $dev_branch -v $version -p $TOOLS_HOME

RUN test $interface = "true" && \
       $TOOLS_HOME/iRankFinder/interface/install.sh --ei-home=$TOOLS_HOME/easyinterface --install-ei --ei-branch=develop && \
       a2ensite easyinterface-site

RUN test $interface = "true" && \
       cp $TOOLS_HOME/iRankFinder/web/index.html /var/www/html/index.html && \
       a2enmod headers

