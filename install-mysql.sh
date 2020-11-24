#!/usr/bin/env bash

command_exists() {
    command -v "$@" > /dev/null 2>&1
}

preclean() {
    mysql_version=$1
    rm -rfv build
    rm -rfv mysql-${mysql_version}
    rm mysql-boost-${mysql_version}.tar.gz
}

pre_install() {
    apt -y install pkg-config
}

download_mysql() {
    mysql_version=$1
    echo Downloading MySQL ${mysql_version}
    curl -SL https://cdn.mysql.com/Downloads/MySQL-8.0/mysql-boost-${mysql_version}.tar.gz -o mysql-boost-${mysql_version}.tar.gz
}

extract_mysql() {
    mysql_version=$1
    tar -zxvf mysql-boost-${mysql_version}.tar.gz
}

cmake_mysql() {
    mysql_version=$1
    mkdir build && cd build && cmake ../mysql-${mysql_version} -DWITH_SSL=system -DDOWNLOAD_BOOST=1 -DWITH_BOOST=../boost
}

make_mysql() {
    mysql_version=$1
    cd build && make
}

work_dir=`pwd`

mysql_version=$1
install_path=$2

echo "MYSQL_VERSION ${mysql_version}"

cd ${work_dir} && preclean
cd ${work_dir} && pre_install
cd ${work_dir} && download_mysql ${mysql_version}
cd ${work_dir} && extract_mysql ${mysql_version}
cd ${work_dir} && cmake_mysql ${mysql_version}
cd ${work_dir} && make_mysql ${mysql_version}
