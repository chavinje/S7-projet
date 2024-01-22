#!/bin/bash

##

IP=$(hostname -I | awk '{print $2}')

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/install_web.log"
DEBIAN_FRONTEND="noninteractive"

key_name="basketsite11.com.key"
cert_sign_request="basketsite11.com.csr"
certificate_name="basketsite11.crt"

echo "DEBUT CONFIGURATION OpenSSL"
echo "=> [1]: Installing required packages ..."

apt-get install $APT_OPT \
    apache2 \
    git \
    openssl \
    dos2unix \
      >>$LOG_FILE 2>&1
echo "=> [2]: Enabling packages"
sudo a2enmod proxy proxy_http
sudo a2dissite 000-default.conf

sudo systemctl reload apache2

#Creer un nouveau fichier de configuration pour le ssl
sudo touch /etc/apache2/sites-available/ssl_config.conf

sudo  sh -c 'echo "

<VirtualHost *:443>

ServerName basketsite11.com

        ProxyPass  / http://192.168.56.80/
        ProxyPassReverse / http://192.168.56.80/
        ProxyRequests Off

        SSLEngine on
        SSLCertificateFile /vagrant/cle_certificat/basketsite11.com.crt
        SSLCertificateKeyFile /vagrant/cle_certificat/basketsite11.com.key

</VirtualHost>
" > /etc/apache2/sites-available/ssl_config.conf'

#Activer ssl_config.conf pour l'activation https
 sudo a2ensite ssl_config.conf
 sudo systemctl restart apache2

echo "END - Configuration openSSL"