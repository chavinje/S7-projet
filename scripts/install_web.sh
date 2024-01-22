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
cat <<EOF > /etc/apache2/sites-available/frontend.conf
<VirtualHost *:223>
    DocumentRoot /var/www/html/frontend
    ServerName frontend.local
    
    ErrorLog ${APACHE_LOG_DIR}/frontend_error.log
    CustomLog ${APACHE_LOG_DIR}/frontend_access.log combined

    <Directory /var/www/html/frontend>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        allow from all

        Options Indexes FollowSymLinks MultiViews
        Require all granted
        RewriteEngine on
        RewriteBase /
        RewriteRule ^index\.html$ - [L]
        RewriteCond %%{REQUEST_FILENAME} !-f
        RewriteCond %%{REQUEST_FILENAME} !-d
        RewriteRule . /index.html [L]
    </Directory>
</VirtualHost>
EOF



# File creation myadmin.conf
touch /etc/apache2/sites-available/myadmin.conf
cat <<EOF > /etc/apache2/sites-available/myadmin.conf
<VirtualHost *:228>
    DocumentRoot /var/www/html/myadmin
    ServerName myadmin.local

    ErrorLog ${APACHE_LOG_DIR}/myadmin.log
    CustomLog ${APACHE_LOG_DIR}/myadmin_access.log combined
</VirtualHost> 
EOF

a2ensite frontend.conf myadmin.conf
a2enmod rewrite

echo "Frontend prêt et accessible sur l'ip publique et le port 80"
echo "Phpmyadmin prêt et accessible sur l'ip publique et le port 228"
echo "Attendre la mise en place du site"

echo "END - install web Server"
