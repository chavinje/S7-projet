#!/bin/bash

# Cloner le depot git
IP=$(hostname -I | awk '{print $2}')

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/GitClone.log"
DEBIAN_FRONTEND="noninteractive" 

#Repertoire ou se trouve mon fichier sql
REPERTOIRE="/var/www/html"


echo "START - GIT CLONE - "

#chemin du 000-default.conf
chemin_conf="/etc/apache2/sites-available/000-default.conf"

#chemin de la racine
chemin_racine="DocumentRoot /var/www/html"

#nouveau chemin de la racine 
chemin_racinenew="DocumentRoot /var/www/html/projetinfralog-site-master/"

#Existance du repertoire
if [-d "$REPERTOIRE/projetinfralog-site-master"];then
    echo "=> [1] - Le répertoire existe"
    cd "$REPERTOIRE/projetinfralog-site-master" || exit
    #
    #cp -v "$REPERTOIRE/projetinfralog-site-master/projet.sql"  

    echo "=> [2] - Git pull"
    git pull

else
    cd "$REPERTOIRE" || exit

    echo "=> [1] - Git clone"
    git clone "https://gitlab.com/MateoESEO/projetinfralog-site.git"

    cd projetinfralog-site-master || exit

    #echo "=> [2] - Git checkout Giovanni "
    #git checkout Giovanni

    #echo "=> [3] - Configuration du git pull"
    #git config pull.rebase false --global

    echo "=> [2] - Suppression des fichiers inutiles"
    
    # Suppression de tous les autres fichiers inutiles
    rm -r /var/www/html/projetinfralog-site-master
    
fi

echo "END - CLONE Termine"

