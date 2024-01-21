#!/bin/bash

# Variables
REPO_URL="https://github.com/JAWS-tm/L-agence.git"
DESTINATION_FOLDER="/projet/L-agence"
LOG_FILE="/vagrant/logs/lagence.log"

# Vérifier si le dossier existe
if [ -d "$DESTINATION_FOLDER" ]; then
    # Si le dossier est présent, un git pull pour une mise à jour du projet web
    cd $DESTINATION_FOLDER
    git pull >> $LOG_FILE 2>&1 
    screen -X -S node_session quit
    echo "Mise à jour du site effectuée"
else
    # Le dossier n'existe pas, cloner le dépôt Git
    mkdir /projet
    chown vagrant:vagrant /projet
    cd /projet
    git clone "$REPO_URL" >> $LOG_FILE 2>&1 
    cd
    echo "Site mise en place"
fi

echo "Début de la compilation du site"

# Compiler et transférer le fichier contruit après la compilation vers /var/www/html/frontend
cd /projet/L-agence/packages/frontend
npm install >> $LOG_FILE 2>&1 
npm run build >> $LOG_FILE 2>&1 
cd

cp -r /projet/L-agence/packages/frontend/dist /var/www/html/frontend

systemctl restart apache2

# Configuration du fichier pour l'accès à la base de donné
touch /projet/L-agence/packages/backend/.env
printf '# Database\n' > /projet/L-agence/packages/backend/.env
printf 'DB_HOST=192.168.56.12\n' >> /projet/L-agence/packages/backend/.env
printf 'DB_PORT=3306\n' >> /projet/L-agence/packages/backend/.env
printf 'DB_USERNAME=admin\n' >> /projet/L-agence/packages/backend/.env
printf 'DB_PASSWORD=network\n' >> /projet/L-agence/packages/backend/.env
printf 'DB_DATABASE=lagence\n\n' >> /projet/L-agence/packages/backend/.env
printf 'MAILER_EMAIL=eseolagence@gmail.com\n' >> /projet/L-agence/packages/backend/.env
printf 'MAILER_PASSWORD="idkl nueb jgrt gpaq "\n' >> /projet/L-agence/packages/backend/.env

# Compiler le backend contruit après la compilation et le faire apparaître sur la fenêtre node_session
cd /projet/L-agence/packages/backend
npm install >> $LOG_FILE 2>&1 
screen -S node_session -d -m npm run start
cd

echo "Frontend et Backend prêt et compilé"

echo "END - install web Server"