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
  php \
  libapache2-mod-php \
  php-mysql \
  php-intl \
  php-curl \
  php-xmlrpc \
  php-soap \
  php-gd \
  php-json \
  php-cli \
  php-pear \
  php-xsl \
  php-zip \
  php-mbstring \
  >> $LOG_FILE 2>&1

curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash - >> $LOG_FILE 2>&1

apt-get install nodejs -y >> $LOG_FILE 2>&1

npm install -g  create-react-app >> $LOG_FILE 2>&1


echo "=> [2]: Apache2 configuration"
	# Add configuration of /etc/apache2
#create-react-app /var/www/html >> $LOG_FILE 2>&1

cd /var/www/html && npx create-react-app react-app && cd >> $LOG_FILE 2>&1

cp -r /tmp/web/App.js /var/www/html/react/src/App.js

npm --prefix /var/www/html/react start 192.168.56.10 > /dev/null 2>&1 &

echo "END - install web Server"

