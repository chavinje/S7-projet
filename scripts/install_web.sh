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

npm install -g typescript >> $LOG_FILE 2>&1

npm install -g tsc-watch >> $LOG_FILE 2>&1

npm install --save-dev ts-node >> $LOG_FILE 2>&1

echo "=> [2]: Apache2 configuration"
	# Add configuration of /etc/apache2
#create-react-app /var/www/html >> $LOG_FILE 2>&1

#sed -i 's/\/var\/www\/html/\/var\/www\/html\/react-app\/build/g' /etc/apache2/sites-available/000-default.conf
cp -r /vagrant/lagence /projet

chown vagrant:vagrant /projet

cd /projet/packages/frontend &&\
 npm install &&\
 npm run build > /dev/null 2>&1 &

touch /projet/packages/backend/.env

printf'# Database\n' > /projet/packages/backend/.env
printf'DB_HOST=192.168.56.12\n' >> /projet/packages/backend/.env
printf'DB_PORT=3306\n' >> /projet/packages/backend/.env
printf'DB_USERNAME=admin\n' >> /projet/packages/backend/.env
printf'DB_PASSWORD=network\n' >> /projet/packages/backend/.env
printf'DB_DATABASE=lagence\n\n' >> /projet/packages/backend/.env

printf'MAILER_EMAIL=eseolagence@gmail.com\n' >> /projet/packages/backend/.env
printf'MAILER_PASSWORD="idkl nueb jgrt gpaq "\n' >> /projet/packages/backend/.env

cd /projet/packages/backend &&\
 npm install &&\
 npm run start > /dev/null 2>&1 &

cd

cp -r /projet/packages/frontend/dist /var/www/html/frontend
cp -r /projet/packages/backend/dist /var/www/html/backend

#mkdir /projet

#cd /projet &&\
  #npx create-react-app react-app \
    #>> $LOG_FILE 2>&1

#chown vagrant:vagrant /projet/react-app/

#cp -a /tmp/web/* /projet/react-app/src/

#cd /projet/react-app &&\
  #npm run build\
  #>> $LOG_FILE 2>&1

echo "ok"

#npm --prefix /projet/react-app start 192.168.56.10 > /dev/null 2>&1 &


#cd

#cp -a /projet/react-app/build/* /var/www/html/

systemctl restart apache2

#cp /tmp/web/App.js /var/www/html/react-app/src/App.js
#touch /var/www/html/.htaccess
#printf '# Ce fichier donne un accès aux autres fichiers\n' > /var/www/html/.htaccess
#printf 'Options=Multiviews\n' >> /var/www/html/.htaccess
#printf 'RewriteEngine On\n' >> /var/www/html/.htaccess
#printf 'RewriteCond %%{REQUEST_FILENAME} !-f\n' >> /var/www/html/.htaccess
#printf 'RewriteRule ^ index.html \[QSA,L\]\n' >> /var/www/html/.htaccess

#npm --prefix /var/www/html/react-app start 192.168.56.10 > /dev/null 2>&1 &

echo "END - install web Server"

