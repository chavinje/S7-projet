#!/bin/bash

USERNAME="dev"  #  le nom d'utilisateur réel
PASSWORD="dev"  #  le mot de passe ici

sudo apt-get install rsync -y
# Créer un nouvel utilisateur
sudo useradd -m -s /bin/bash $USERNAME
# Définir le mot de passe sans interaction
echo -e "$PASSWORD\n$PASSWORD" | sudo passwd $USERNAME



# Créer le répertoire SSH et le fichier authorized_keys
sudo mkdir -p /home/$USERNAME/.ssh
sudo touch /home/$USERNAME/.ssh/authorized_keys

#Copie de la clé publique vers le reperoitre authorized_eys
cat /vagrant/Bastion_Keys/id_rsa.pub | sudo sh -c 'cat >> /home/dev/.ssh/authorized_keys'

# Définir les permissions et la propriété
sudo chmod -R 750 /home/$USERNAME/.ssh

#un droit de 777 est trop pour etre accepté c'est ce qui causait l'erreur
#aussi il commence par faire de la recursivite à  partir du dernier element du repertoire
#Donc dans notre cas .ssh pour descendre
    #sudo chmod -R 777 /home/$USERNAME/.ssh

sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh


