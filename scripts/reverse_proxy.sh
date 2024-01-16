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
  apache2 \
  git \
  >> $LOG_FILE 2>&1

a2enmod proxy proxy_http ssl

cp /vagrant/sshproxy/000-default.conf /etc/apache2/sites-available/000-default.conf

git clone https://github.com/OpenVPN/easy-rsa.git /easy-rsa

systemctl restart apache2