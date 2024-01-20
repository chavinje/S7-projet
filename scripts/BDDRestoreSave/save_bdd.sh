#!/bin/bash

chemin_backup='/vagrant/BackupBDD/moodle.sql'
BDD_User="moodle_user";
BDD_MDP="network";
BDD_Name="moodle";

if [ -f $chemin_backup ]; then
    #Sauvegarde backup bdd
    sudo mysqldump -u $BDD_User -p$BDD_MDP --databases $BDD_Name > $chemin_backup
fi