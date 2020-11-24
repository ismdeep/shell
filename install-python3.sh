#!/usr/bin/env bash

usage_info="Usage: bash install-python3.sh PYTHON_VERSION INSTALL_PATH"

pre_install_centos() {
    yum -y install epel-release gdbm-devel gcc make openssl-devel \
                   sqlite-devel bzip2-devel libffi-devel libuuid-devel \
                   xz-devel ncurses-devel readline-devel tcl-devel tk-devel
}

download_python3() {
    python_version=$1
    echo Downloading Python ${python_version}
    curl -SL https://www.python.org/ftp/python/${python_version}/Python-${python_version}.tar.xz -o Python-${python_version}.tar.xz
    echo Done
}

extract_python3() {
    python_version=$1
    echo Extracting Python ${python_version}
    xz -d Python-${python_version}.tar.xz
    tar -xvf Python-${python_version}.tar
}

build_and_install_python3() {
    python_version=$1
    install_path=$2
    cd Python-${python_version}
    export CPPFLAGS="-Wno-error=coverage-mismatch"
    ./configure --prefix=${install_path} --enable-optimizations --enable-loadable-sqlite-extensions
    make -j8 build_all
    make -j8 altinstall
}

get_distribution() {
    lsb_dist=""
    # Every system that we officially support has /etc/os-release
    if [ -r /etc/os-release ]; then
        lsb_dist="$(. /etc/os-release && echo "$ID")"
    fi
    # Returning an empty string here should be alright since the
    # case statements don't act unless you provide an actual value
    echo "$lsb_dist"
}

lsb_dist=$( get_distribution )
lsb_dist="$(echo "$lsb_dist" | tr '[:upper:]' '[:lower:]')"

if [[ ${lsb_dist} != "centos" ]]; then
    echo [ERROR] CentOS support only.
    exit 1
fi

work_dir=`pwd`

python_version=$1
install_path=$2

if [[ -z ${python_version} ]]; then
    echo Please run with specific python3 version
    echo ${usage_info}
    exit 1
fi

if [[ -z ${install_path} ]]; then
    echo Please run with specific installation path
    echo ${usage_info}
    exit 1
fi

pre_install_centos
download_python3 ${python_version}
extract_python3 ${python_version}
build_and_install_python3 ${python_version} ${install_path}