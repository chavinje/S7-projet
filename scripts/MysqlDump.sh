#!/bin/bash
IP=$(hostname -I | awk '{print $2}')
APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/MysqlDump.log"
DEBIAN_FRONTEND="noninteractive"

# Utilisateur et nom de la base de donnée
DB_NAME="lagence"
DB_USER="admin"
DB_PASSWD="network"

# Chemin vers le script à éditer pour la sauvegarde
BACKUP_SCRIPT="/data/backup_script.sh"
BACKUP_DIR="/data/MysqlDump"

echo "START - Sauvegarde en cas de crache - " $IP

echo "=> [1]: Installing required packages..."
apt-get update $APT_OPT \
  >> $LOG_FILE 2>&1

mkdir /data
mkdir $BACKUP_DIR
touch $BACKUP_SCRIPT

echo "=> [2]: Fichier $BACKUP_SCRIPT pour le backup..."

# Utilisation de printf pour écrire dans un fichier bash
printf '#!/bin/bash\n\n' > $BACKUP_SCRIPT

printf '# Répertoire de sauvegarde\n' > $BACKUP_SCRIPT
printf 'BACKUP_DIR="/data/MysqlDump"\n\n' >> $BACKUP_SCRIPT

printf '# Utilisateur et nom de la base de donnée\n' >> $BACKUP_SCRIPT
printf 'DB_NAME="lagence"\n\n' >> $BACKUP_SCRIPT
printf 'DB_USER="admin"\n' >> $BACKUP_SCRIPT
printf 'DB_PASSWD="network"\n\n' >> $BACKUP_SCRIPT

printf '# Vérifier la préssence du repertoire $BACKUP_DIR\n' >> $BACKUP_SCRIPT
printf 'if [ ! -d "$BACKUP_DIR" ]; then\n' >> $BACKUP_SCRIPT
printf '\tmkdir -p "$BACKUP_DIR"\n' >> $BACKUP_SCRIPT
printf 'fi\n\n' >> $BACKUP_SCRIPT

printf '# Nom du fichier de sauvegarde (avec date)\n' >> $BACKUP_SCRIPT
printf 'DATE=$(date "+%%d-%%m-%%Y_a_%%H:%%M:%%S")\n\n' >> $BACKUP_SCRIPT

printf '# Vérifier la préssence du repertoire $BACKUP_DIR/$DATE\n' >> $BACKUP_SCRIPT
printf 'if [ ! -d "$BACKUP_DIR/$DATE" ]; then\n' >> $BACKUP_SCRIPT
printf '\tmkdir -p "$BACKUP_DIR/$DATE"\n' >> $BACKUP_SCRIPT
printf 'fi\n' >> $BACKUP_SCRIPT

#printf 'DATABASE=$(mysql -e "show databases;" | awk \'{if(NR>1) print})\'\n\n' >> $BACKUP_SCRIPT
printf '# Commande mysqldump pour sauvegarder la base de données\n' >> $BACKUP_SCRIPT
printf 'mysqldump -u $DB_USER -p$DB_PASSWD $DB_NAME > $BACKUP_DIR/$DATE/$DB_NAME.sql\n' >> $BACKUP_SCRIPT

printf '# Vérifier si la sauvegarde a été réalisée avec succès\n' >> $BACKUP_SCRIPT
printf 'if [ $? -eq 0 ]; then\n' >> $BACKUP_SCRIPT
printf '\techo "Sauvegarde de la base de données $DB_NAME effectuée avec succès dans $BACKUP_DIR"\n' >> $BACKUP_SCRIPT
printf '\tcp -r $BACKUP_DIR/$DATE /vagrant/bdd/\n' >> $BACKUP_SCRIPT
printf 'else\n' >> $BACKUP_SCRIPT
printf '\techo "Il y a eu une erreur lors de la sauvegarde de la base de données $DB_NAME"\n' >> $BACKUP_SCRIPT
printf 'fi\n' >> $BACKUP_SCRIPT

# Éditer temporairement le crontab
TEMP_CRON=$(mktemp)
crontab -l > $TEMP_CRON

# Ajouter la tâche au crontab (ici, une exécution quotidienne à minuit)
echo "0 0 * * * bash $BACKUP_SCRIPT" >> $TEMP_CRON
#echo "0 0 * * * cp - a $BACKUP_DIR/$DATE /vagrant/bdd" >> $TEMP_CRON

# Installer le nouveau crontab
crontab $TEMP_CRON

# Suppression de la varialble temporaire
rm $TEMP_CRON

echo "END - Sauvegarde de la base de donnée dans le fichier"$BACKUP_DIR
