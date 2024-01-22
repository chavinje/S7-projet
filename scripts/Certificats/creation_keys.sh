#!/bin/bash

##

IP=$(hostname -I | awk '{print $2}')

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/install_web.log"
DEBIAN_FRONTEND="noninteractive"

key_name="basketsite11.com.key"
cert_sign_request="basketsite11.com.csr"
certificate_name="basketsite11.com.crt"

repertoire_cle="/vagrant/cle_certificat"

echo "Generation de certificat SSL"

sudo a2enmod ssl

#Verifier que le openSSL est bien installe
#dpkg -l | grep openssl

#Creation d'un nouveau repertoire pour generer et stocker la cle SSL et le certificat SSL
mkdir /vagrant/cle_certificat

#Verification de l'existence du repertoire dans lequel seront la cle ssl et le certificat ssl
if [ -d "$repertoire_cle/cle_certificat" ]; then
    rm -rf "$repertoire_cle"
fi



#Generer une cle ssl
cd /vagrant/cle_certificat
sudo openssl genrsa -des3 -out $key_name -passout pass:network

#Deverouiller la cle pour ne pas mettre le mot de passe à chaque fois
sudo openssl rsa -in $key_name -out $key_name --passin pass:network

#Generer une requête de signature de certificat
sudo openssl req -new -key $key_name -out $cert_sign_request -subj "/C=FR/ST=France/L=Angers/O=ESEO/OU=ESEO/CN=basketsite11.com"

#Verification du fichier CSR avant de continuer
if [ -f "$cert_sign_request" ]; then
    echo "CSR file exists: $cert_sign_request"
else
    echo "Error: CSR file not found."
    exit 1
fi       

#generer le certificat ssl
sudo openssl x509 -req -days 365 -in $cert_sign_request -signkey $key_name -out $certificate_name

sudo systemctl restart apache2

echo "END - Generation de certificat ssl"