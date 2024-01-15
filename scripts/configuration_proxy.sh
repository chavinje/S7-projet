echo "=> [1]: Install required packages ..."
DEBIAN_FRONTEND=noninteractive
LOG_FILE="/vagrant/logs/installApache2.log"
apt-get install -o Dpkg::Progress-Fancy="0" -q -y \
        apt-get update \
        apt install apache2 \
        >> $LOG_FILE 2>&1
echo "[2] Active les modules utiles necessaires pour le reverse_proxy à Apache2..."
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2dissite 000-default.conf

#rediriger les requetes provenant de www.basketsitegio.com sur srv-proxy vers 192.168.56.80 srv-web
sudo sed -i '/debian/ a\192.168.56.80   www.basketsite11.com' /etc/hosts

#configuration reverse proxy sur notre serveur
sudo touch /etc/apache2/sites-available/reverseproxy.conf
sudo sh -c 'echo "<VirtualHost *:80>
        

        ServerName www.basketsite.com

        ProxyPreserveHost on
        ProxyPass                /     http://192.168.56.80/
        ProxyPassReverse         /     http://192.168.56.80/
	</VirtualHost>" > /etc/apache2/sites-available/reverseproxy.conf'
	
#activer 
sudo a2ensite reverseproxy.conf
sudo systemctl reload apache2



