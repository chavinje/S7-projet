# Projet Infrastructure - README

## Contexte
Une partie du projet nécessite une infrastructure pour héberger l'application web développée par l'équipe de développement. L'objectif est d'assurer la cohérence de l'infrastructure pour tous les membres de l'équipe, en mettant en œuvre le principe d'Infrastructure As Code (IAC) avec Vagrant de HashiCorp.

## Périmètre
Ce document décrit les attentes liées à la mise en place de l'infrastructure, intégrant des exigences fonctionnelles et techniques. Les éléments techniques disponibles comprennent des fichiers basés sur Vagrant pour créer une machine virtuelle VirtualBox avec apache2, php, nodeJs, et MariaDB pour héberger PhpMyadmin.

### Contraintes techniques :
- Distributions Linux Debian
- IAC basé sur Vagrant et des scripts shell
- Limite de ressources par machine virtuelle : 1vCPU, 1Go de RAM, 8Go d'espace disque
- Tous les services accessibles via une IP unique

## Étapes du projet (partie Infrastructure)
### Étape 1 :
Mise en place des outils (VirtualBox, Vagrant) : Assurer le bon fonctionnement de la solution pour l'équipe de développement, avec possibilité d'adaptation/amélioration.

### Étape 2 :
Adaptation de l'infrastructure pour héberger la base de données sur un autre serveur virtuel dans un réseau privé hôte, en prenant en compte les besoins pour l'application JAVA.

### Étape 3 :
Mise en place d'une solution de sauvegarde des données à partir d'une machine d'un membre de l'équipe pour garantir la pérennité des données. Grâce à mysqldump les donnée son récupérer et envoyée vers le fichier /bdd/

### Étape 4 :
Ajout d'un serveur avec un mode reverse proxy (mod_proxy) pour répartir la charge entre plusieurs nœuds http. Ce serveur prendra en charge le protocole SSL avec un certificat auto-signé (openSSL).

## Lancement
La commande "vagrant up" sera effectuée, et l'infrastructure résultante sera déployée.

## Testez notre Application :
# *Depuis le server :
192.168.56.10:223 pour le frontend
192.168.56.10:228 pour phpmyadmin
192.168.56.10:3000 pour le backend

# *Ceux qui est recommendée :

Pour linux
sudo nano /etc/hosts
Ajouter à la dernière ligne l'IP publique puis tabulation puis lagence.fr. Et un Ctrl X et Y.


Pour windows
Allez dans ce répertoire "C:\Windows\System32\drivers\etc", modifier hosts avec Vs code. Ajouter à la dernière ligne l'IP publique puis tabulation puis lagence.fr. Faite le comme dans l'exemple en dessous. Sauvegardez-le en le donnant les droits pour. Pour toute question contactez-moi.

Exemple de l'ajout à faire sur windows ou sur linux :
192.168.127.12  lagence.fr

https ou http://lagence.fr/ pour le frontend
http://lagence.fr:3000/ pour le backend
http://lagence.fr:228/ pour phpmyadmin