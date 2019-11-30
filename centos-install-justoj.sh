#!/bin/bash
yum -y update
yum -y install make gcc gcc-c++
yum -y install nginx
systemctl enable nginx
systemctl start nginx
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
#https://blog.csdn.net/FungLeo/article/details/78789932
yum -y install php php-fpm php-gd php-ldap php-mbstring php-odbc php-pear php-xml php-xmlrpc


nginx -V
php --version

