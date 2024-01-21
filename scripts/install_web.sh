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
  screen \
  >> $LOG_FILE 2>&1

curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash - >> $LOG_FILE 2>&1

apt-get install nodejs -y >> $LOG_FILE 2>&1
npm install -g  create-react-app >> $LOG_FILE 2>&1
npm install -g typescript >> $LOG_FILE 2>&1
npm install -g tsc-watch >> $LOG_FILE 2>&1
npm install --save-dev ts-node >> $LOG_FILE 2>&1

echo "=> [2]: Apache2 configuration"
# Add configuration of /etc/apache2

sed -i 's/Listen 80/Listen 80\
Listen 223\
Listen 228/g' /etc/apache2/ports.conf 

# File creation frontend.conf
touch /etc/apache2/sites-available/frontend.conf
printf '<VirtualHost *:223>\n' > /etc/apache2/sites-available/frontend.conf
printf '\tDocumentRoot /var/www/html/frontend\n' >> /etc/apache2/sites-available/frontend.conf
printf '\tServerName frontend.local\n' >> /etc/apache2/sites-available/frontend.conf
printf '\tErrorLog ${APACHE_LOG_DIR}/frontend_error.log\n' >> /etc/apache2/sites-available/frontend.conf
printf '\tCustomLog ${APACHE_LOG_DIR}/frontend_access.log combined\n\n' >> /etc/apache2/sites-available/frontend.conf
printf '\t<Directory /var/www/html/frontend>\n' >> /etc/apache2/sites-available/frontend.conf
printf '\t\tOptions Indexes FollowSymLinks MultiViews\n' >> /etc/apache2/sites-available/frontend.conf
printf '\t\tAllowOverride All\n' >> /etc/apache2/sites-available/frontend.conf
printf '\t\tOrder allow,deny\n' >> /etc/apache2/sites-available/frontend.conf
printf '\t\tallow from all\n\n' >> /etc/apache2/sites-available/frontend.confprintf '<Directory /var/www/html/frontend>\n' >> /etc/apache2/sites-available/frontend.conf
printf '\t\tOptions Indexes FollowSymLinks MultiViews\n' >> /etc/apache2/sites-available/frontend.conf
printf '\t\tRequire all granted\n' >> /etc/apache2/sites-available/frontend.conf
printf '\t\tRewriteEngine on\n' >> /etc/apache2/sites-available/frontend.confprintf '<Directory /var/www/html/frontend>\n' >> /etc/apache2/sites-available/frontend.conf
printf '\t\tRewriteBase /\n' >> /etc/apache2/sites-available/frontend.conf
printf '\t\tRewriteRule ^index\.html$ - [L]\n' >> /etc/apache2/sites-available/frontend.conf
printf '\t\tRewriteCond %%{REQUEST_FILENAME} !-f\n' >> /etc/apache2/sites-available/frontend.conf
printf '\t\tRewriteCond %%{REQUEST_FILENAME} !-d\n' >> /etc/apache2/sites-available/frontend.conf
printf '\t\tRewriteRule . /index.html [L]\n' >> /etc/apache2/sites-available/frontend.conf
printf '\t</Directory>\n' >> /etc/apache2/sites-available/frontend.conf
printf '</VirtualHost>\n' >> /etc/apache2/sites-available/frontend.conf


# File creation myadmin.conf
touch /etc/apache2/sites-available/myadmin.conf
printf '<VirtualHost *:228>\n' > /etc/apache2/sites-available/myadmin.conf
printf 'DocumentRoot /var/www/html/myadmin\n' >> /etc/apache2/sites-available/myadmin.conf
printf 'ServerName myadmin.local\n\n' >> /etc/apache2/sites-available/myadmin.conf
printf 'ErrorLog ${APACHE_LOG_DIR}/myadmin.log\n' >> /etc/apache2/sites-available/myadmin.conf
printf 'CustomLog ${APACHE_LOG_DIR}/myadmin_access.log combined\n' >> /etc/apache2/sites-available/myadmin.conf
printf '</VirtualHost>\n' >> /etc/apache2/sites-available/myadmin.conf

a2ensite frontend.conf myadmin.conf
a2enmod rewrite

echo "Frontend prêt et accessible sur l'ip publique et le port 80"
echo "Phpmyadmin prêt et accessible sur l'ip publique et le port 228"

echo "END - install web Server"
