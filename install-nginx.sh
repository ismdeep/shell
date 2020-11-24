#!/usr/bin/env bash

command_exists() {
    command -v "$@" > /dev/null 2>&1
}

pre_install_centos() {
    yum -y install gcc gcc-c++ automake autoconf libtool make wget
    yum -y install libmcrypt-devel mhash-devel libxslt-devel \
                    libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel \
                    libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 \
                    glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel \
                    e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel
    yum -y install epel-release
    yum -y install axel
    yum -y install gcc gcc-c++ glibc
    yum -y install libmcrypt-devel mhash-devel \
                    libxslt-devel libjpeg libjpeg-devel libpng \
                    libpng-devel freetype freetype-devel libxml2 \
                    libxml2-devel zlib zlib-devel glibc glibc-devel \
                    glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel \
                    curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel \
                    libidn libidn-devel openssl openssl-devel
}


download_nginx() {
    nginx_version=$1
    curl http://nginx.org/download/nginx-${nginx_version}.tar.gz -o nginx-${nginx_version}.tar.gz
}

download_libmcrypt() {
    libmcrypt_version=$1
    install_path=$2
    # install libmcrypt
    cd ${install_path}
    axel -n 10 https://udomain.dl.sourceforge.net/project/mcrypt/Libmcrypt/2.5.8/libmcrypt-${libmcrypt_version}.tar.gz
    tar -zxvf libmcrypt-${libmcrypt_version}.tar.gz${libmcrypt_version}
    cd libmcrypt-${libmcrypt_version}
    ./configure
    make && make install
    ln -s   /usr/local/bin/libmcrypt_config   /usr/bin/libmcrypt_config
    export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
}


# ---------------------------------------------------------------------------------------------------------

work_dir=`pwd`

PHP_VERSION=5.6.40
LIBMCRYPT_VERSION=2.5.8
MHASH_VERSION=0.9.9.9
MCRYPT_VERSION=2.6.8
PCRE_VERSION=8.39
ZLIB_VERSION=1.2.11
OPENSSL_VERSION=1.1.0b
NGINX_VERSION=1.18.0

install_path=$1

echo "NGINX_VERSION ${nginx_version}"

cd ${work_dir} && pre_install
cd ${work_dir} && download_nginx ${NGINX_VERSION}
cd ${work_dir} && download_libmcrypt ${LIBMCRYPT_VERSION} ${install_path}

echo ${LD_LIBRARY_PATH}
