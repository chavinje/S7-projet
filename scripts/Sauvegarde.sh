#!/bin/bash

## install mysql client

IP=$(hostname -I | awk '{print $2}')
APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/install_backup.log"
DEBIAN_FRONTEND="noninteractive"

# Définition des variables pour pouvoir se connecter à la base de données
BDD_HOST='192.168.56.81'
BDD_USER='moodle_user' 
BDD_PASS='network'
BDD_NAME='Basket'

echo "START - Configuration de la VM backup  - "$IP


echo "=> [1]: Install required packages ..."
DEBIAN_FRONTEND=noninteractive
sudo apt-get install -y
sudo apt-get update -y
sudo apt-get install $APT_OPT \
    
    mariadb-client \
>> $LOG_FILE 2>&1

# Créer la tache cron
crontab /tmp/cron_backup.sh

echo "=> [2]: Configuration de la tâche cron"

# Ecrire la tache cron dans un fichier temporaire
# Création d'un fichier de backup tous les jours à 1h00 du mat
echo "0 1 * * *  mysqldump -h ${BDD_HOST} -u ${BDD_USER} -p${BDD_PASS} ${BDD_NAME} > /vagrant/files/backup_$(date +\%Y\%m\%d).sql" | sudo sed 's/$(date +\%Y\%m\%d)/`date +\%Y\%m\%d`/' > /tmp/cron_backup.sh
echo "0 0 * * 1  find /vagrant/files/backup_* -mtime +7 -delete" >> /tmp/cron_backup.sh

# Créer la tache cron
#crontab /tmp/cron_backup.sh

# Supprimer le fichier temporaire
# rm /tmp/cron_backup.sh

echo "END - Configuration de la VM backup"