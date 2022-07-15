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


