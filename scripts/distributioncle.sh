#!/bin/bash


# Générer la paire de clés SSH
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""

sudo apt-get install sshpass


#  adresses des VMs et le nom d'utilisateur
VM1_ADDRESS="192.168.56.80"
VM2_ADDRESS="192.168.56.81"
USERNAME="vagrant"  # Le nom d'utilisateur déjà présent sur les VMs
USERNAMEVM="dev" #
PASSWORD="vagrant"


# Options SSH pour éviter la vérification de la clé de l'hôte
SSH_OPTIONS="-o StrictHostKeyChecking=no"

# Copie de la clé publique sur chaque VM dans le fichier authorized_keys
sshpass -p "$PASSWORD" sudo scp $SSH_OPTIONS ~/.ssh/id_rsa.pub $USERNAME@$VM1_ADDRESS:/home/$USERNAMEVM/.ssh/authorized_keys
#sudo apt-get update
sshpass -p "$PASSWORD" sudo scp $SSH_OPTIONS ~/.ssh/id_rsa.pub $USERNAME@$VM2_ADDRESS:/home/$USERNAMEVM/.ssh/authorized_keys
