#!/bin/bash

## install Mtables for Database 

IP=$(hostname -I | awk '{print $2}')

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/CreationTablesBDD.log"
DEBIAN_FRONTEND="noninteractive" 

#Repertoire ou se trouve mon fichier sql
REPERTOIRE="/var/www/html/site"

sudo apt-get install mariadb-client

echo "START - Installation des Tables de la BDD - "$IP

echo "START Premiere Etape Creation Database..."


#mysql -e "CREATE DATABASE Basket" 

#1er moyen de configurer la BDD par la creation de tables à partir de scripts sql
echo "START - Table equipes"
mysql Basket < /vagrant/SQL/equipes.sql
echo "END - Table "

echo "START - Table joueurs"
mysql Basket < /vagrant/SQL/joueurs.sql
echo "END - Table "

echo "START - Table matchs"
mysql Basket < /vagrant/SQL/matchs.sql
echo "END - Table "

echo "START - Table statistiques "
mysql Basket < /vagrant/SQL/statistiques.sql
echo "END - Table "


echo "END FIN Creation Database..."

#Deuxieme moyen pour configuer la BDD par injection d'un fichier sql
echo "START Deuxieme Etape Creation/Chargement des tables de la BDD..."
#mysql Basket < $REPERTOIRE/projet.sql;
echo "END  Creation/Chargement des tables de la BDD..."

sudo service mariadb restart

echo "END  Installation Tables BDD..."





