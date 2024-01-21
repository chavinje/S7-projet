#!/bin/bash

# Cloner le depot git
IP=$(hostname -I | awk '{print $2}')

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/GitClone.log"
DEBIAN_FRONTEND="noninteractive" 

echo "START - Configuration 000-default.conf..."
# Recherche de la chaine à remplacer 

if grep -q "DocumentRoot /var/www/html/site" "/etc/apache2/sites-available/000-default.conf"; then
    # Chaine trouvée 
    echo "=> Le chemin d'accès au site existe déjà."
else
    # Chaine non trouvée
    sed -i "s|DocumentRoot /var/www/html|DocumentRoot /var/www/html/site|g" /etc/apache2/sites-available/000-default.conf
    echo "=> Modification du repertoire racine effectuée."
fi
echo "END - Modification de la configuration du site 000-default.conf"
sudo systemctl reload apache2