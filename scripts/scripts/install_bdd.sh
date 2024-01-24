#!/bin/bash

## install Mariadb server (ex Mysql))

IP=$(hostname -I | awk '{print $2}')
APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/install_bdd.log"
DEBIAN_FRONTEND="noninteractive"

#Utilisateur a créer (si un vide alors pas de création)
DBNAME="lagence"
DBUSER="admin"
DBPASSWD="network"

#Fichier sql à injecter (présent dans un sous répertoire)
DBFILE="files/creation_bdd.sql"

echo "START - install MariaDB - "$IP

echo "=> [1]: Install required packages ..."
DEBIAN_FRONTEND=noninteractive
apt-get install -o Dpkg::Progress-Fancy="0" -q -y \
	mariadb-server \
	mariadb-client \
  >> $LOG_FILE 2>&1
  
# Donner l'accès au port 3306 depuis n'importe qu'elle addresse
# on peut remplacer le 192.168.56.12 par le 0.0.0.0
sed -i 's/127.0.0.1/192.168.56.12/g' /etc/mysql/mariadb.conf.d/50-server.cnf

echo "=> [2]: Configuration du service"
if [ -n "$DBNAME" ] && [ -n "$DBUSER" ] && [ -n "$DBPASSWD" ] ;then
  mysql -e "CREATE DATABASE $DBNAME" \
  >> $LOG_FILE 2>&1
  mysql -e "grant all privileges on $DBNAME.* to '$DBUSER'@'%' identified by '$DBPASSWD'" \
  >> $LOG_FILE 2>&1
fi

echo "=> [3]: Configuration de BDD"
if [ -f "$DBFILE" ] ;then
  mysql < /vagrant/$DBFILE \
  >> $LOG_FILE 2>&1
fi
systemctl restart mariadb.service

echo "END - install MariaDB"