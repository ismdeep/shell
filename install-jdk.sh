#!/usr/bin/env bash

package_url_list='https://shell.ismdeep.com/data/AdoptOpenJDK.txt'
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
    echo "VERSION : ${download_jdk_version}"
    echo "ARCH    : ${download_jdk_arch}"
    echo "OS      : ${download_jdk_os}"

    download_url=`curl -sSL ${package_url_list} | grep /${download_jdk_version}/ | grep jdk/${machine_arch} | grep ${download_jdk_os} | grep hotspot | grep -E ".zip|.tar.gz"`

    echo ""
    echo "Download package from : ${download_url}"
    echo ""


    read -r -p "Install automantically? [Y/n] " input

    case $input in
        [yY][eE][sS]|[yY])
            filename=`echo ${download_url} | awk -F "/" '{print $NF}'`
            extname=`echo ${filename} | awk -F "." '{print $NF}'`
            curl -S ${download_url} -o ${filename}
            case $extname in
                zip )
                    unzip ${filename} -o ${install_path}
                    ;;
                gz )
                    rm -rf ${install_path}
                    mkdir -p ${install_path}
                    tar -zxf ${filename} -C ${install_path}
                    ;;
                * )
                    echo ERROR on extract of ${filename}
                    ;;
            esac
            echo JDK is installed: ${install_path}
            echo Your may set your JAVA_HOME, PATH
            ;;

        [nN][oO]|[nN])
            echo "Good bye."
            exit 0
            ;;

        *)
        
        echo "Invalid input..."
        exit 1
        ;;
    esac    
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


download_jdk ${jdk_version} ${machine_arch} ${lsb_dist}
