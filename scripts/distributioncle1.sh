#!/bin/bash


#  adresses des VMs et le nom d'utilisateur
VM1_ADDRESS="192.168.56.80"
VM2_ADDRESS="192.168.56.81"
USERNAME="vagrant"  # Le nom d'utilisateur déjà présent sur les VMs
USERNAMEVM="dev" 
PASSWORD="vagrant"

# Options SSH pour éviter la vérification de la clé de l'hôte
SSH_OPTIONS="-o StrictHostKeyChecking=no"

echo "START - Distribution cle dans les autres VMS pour Bastion - "

sudo apt-get install rsync -y
sudo apt-get install sshpass -y

# Générer la paire de clés SSH
#ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N "" -y
ssh-keygen -t rsa -b 4096 -f /home/vagrant/.ssh/id_rsa -N ""




# Copie de la clé publique sur chaque VM dans le fichier authorized_keys
#sshpass -p "$PASSWORD" ssh-copy-id -i /home/vagrant/.ssh/id_rsa.pub dev@$VM1_ADDRESS
echo -e $PASSWORD | sudo rsync -avz /home/vagrant/.ssh/id_rsa.pub vagrant@$VM1_ADDRESS:/home/dev/.ssh/
cat /home/vagrant/.ssh/id_rsa.pub | sshpass -p $PASSWORD ssh vagrant@$VM1_ADDRESS 'cat >> /home/dev/.ssh/authorized_keys'


 
# Copie de la clé publique sur chaque VM dans le fichier authorized_keys
#sshpass -p "$PASSWORD" ssh-copy-id -i /home/vagrant/.ssh/id_rsa.pub dev@$VM2_ADDRESS
echo -e $PASSWORD  | sudo rsync -avz /home/vagrant/.ssh/id_rsa.pub vagrant@$VM2_ADDRESS:/home/dev/.ssh/
cat /home/vagrant/.ssh/id_rsa.pub | sshpass -p $PASSWORD ssh vagrant@$VM2_ADDRESS 'cat >> /home/dev/.ssh/authorized_keys'

echo "END - Distribution cle dans les autres VMS pour Bastion:)"

#scp /home/vagrant/.ssh/id_rsa.pub vagrant@192.168.56.81:/home/vagrant/.ssh/

