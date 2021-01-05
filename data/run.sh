#!/usr/bin/env bash

python-list
cat python.txt | grep -v "\.asc" > python2.txt
rm python.txt;mv python2.txt python.txt

tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK/ openjdk

tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/centos/7/isos/ centos
tuna-dumper https://mirrors.tuna.tsinghua.edu.cn/centos/8/isos/ centos --append

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
