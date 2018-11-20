FROM php:5.6-apache
# docker build -t rankfinder .
# docker run -d -p 8081:80 --name rankfinder rankfinder
# docker exec -it rankfinder bash
RUN apt-get -y update \
 && apt-get -y install git emacs wget
RUN apt-get -y install make tar curl
RUN apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev
ARG TOOLS_HOME=/opt/tools

ENV TOOLS_HOME $TOOLS_HOME
RUN mkdir $TOOLS_HOME && chmod -R 755 $TOOLS_HOME
ENV PYRANKFINDER_HOME $TOOLS_HOME/pyRankFinder
RUN git clone https://github.com/costa-group/iRankFinder $TOOLS_HOME/iRankFinder
RUN $TOOLS_HOME/iRankFinder/installer/install_externals.sh

ADD https://api.github.com/repos/jesusjda/pyRankFinder/git/refs/heads/master version1.json
ARG mode=stable
ARG branch=master
ARG version=latest
ADD https://api.github.com/repos/costa-group/iRankFinder/git/refs/heads/master version2.json
RUN (cd $TOOLS_HOME/iRankFinder/installer/ && git pull )
RUN $TOOLS_HOME/iRankFinder/installer/install_modules.sh -m $mode -b $branch -v $version
ARG interface=true
RUN test $interface = "true" && \
       $TOOLS_HOME/iRankFinder/interface/install.sh --ei-home=$TOOLS_HOME/easyinterface --install-ei --ei-branch=develop
RUN a2ensite easyinterface-site
RUN a2enmod headers
