#!/bin/bash

USERNAME="sysinfo"

RED='\033[0;31m'
GRE='\033[0;32m'
NCC='\033[0m'

# Check the script is being run by root
if [ "$(id -u)" != "0" ]; then
   echo "${RED}This script must be run as root!${NCC}"
   exit 1
fi

BASEDIR=`dirname $0`
PROJECT_PATH=`cd $BASEDIR; pwd`
echo -e "${RED}Using path: ${PROJECT_PATH} ${NCC}"

echo -e "${GRE}Creating user sysinfo ...${NCC}"
useradd -m -c "User for web-sysinfo" $USERNAME
passwd -d $USERNAME
# TODO: Locate tcpdump!
printf "\n# User for web-sysinfo [!]\n${USERNAME} ALL=NOPASSWD: /usr/sbin/tcpdump\n" >> /etc/sudoers
if [ $? != "0" ]; then
	echo -e "$(GRE)Please login as root:$(NCC)"
	su -
	sig=$?
	printf "\n# User for web-sysinfo [!]\n${USERNAME} ALL=NOPASSWD: /usr/sbin/tcpdump\n" >> /etc/sudoers
	if [ $sig == "0" ]; then
		exit
	fi
fi

apt install -y sysstat elinks apache2 libapache2-mod-php
systemctl stop apache2
apt install -y nginx

echo -e "${GRE}Starting to copy configuration files${NCC}"
cp -f $PROJECT_PATH/nginx-default.conf /etc/nginx/sites-enabled/default
cp -f $PROJECT_PATH/apache-ports.conf /etc/apache2/ports.conf
cp -f $PROJECT_PATH/apache-default.conf /etc/apache2/sites-enabled/000-default.$
cp -f $PROJECT_PATH/index.html /var/www/html/index.html
cp -f $PROJECT_PATH/index.php /var/www/html/index.php
cp -f $PROJECT_PATH/phpinfo.php /var/www/html/phpinfo.php
mkdir /var/www/html/sysinfo
cp -f $PROJECT_PATH/sysinfo.php /var/www/html/sysinfo/index.php

echo -e "${GRE}Restarting servers ... ${NCC}"
systemctl start apache2
systemctl restart nginx

echo -e "${GRE}END OF SCRIPT${NCC}\n"
netstat -nlpt

echo -e "\nTest pages: "
echo -e "Static  page: ${GRE}http://127.0.0.1:80/index.html${NCC}"
echo -e "Dynamic page: ${GRE}http://127.0.0.1:80/index.php${NCC}"
echo -e "PHPInfo page: ${GRE}http://127.0.0.1:80/phpinfo.php${NCC}"
echo -e "\n404 test pages: "
echo -e "Static  page: ${GRE}http://127.0.0.1:80/index.txt${NCC}"
echo -e "Dynamic page: ${GRE}http://127.0.0.1:80/index.cgi${NCC}"
echo -e "\n${RED}Recommend to use ${GRE}elinks${RED} for color mapping${NCC}\n"

exit 0
