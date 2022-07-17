#!/bin/bash
date=`date '+%Y%m%d'`
exec 1>> /$HOME/result_lamp_$date.log

sudo mkdir -p /var/www/site.com/{site,log}
sudo apt install apache2 apache2-utils
sudo curl http://localhost
# установка MariaDB
sudo apt install mariadb-server mariadb-client

# установка РНР
sudo apt install php7.4 php7.4-mysql libapache2-mod-php7.4 php7.4-cli php7.4-cgi php7.4-gd

# создать и  скопировать  файл проверки  РНР
sudo cp /home/prkpo/script/index.php /var/www/site.com/site/
sudo cp /home/prkpo/script/site.conf /etc/apache2/sites-available/
# проверка localhost/index.php отдельно в браузере
sudo curl http://localhost/index.php


sudo a2ensite /etc/apache/sites-available/*
sudo a2enmod rewrite
sudo systemctl restart apache2
# установка WordPress
wget -c http://wordpress.org/latest.tar.gz
sudo tar -xzvf latest.tar.gz
sudo mv ./wordpress/ /var/www/site.com/site/
sudo chown www-data:www-data -R /var/www/site.com/site/
sudo chmod -R 775 /var/www/site.com/site/

sudo systemctl restart apache2
# выполнить mysql_secure_installation
# выполнить  настройку ДБ с созданием  УЗ и прав
# mysql -u root -p
# замена на иной  и удаление 000-default.conf??
# !!! для развития --- 
# sudo apt install uwf
# uwf allow 80/tcp
# ufw allow 443/tcp
# sudo systemctl start uwf
# установка LetsEncrypt
# выполнить mysql_secure_installation
# выполнить  настройку ДБ с созданием  УЗ и прав
# mysql -u root -p
# замена на иной  и удаление 000-default.conf??
sudo curl http://localhost:81
# !!! для развития --- 
# sudo apt install uwf
# uwf allow 80/tcp
# ufw allow 443/tcp
# sudo systemctl start uwf
# установка LetsEncrypt
sudo apt install certbot python3-certbot-apache
sudo systemctl reload apache2
# создание  файла well-known.conf
sudo mkdir -p /var/lib/letsencrypt/.well-known
sudo chgrp www-data /var/lib/letsencrypt
sudo chmod g+s /var/lib/letsencrypt
#create a well-known.conf file for Let’s Encrypt to validate your domain
sudo mkdir -p /var/lib/letsencrypt/.well-known
sudo chgrp www-data /var/lib/letsencrypt
sudo chmod g+s /var/lib/letsencrypt
sudo cp /home/prkpo/script/well-known.conf /var/lib/letsencrypt
sudo a2enmod ssl
sudo a2enmod headers
sudo a2enmod http2
sudo a2enconf well-known
sudo systemctl restart apache2
# конфигурирование LetsEncrypt for Apache
sudo certbot --apache -d site.com
# ввести  почту, выбрать  домен
# autoupdate Letsencrypt
sudo crontab -e
#sudo 52 10 * * * root /usr/bin/certbot renew >/dev/null 2>&1
sudo ufw status
sudo ufw allow 'Apache Full' # http/https
sudo ufw delete allow 'Apache'
sudo ufw status

