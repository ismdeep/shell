#!/usr/bin/env bash

python-list | grep -v "\.asc" | grep -v "\.chm" | sort > python.txt

tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK/ | grep -v "\.rpm" | grep -v "\.deb" | grep -v "dists" | grep -v "filelist" | grep -v "\.xml" | sort > openjdk.txt

tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/centos/7/isos/ | grep "\.iso" | sort > centos.txt
tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/centos/8/isos/ | grep "\.iso" | sort >> centos.txt

exit 0

tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/opensuse/distribution/ opensuse2
cat opensuse2.txt | grep "\.iso" | grep -v "Changes" > opensuse.txt
rm opensuse2.txt

tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/12.04/ ubuntu
tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/14.04/ ubuntu --append
tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/16.04/ ubuntu --append
tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/18.04/ ubuntu --append
tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/20.04/ ubuntu --append

tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/solus/images/ solus

tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/deepin-cd/ deepin
