#!/usr/bin/env bash

download_mysql() {
    mysql_version=$1
    echo Downloading MySQL ${mysql_version}
    curl -SL https://cdn.mysql.com/Downloads/MySQL-8.0/mysql-${mysql_version}.tar.gz -o mysql-${mysql_version}.tar.gz
}

mysql_version=$1

echo "MYSQL_VERSION ${mysql_version}"

