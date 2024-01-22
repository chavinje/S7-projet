#!/bin/bash

## install web server with php

IP=$(hostname -I | awk '{print $2}')

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/reverse_proxy.log"
DEBIAN_FRONTEND="noninteractive"

echo "START - install web Server - "$IP

echo "=> [1]: Installing required packages..."
apt-get update $APT_OPT \
  >> $LOG_FILE 2>&1


apt-get install $APT_OPT \
  wget \
  gnupg \
  unzip \
  curl \
  openssl \
  apache2 \
  git \
  sshpass \
  >> $LOG_FILE 2>&1


# Activation des modules pour le proxy
a2enmod proxy proxy_http  >> $LOG_FILE 2>&1


# création du frontend.conf pour effectuer un reverse proxy du port 223 vers le port 80
# Juste avec l'ip publique le front sera affiché
touch /etc/apache2/sites-available/frontend.conf
cat <<EOF > /etc/apache2/sites-available/frontend.conf
<VirtualHost *:80>
    ServerName groupe6.com
    ServerAlias www.groupe6.com
    
    ProxyPass / http://192.168.56.10:223/
    ProxyPassReverse / http://192.168.56.10:223/
    ProxyRequests Off
    
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF


# Création du backend.conf pour effectuer un reverse proxy du port 3000 vers le port 3000
# Ce port est le port pour le backend
touch /etc/apache2/sites-available/backend.conf
cat <<EOF > /etc/apache2/sites-available/backend.conf
<VirtualHost *:3000>
    ServerName groupe6.com
    ServerAlias www.groupe6.com

    ProxyPass / http://192.168.56.10:3000/
    ProxyPassReverse / http://192.168.56.10:3000/
    ProxyRequests Off
    
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF


# création du myadmin.conf pour effectuer un reverse proxy vers le port 228
# Ce port est le port pour le phpmyadmin
touch /etc/apache2/sites-available/myadmin.conf
cat <<EOF > /etc/apache2/sites-available/myadmin.conf
<VirtualHost *:228>
    ServerName groupe6.com
    ServerAlias www.groupe6.com
    
    ProxyPass / http://192.168.56.10:228/
    ProxyPassReverse / http://192.168.56.10:228/
    ProxyRequests Off
    
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF


# Activation des 3 fichiers de configuration créer
a2ensite backend.conf frontend.conf myadmin.conf >> $LOG_FILE 2>&1
a2dissite  000-default.conf >> $LOG_FILE 2>&1


# Ajouter les port d'écoute
sed -i 's/Listen 80/Listen 80\
Listen 3000\
Listen 228/g' /etc/apache2/ports.conf 

systemctl restart apache2


# Création des clé ssh
mkdir ~/.ssh
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -q -N "" >> $LOG_FILE 2>&1


# Copie des clé ssh vers les autres serveur
sshpass -p "vagrant" ssh-copy-id -i /root/.ssh/id_rsa.pub vagrant@192.168.56.10  >> $LOG_FILE 2>&1
sshpass -p "vagrant" ssh-copy-id -i /root/.ssh/id_rsa.pub vagrant@192.168.56.12  >> $LOG_FILE 2>&1
