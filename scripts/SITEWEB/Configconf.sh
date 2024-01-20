#!/bin/bash

# Cloner le depot git
IP=$(hostname -I | awk '{print $2}')

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/GitClone.log"
DEBIAN_FRONTEND="noninteractive" 

#Repertoire ou se trouve mon fichier sql
REPERTOIRE="/var/www/html"

#chemin du 000-default.conf
chemin_conf="/etc/apache2/sites-available/000-default.conf"

#chemin de la racine
chemin_racine="DocumentRoot /var/www/html"

#nouveau chemin de la racine 
chemin_racinenew="DocumentRoot /var/www/html/projetinfralog-site-master/"

echo "START - Configuration 000-default.conf..."
# Recherche de la chaine à remplacer 

if grep -q "$chemin_racinenew" "$chemin_conf"; then
    # Chaine trouvée 
    echo "=> Le chemin d'accès au site existe déjà."
else
    # Chaine non trouvée
    sed -i "s|$chemin_racine|$chemin_racinenew|g" "$chemin_conf"
    echo "=> Modification du repertoire racine effectuée."
fi
echo "END - Modification de la configuration du site 000-default.conf"

service apache2 reload