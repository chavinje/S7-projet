#!/bin/bash

## Variables personnalisables
CERT_PASSWORD=":)" # Remplacez par votre mot de passe pour les clés
CERT_COUNTRY="FR"
CERT_STATE="FRANCE"
CERT_LOCALITY="Angers"
CERT_ORGANIZATION="ESEO"
CERT_COMMON_NAME="Giovanni"
CERT_DNS="192.168.56.80" # Remplacez par l'adresse DNS ou IP de votre serveur

## Autres variables du script
IP=$(hostname -I | awk '{print $2}')
LOG_FILE="/vagrant/logs/install_git.log"

echo "START - Installation du certificat SSL - $IP"
echo "=> [1] - Création d'un dossier qui contiendra toutes les clés"
sudo mkdir /etc/apache2/ssl
cd /etc/apache2/ssl || exit

echo "=> [2] - Génération d'une clé SSL"
sudo openssl genrsa -des3 -passout pass:$CERT_PASSWORD -out domain.key 2048

echo "=> [3] - Création d'un CSR (Certificate Signing Request) avec la clé"
sudo openssl req -key domain.key -new -out domain.csr -passin pass:$CERT_PASSWORD -subj "/C=$CERT_COUNTRY/ST=$CERT_STATE/L=$CERT_LOCALITY/O=$CERT_ORGANIZATION/CN=$CERT_COMMON_NAME"

echo "=> [4] - Création d'un certificat auto-signé avec la clé et le CSR"
sudo openssl x509 -signkey domain.key -in domain.csr -req -days 365 -out domain.crt -passin pass:$CERT_PASSWORD 

echo "=> [5] - Activation du SSL"
sudo openssl req -x509 -sha256 -days 1825 -newkey rsa:2048 -keyout rootCA.key -out rootCA.crt -passin pass:$CERT_PASSWORD -subj "/C=$CERT_COUNTRY/ST=$CERT_STATE/L=$CERT_LOCALITY/O=$CERT_ORGANIZATION/CN=$CERT_COMMON_NAME"

echo "=> [6] - Création d'un fichier domain.ext"
echo "authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
subjectAltName = @alt_names
[alt_names]
DNS.1 = $CERT_DNS" | sudo tee /etc/apache2/ssl/domain.ext > /dev/null

echo "=> [7] - Création d'un certificat SSL avec le CSR, la clé et le fichier domain.ext"
sudo openssl x509 -req -CA rootCA.crt -CAkey rootCA.key -in domain.csr -out domain.crt -days 365 -CAcreateserial -extfile domain.ext -passin pass:$CERT_PASSWORD

echo "END - Installation du certificat SSL - $IP"
#DNS.1 = $CERT_DNS" > domain.ext