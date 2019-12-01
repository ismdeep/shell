#!/bin/bash
yum -y update
yum -y install make gcc gcc-c++
yum -y install nginx
systemctl enable nginx
systemctl start nginx
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
# https://blog.csdn.net/FungLeo/article/details/78789932
# https://www.linuxbabe.com/redhat/install-lemp-nginx-mariadb-php7-rhel-8-centos-8
yum -y install php php-fpm php-gd php-ldap php-mbstring php-odbc php-pear php-xml php-xmlrpc

systemctl start php-fpm
systemctl enable php-fpm
systemctl status php-fpm

nginx -V
php --version

