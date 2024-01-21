#!/bin/bash

## déplace les fichiers du site

IP=$(hostname -I | awk '{print $2}')

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/install_git.log"
DEBIAN_FRONTEND="noninteractive"

echo "START - Deplacement des fichiers - "$IP

cd /var/www/html/
#touch /var/www/html

#mkdir /var/www/html/site/

git clone -b master https://gitlab.com/MateoESEO/projetinfralog-site.git   /var/www/html/site
#mkdir /var/www/html/site/

#rm -r /var/www/html/site/


echo "END - Deplacement des fichiers"