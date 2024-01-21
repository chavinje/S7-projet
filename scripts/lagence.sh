#!/bin/bash

# Variables
REPO_URL="https://github.com/JAWS-tm/L-agence.git"
DESTINATION_FOLDER="/projet/"

# Vérifier si le dossier existe
if [ -d "$DESTINATION_FOLDER" ]; then
    # Le dossier existe, effectuer un git pull
    cd $DESTINATION_FOLDER
    git pull # Assurez-vous de remplacer "master" par votre branche principale si elle est différente
else
    # Le dossier n'existe pas, cloner le dépôt Git
    mkdir /projet
    chown vagrant:vagrant /projet
    cd $DESTINATION_FOLDER
    git clone "$REPO_URL" "$DESTINATION_FOLDER"
fi

cd

#cp -r /vagrant/lagence /projet


cd /projet/L-agence/packages/frontend &&\
 npm install &&\
 npm run build >> $LOG_FILE 2>&1 
cd

cp -r /projet/L-agence/packages/frontend/dist /var/www/html/frontend

systemctl restart apache2

echo "Frontend"

touch /projet/L-agence/packages/backend/.env
printf '# Database\n' > /projet/L-agence/packages/backend/.env
printf 'DB_HOST=192.168.56.12\n' >> /projet/L-agence/packages/backend/.env
printf 'DB_PORT=3306\n' >> /projet/L-agence/packages/backend/.env
printf 'DB_USERNAME=admin\n' >> /projet/L-agence/packages/backend/.env
printf 'DB_PASSWORD=network\n' >> /projet/L-agence/packages/backend/.env
printf 'DB_DATABASE=lagence\n\n' >> /projet/L-agence/packages/backend/.env

printf 'MAILER_EMAIL=eseolagence@gmail.com\n' >> /projet/L-agence/packages/backend/.env
printf 'MAILER_PASSWORD="idkl nueb jgrt gpaq "\n' >> /projet/L-agence/packages/backend/.env

cd /projet/L-agence/packages/backend
npm install
screen -S node_session -d -m npm run start
cd

echo "Backend prêt sur le "

echo "END - install web Server"