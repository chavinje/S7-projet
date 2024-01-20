#!/bin/bash

## install Mtables for Database 

IP=$(hostname -I | awk '{print $2}')

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/CreationTablesBDD.log"
DEBIAN_FRONTEND="noninteractive" 

#Repertoire ou se trouve mon fichier sql
REPERTOIRE="/var/www/html/projetinfralog-site-master"

echo "START - Installation des Tables de la BDD - "$IP

echo "START Premiere Etape Creation Database..."

mysql -e "CREATE DATABASE Basket" 


echo "START - Table equipes"
mysql Basket < /vagrant/scripts/equipes.sql
echo "END - Table "

echo "START - Table joueurs"
mysql Basket < /vagrant/scripts/joueurs.sql
echo "END - Table "

echo "START - Table matchs"
mysql Basket < /vagrant/scripts/matchs.sql
echo "END - Table "

echo "START - Table statistiques "
mysql Basket < /vagrant/scripts/statistiques.sql
echo "END - Table "


echo "END FIN Creation Database..."


echo "START Deuxieme Etape Creation/Chargement des tables de la BDD..."
mysql Basket < $REPERTOIRE/projet.sql;
echo "END  Creation/Chargement des tables de la BDD..."

sudo service mariadb restart

echo "END  Installation Tables BDD..."





