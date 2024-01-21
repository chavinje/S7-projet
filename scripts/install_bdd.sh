#!/bin/bash

## install Mariadb server (ex Mysql))

IP=$(hostname -I | awk '{print $2}')
APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/install_bdd.log"
DEBIAN_FRONTEND="noninteractive" 

#Utilisateur a créer (si un vide alors pas de création)
DBNAME="Basket"
DBUSER="moodle_user"
DBPASSWD="network"
#Fichier sql à injecter (présent dans un sous répertoire)
DBFILE="files/infralogiciel.sql"

echo "START - install MariaDB - "$IP

echo "=> [1]: Install required packages ..."
DEBIAN_FRONTEND=noninteractive

apt-get install -o Dpkg::Progress-Fancy="0" -q -y \
	mariadb-server \
	mariadb-client \
   >> $LOG_FILE 2>&1

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

#Accès à la BBD  depuis n'importe ou

#sudo apt-get install debconf-utils -y

  #echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | sudo debconf-set-selections
  #echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | sudo debconf-set-selections
  #echo 'phpmyadmin phpmyadmin/mysql/admin-pass password network' | sudo debconf-set-selections
  #echo 'phpmyadmin phpmyadmin/mysql/app-pass password network' | sudo debconf-set-selections
  #echo 'phpmyadmin phpmyadmin/app-password-confirm password network' | sudo debconf-set-selections

  #sudo apt-get install phpmyadmin -y

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
#Activation du port 3306 de la BDD
sed -i 's/# port = 3306/port = 3306/g' /etc/mysql/my.cnf

sudo systemctl restart mariadb
sudo systemctl reload mariadb
sudo service mariadb restart


echo "END - install MariaDB:)"


#Externalisation de la donnée importante 

