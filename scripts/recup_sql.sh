#!/bin/bash

## déplace les fichiers du site

IP=$(hostname -I | awk '{print $2}')

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/install_git.log"
DEBIAN_FRONTEND="noninteractive"

echo "START - Deplacement des fichiers - "$IP

cd /var/www/html/site
mkdir git
cd git
git clone https://github.com/

mkdir /var/www/html/site/

rm -r /var/www/html/git/Projet-InfraLogiciel/.vscode
rm -r /var/www/html/git/Projet-InfraLogiciel/livrables
rm -r /var/www/html/git/Projet-InfraLogiciel/timefusion-dekstop
rm -r /var/www/html/git/Projet-InfraLogiciel/timefusion-web
rm -r /var/www/html/git/Projet-InfraLogiciel/VM
rm /var/www/html/git/Projet-InfraLogiciel/Configurations.txt
rm /var/www/html/git/Projet-InfraLogiciel/ProjetInfraLog.drawio
rm /var/www/html/git/Projet-InfraLogiciel/README.md

echo "END - Deplacement des fichiers"
