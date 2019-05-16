#!/bin/bash


site=$1
shift
name=$1
shift


echo -e "Alias /"$name" \""$site"\"\n\
\n\
<Directory \""$site"\">\n\
   Options FollowSymlinks MultiViews Indexes IncludesNoExec\n\
   AllowOverride All\n\
   Require all granted\n\
</Directory>\n" > /etc/apache2/sites-available/$name-site.conf
chmod -R 755 $site
echo -e "RUN: \n\
    \ta2ensite $name-site \n\
    \tservice apache2 reload \n\
    \ta2enmod headers \n\
    \tservice apache2 restart"
