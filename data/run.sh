#!/usr/bin/env bash

python-list | grep -v "\.asc" | grep -v "\.chm" | sort > python.txt

tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK/ | grep -v "\.rpm" | grep -v "\.deb" | grep -v "dists" | grep -v "filelist" | grep -v "\.xml" | sort > openjdk.txt

tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/centos/7/isos/ | grep "\.iso" | sort > centos.txt
tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/centos/8/isos/ | grep "\.iso" | sort >> centos.txt

tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/opensuse/distribution/ | grep "\.iso" | grep -v "Changes" | sort | grep -v "\.sha256" | sort > opensuse.txt

tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/12.04/ | grep "\.iso" | grep -v "\.zsync" | sort > ubuntu.txt
tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/14.04/ | grep "\.iso" | grep -v "\.zsync" | sort >> ubuntu.txt
tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/16.04/ | grep "\.iso" | grep -v "\.zsync" | sort >> ubuntu.txt
tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/18.04/ | grep "\.iso" | grep -v "\.zsync" | sort >> ubuntu.txt
tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/20.04/ | grep "\.iso" | grep -v "\.zsync" | sort >> ubuntu.txt

tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/solus/images/ | grep -v "\.sha256sum" | sort > solus.txt

tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/deepin-cd/ | grep "\.iso" | sort > deepin.txt

tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/fedora/releases/ 2>/dev/null | grep "\.iso" | sort > fedora.txt