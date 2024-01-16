#!/bin/bash

# Variables
REPO_URL="https://gitlab.com/MateoESEO/projetinfralog-site.git"
WEB_DIR="/var/www/html"

sudo touch /var/www/html/
# Installer Git
# sudo apt-get update
sudo apt-get install -y git

# Cloner le dépôt (ou tirer si déjà cloné)
if [ ! -d "$WEB_DIR/site" ]; then
    sudo  git clone "$REPO_URL"  "$WEB_DIR/site"
else
    cd "$WEB_DIR/site"
    sudo git pull
fi
