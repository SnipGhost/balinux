#!/bin/bash

apt install -y sysstat lynx apache2 libapache2-mod-php
systemctl stop apache2
cp -f nginx-default.conf /etc/nginx/sites-enabled/default
apt install -y nginx
cp -f apache-ports.conf /etc/apache2/ports.conf
cp -f apache-default.conf /etc/apache2/sites-enabled/000-default.conf
cp -f index.html /var/www/html/index.html
cp -f index.php /var/www/html/index.php
systemctl start apache2
systemctl restart nginx
netstat -nlpt
