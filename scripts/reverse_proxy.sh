#!/bin/bash

## install web server with php

IP=$(hostname -I | awk '{print $2}')

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/install_web.log"
DEBIAN_FRONTEND="noninteractive"

echo "START - install web Server - "$IP

echo "=> [1]: Installing required packages..."
apt-get update $APT_OPT \
  >> $LOG_FILE 2>&1

apt-get install $APT_OPT \
  wget \
  gnupg \
  unzip \
  curl \
  openssl \
  apache2 \
  git \
  >> $LOG_FILE 2>&1

a2enmod proxy proxy_http ssl

openssl genpkey -algorithm RSA -out lagence.pem -aes256 -pass pass:network

openssl req -new -key /etc/ssl/certs/lagence.pem -out /etc/ssl/certs/lagence.csr -passin pass:network -subj "/C=FR/ST=France/L=Angers/O=Organization/OU=Organizational Unit/CN=192.168.56.10"

openssl x509 -req -in /etc/ssl/certs/lagence.csr -signkey /etc/ssl/certs/lagence.pem -out /etc/ssl/certs/lagence.crt -passin pass:network 

cp /vagrant/sshproxy/000-default.conf /etc/apache2/sites-available/000-default.conf

sed -i 's/ssl-cert-snakeoil/lagence/g' /etc/apache2/sites-available/default-ssl.conf 
sed -i 's/private\/lagence.key/certs\/lagence.crt/g' /etc/apache2/sites-available/default-ssl.conf 

#git clone https://github.com/OpenVPN/easy-rsa.git /easy-rsa

systemctl restart apache2

ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -q -N ""

cp ~/.ssh/id_rsa.pub /vagrant/authorized_keys

#bastion

sed -i 's/#GatewayPorts no/GatewayPorts yes/g' /etc/ssh/sshd_config

touch ~/.ssh/config

printf 'Host bastion\n' > ~/.ssh/config
printf '\tHostName 192.168.56.14\n' >> ~/.ssh/config
printf '\tUser root\n' >> ~/.ssh/config
printf '\tIdentityFile ~/.ssh/id_rsa\n\n' >> ~/.ssh/config

printf 'Host server-web\n' >> ~/.ssh/config
printf '\tHostName 192.168.56.10\n' >> ~/.ssh/config
printf '\tUser root\n' >> ~/.ssh/config
printf '\tIdentityFile ~/.ssh/id_rsa\n' >> ~/.ssh/config
printf '\tProxyJump bastion\n\n' >> ~/.ssh/config

printf 'Host database-server\n' >> ~/.ssh/config
printf '\tHostName 192.168.56.12\n' >> ~/.ssh/config
printf '\tUser root\n' >> ~/.ssh/config
printf '\tIdentityFile ~/.ssh/id_rsa\n' >> ~/.ssh/config
printf '\tProxyJump bastion\n' >> ~/.ssh/config

service ssh restart