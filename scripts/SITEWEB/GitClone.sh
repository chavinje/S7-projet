#!/bin/bash

# Cloner le depot git
IP=$(hostname -I | awk '{print $2}')

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/GitClone.log"
DEBIAN_FRONTEND="noninteractive" 

#Repertoire ou se trouve mon fichier sql
REPERTOIRE="/var/www/html"

sudo apt-get install -y git

echo "START - GIT CLONE - "

#chemin du 000-default.conf
chemin_conf="/etc/apache2/sites-available/000-default.conf"

#chemin de la racine
chemin_racine="DocumentRoot /var/www/html"

#nouveau chemin de la racine 
chemin_racinenew="DocumentRoot /var/www/html/site/"

#Existance du repertoire
if [ -d "$REPERTOIRE/site" ]; then
    echo "=> [1] - Le répertoire existe"
    cd "$REPERTOIRE/site" || exit
    
    #cp -v "$REPERTOIRE/projetinfralog-site/projet.sql"  

    echo "=> [2] - Git pull"
    sudo git pull

else
    cd "$REPERTOIRE" || exit

    echo "=> [1] - Git clone"
    git clone -b master "https://gitlab.com/MateoESEO/projetinfralog-site.git" /var/www/html/site

    cd site || exit

    #echo "=> [2] - Git checkout Giovanni "
    #git checkout Giovanni

    #echo "=> [3] - Configuration du git pull"
    #git config pull.rebase false --global

    echo "=> [2] - Suppression des fichiers inutiles"
    
    # Suppression de tous les autres fichiers inutiles
    #rm -r /var/www/html/site
    
fi

echo "END - CLONE Termine"

