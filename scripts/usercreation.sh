#!/bin/bash

# Définition du nom de l'utilisateur et du mot de passe
USERNAME="dev"
PASSWORD="dev"  # Remplacez 'dev' par le mot de passe souhaité

# Adresse IP ou nom d'hôte de la VM source
VM_SOURCE="192.168.56.82"

# Création de l'utilisateur avec des privilèges sudo
sudo adduser --disabled-password --gecos "" $USERNAME
echo "$USERNAME:$PASSWORD" | sudo chpasswd
sudo usermod -aG sudo $USERNAME

# Création du répertoire .ssh et du fichier authorized_keys
sudo mkdir -p /home/$USERNAME/.ssh
sudo touch /home/$USERNAME/.ssh/authorized_keys

# Récupération de la clé publique depuis la VM source
ssh vagrant@$VM_SOURCE "cat /home/vagrant/.ssh/authorized_keys" > /tmp/pub_key.txt

# Ajout de la clé publique au fichier authorized_keys du nouvel utilisateur
sudo cat /tmp/pub_key.txt >> /home/$USERNAME/.ssh/authorized_keys
rm /tmp/pub_key.txt

# Modification des permissions du fichier authorized_keys
sudo chmod 777 /home/$USERNAME/.ssh/
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh/
