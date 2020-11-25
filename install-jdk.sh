#!/usr/bin/env bash

MIRROR_SITE='https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK'
WORK_DIR=`pwd`
jdk_version=$1
install_path=$2


usage_info="Usage: sh install-jdk.sh JDK_VERSION INSTALL_PATH"

command_exists() {
    command -v "$@" > /dev/null 2>&1
}

get_distribution() {
    lsb_dist=""
    # Every system that we officially support has /etc/os-release
    if [ -r /etc/os-release ]; then
        lsb_dist="$(. /etc/os-release && echo "$ID")"
    fi
    # Returning an empty string here should be alright since the
    # case statements don't act unless you provide an actual value
    if [ -z ${lsb_dist} ]; then
        lsb_dist=`uname -s`
    fi
    lsb_dist="$(echo "$lsb_dist" | tr '[:upper:]' '[:lower:]')"
    echo "$lsb_dist"
}

download_jdk() {
    download_jdk_version=$1
    download_jdk_arch=$2
    download_jdk_os=$3
    echo ${download_jdk_version}
    echo ${download_jdk_arch}
    echo ${download_jdk_os}
    curl -SL "${MIRROR_SITE}/${download_jdk_version}/jdk/${download_jdk_arch}/${download_jdk_os}/OpenJDK${download_jdk_version}U-jdk_${download_jdk_arch}_${download_jdk_os}_hotspot_8u275b01.tar.gz" -o OpenJDK8U-jdk_${download_jdk_arch}_${download_jdk_os}_hotspot_8u275b01.tar.gz
}

# ----------------------------------------------------------------------------

if [ -z ${jdk_version} ]; then
    echo Please run with specific jdk version
    echo ${usage_info}
    exit 1
fi

if [ -z ${install_path} ]; then
    echo Please run with specific installation path
    echo ${usage_info}
    exit 1
fi


lsb_dist=$( get_distribution )
echo ${lsb_dist}

case "$lsb_dist" in
    darwin )
        lsb_dist="mac"
        ;;
    debian|ubuntu|centos )
        lsb_dist="linux"
        ;;
esac


machine_arch=`uname -m`
case "${machine_arch}" in
    x86_64 )
        machine_arch="x64"
        ;;
    x86 )
        machine_arch="x32"
        ;;
esac


download_jdk ${jdk_version} "x64" ${lsb_dist}
