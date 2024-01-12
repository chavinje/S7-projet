#!/bin/bash

chemin_backup='/vagrant/BackupBDD/moodle.sql'
BDD_User="moodle_user";
BDD_MDP="network";
BDD_Name="moodle";
IP="192.168.56.81";

#Restauration bdd si bdd existe
if [ -f $chemin_backup ]; then
    sudo mysql -u $BDD_User -p$BDD_MDP -h $IP -e "CREATE DATABASE IF NOT EXISTS $BDD_Name;"
    sudo mysql -u $BDD_User -p$BDD_MDP moodle < $chemin_backup
fi