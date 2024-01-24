#!/bin/bash

## install web server with php

IP=$(hostname -I | awk '{print $2}')

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/certificate_ssl.log"
DEBIAN_FRONTEND="noninteractive"


echo "START - Self signed SSL Certificate - "$IP
a2enmod ssl  >> $LOG_FILE 2>&1
mkdir /etc/ssl/mesCertificat


# Création et déverrouillage de la clé SSL lagence.key
openssl genrsa -des3 -out /etc/ssl/mesCertificat/lagence.key -passout pass:network 2048 >> $LOG_FILE 2>&1
mv /etc/ssl/mesCertificat/lagence.key /etc/ssl/mesCertificat/lagence-pass.key >> $LOG_FILE 2>&1
openssl rsa -in /etc/ssl/mesCertificat/lagence-pass.key \
  -out /etc/ssl/mesCertificat/lagence.key -passin pass:network >> $LOG_FILE 2>&1


# Création du certificat lagence.csr
openssl req -key /etc/ssl/mesCertificat/lagence.key -new -out /etc/ssl/mesCertificat/lagence.csr \
  -subj "/C=FR/ST=France/L=Angers/O=Organization/OU=Organizational Unit/CN=192.168.56.14" >> $LOG_FILE 2>&1


# Signature de la clé par le certificat pour obtenir lagence.crt
openssl x509 -signkey /etc/ssl/mesCertificat/lagence.key -in /etc/ssl/mesCertificat/lagence.csr \
  -req -days 365 -out /etc/ssl/certs/lagence.crt >> $LOG_FILE 2>&1


# Création de la clé et du certificat auto-signés pour l'autorité de certification (CA)
openssl req -x509 -sha256 -days 365 -newkey rsa:2048 -keyout /etc/ssl/mesCertificat/rootCA-pass.key \
  -out /etc/ssl/mesCertificat/rootCA.crt -passout pass:network \
  -subj "/C=FR/ST=France/L=Angers/O=Organization/OU=Organizational Unit/CN=192.168.56.14" >> $LOG_FILE 2>&1
openssl rsa -in /etc/ssl/mesCertificat/rootCA-pass.key \
  -out /etc/ssl/mesCertificat/rootCA.key -passin pass:network >> $LOG_FILE 2>&1


# Configuration des extensions pour le certificat SSL lagence.crt
touch /etc/ssl/mesCertificat/lagence.ext
cat <<EOF > /etc/ssl/mesCertificat/lagence.ext
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
subjectAltName = @alt_names
[alt_names]
DNS.1 = 192.168.56.14
EOF

# Signature du certificat SSL par l'autorité de certification (CA)
openssl x509 -req -CA /etc/ssl/mesCertificat/rootCA.crt -CAkey /etc/ssl/mesCertificat/rootCA.key \
  -in /etc/ssl/mesCertificat/lagence.csr -out /etc/ssl/mesCertificat/lagence.crt -days 365 \
  -CAcreateserial -extfile /etc/ssl/mesCertificat/lagence.ext >> $LOG_FILE 2>&1


# Affichage des détails du certificat SSL généré
openssl x509 -text -noout -in /etc/ssl/mesCertificat/lagence.crt >> $LOG_FILE 2>&1
echo "Certificat SSl auto-signé prêt"


# création du myadmin.conf pour effectuer un reverse proxy vers le port 228
# Ce fichier servira pour l'utilisation des https
touch /etc/apache2/sites-available/frontend_ssl.conf
cat <<EOF > /etc/apache2/sites-available/frontend_ssl.conf
<IfModule mod_ssl.c>
    <VirtualHost _default_:443>
        ServerName groupe6.com
        ServerAlias www.groupe6.com
        
        ProxyPass / http://192.168.56.10:223/
        ProxyPassReverse / http://192.168.56.10:223/
        ProxyRequests Off
        
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        
        SSLEngine on
        SSLCertificateFile      /etc/ssl/mesCertificat/lagence.crt
        SSLCertificateKeyFile  /etc/ssl/mesCertificat/lagence.key
        
        <FilesMatch "\.(cgi|shtml|phtml|php)$">
            SSLOptions +StdEnvVars
        </FilesMatch>
        
        <Directory /usr/lib/cgi-bin>
            SSLOptions +StdEnvVars
        </Directory>
    </VirtualHost>
</IfModule>
EOF


# Activation du frontend_ssl.conf
a2ensite frontend_ssl.conf >> $LOG_FILE 2>&1
systemctl restart apache2

echo "Serveur en Place"

# Création des clé ssh
mkdir ~/.ssh
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -q -N "" >> $LOG_FILE 2>&1


# Copie des clé ssh vers les autres serveur
sshpass -p "vagrant" ssh-copy-id -i /root/.ssh/id_rsa.pub vagrant@192.168.56.10  >> $LOG_FILE 2>&1
sshpass -p "vagrant" ssh-copy-id -i /root/.ssh/id_rsa.pub vagrant@192.168.56.12  >> $LOG_FILE 2>&1

