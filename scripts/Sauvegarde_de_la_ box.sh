#!/bin/bash
IP=$(hostname -I | awk '{print $2}')
APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/MysqlDump.log"
DEBIAN_FRONTEND="noninteractive"

# Chemin vers le script à éditer pour la sauvegarde
BACKUP_DIR="/vagrant/vagrantBox/Box"
BOX="gestionLocative"

echo "START - Sauvegarde en cas de crache - " $IP

# Vérifier la préssence du repertoire $BACKUP_DIR
if [ ! -d "$BACKUP_DIR" ]; then
  mkdir -p "$BACKUP_DIR"
fi

# Nom du fichier de sauvegarde (avec date)
DATE=$(date "+%%d-%%m-%%Y_a_%%H:%%M:%%S")

# Vérifier la préssence du repertoire $BACKUP_DIR/$DATE
if [ ! -d "$BACKUP_DIR/$DATE" ]; then
  mkdir -p "$BACKUP_DIR/$DATE"
fi

cd /projetInfra/S7-projet-il

# Arrêt de la machine virtuelle si elle est en cours d'exécution
vagrant halt database-server

# Création de la nouvelle box à partir de la VM existante
vagrant package --output "$BACKUP_DIR/$DATE/$BOX.box" --base database-server

# Redémarrage de la machine virtuelle
vagrant up database-server

cd

echo "END - Sauvegarde de la base de donnée dans le fichier"$BACKUP_DIR
