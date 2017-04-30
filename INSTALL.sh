#!/bin/bash

RED='\033[0;31m'
NCC='\033[0m'

BASEDIR=`dirname $0`
PROJECT_PATH=`cd $BASEDIR; pwd`
echo "${RED}Using path: ${PROJECT_PATH} ${NCC}"

apt install -y sysstat lynx apache2 libapache2-mod-php
systemctl stop apache2
apt install -y nginx

echo "${RED}Starting to copy configuration files${NCC}"
cp -f $PROJECT_PATH/nginx-default.conf /etc/nginx/sites-enabled/default
cp -f $PROJECT_PATH/apache-ports.conf /etc/apache2/ports.conf
cp -f $PROJECT_PATH/apache-default.conf /etc/apache2/sites-enabled/000-default.$
cp -f $PROJECT_PATH/index.html /var/www/html/index.html
cp -f $PROJECT_PATH/index.php /var/www/html/index.php

echo "${RED}Restarting servers ... ${NCC}"
systemctl start apache2
systemctl restart nginx

echo "${RED} END ${NCC}"
netstat -nlpt
