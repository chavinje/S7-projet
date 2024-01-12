#!/bin/bash

## install web server with php

IP=$(hostname -I | awk '{print $2}')

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/install_web.log"
DEBIAN_FRONTEND="noninteractive"

echo "START - install web Server - "$IP

echo "=> [1]: Installing required packages..."
apt-get install $APT_OPT \
  apache2 \
  >> $LOG_FILE 2>&1
#  php \
#  libapache2-mod-php \
#  php-mysql \
#  php-intl \
#  php-curl \
#  php-xmlrpc \
#  php-soap \
#  php-gd \
#  php-json \
#  php-cli \
#  php-pear \
#  php-xsl \
#  php-zip \
#  php-mbstring \

curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash - >> $LOG_FILE 2>&1

apt-get install nodejs -y >> $LOG_FILE 2>&1

npm install -g  create-react-app >> $LOG_FILE 2>&1


echo "=> [2]: Apache2 configuration"
	# Add configuration of /etc/apache2
#create-react-app /var/www/html >> $LOG_FILE 2>&1

#sed -i 's/\/var\/www\/html/\/var\/www\/html\/react-app\/build/g' /etc/apache2/sites-available/000-default.conf

mkdir /projet

#cd /projet &&\
  #npx create-react-app react-app \
    #>> $LOG_FILE 2>&1

#chown vagrant:vagrant /projet/react-app/

#cp -a /tmp/web/* /projet/react-app/src/

#cd /projet/react-app &&\
  #npm run build\
  >> $LOG_FILE 2>&1

echo "ok"

#npm --prefix /projet/react-app start 192.168.56.10 > /dev/null 2>&1 &


#cd

#cp -a /projet/react-app/build/* /var/www/html/

systemctl restart apache2

#cp /tmp/web/App.js /var/www/html/react-app/src/App.js
touch /var/www/html/.htaccess
printf '# Ce fichier donne un accès aux autres fichiers\n' > /var/www/html/.htaccess
printf 'Options=Multiviews\n' >> /var/www/html/.htaccess
printf 'RewriteEngine On\n' >> /var/www/html/.htaccess
printf 'RewriteCond %%{REQUEST_FILENAME} !-f\n' >> /var/www/html/.htaccess
printf 'RewriteRule ^ index.html \[QSA,L\]\n' >> /var/www/html/.htaccess

#npm --prefix /var/www/html/react-app start 192.168.56.10 > /dev/null 2>&1 &

echo "END - install web Server"

