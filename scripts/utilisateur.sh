#!/bin/bash

USERNAME="dev"  #  le nom d'utilisateur réel
PASSWORD="dev"  #  le mot de passe ici

# Créer un nouvel utilisateur
sudo useradd -m -s /bin/bash $USERNAME
# Définir le mot de passe sans interaction
echo -e "$PASSWORD\n$PASSWORD" | sudo passwd $USERNAME



# Créer le répertoire SSH et le fichier authorized_keys
sudo mkdir -p /home/$USERNAME/.ssh
sudo touch /home/$USERNAME/.ssh/authorized_keys



# Définir les permissions et la propriété
#sudo chmod -R 777 /home/$USERNAME/.ssh
#un droit de 777 est trop pour etre accepté c'est ce qui causait l'erreur
#aussi il commence par faire de la recursivite à  partir du dernier element du repertoire
#Donc dans notre cas .ssh pour descendre
sudo chmod -R 750 /home/$USERNAME/.ssh
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh


