#!/usr/bin/env bash

python-list | grep -v "\.asc" | grep -v "\.chm" | sort > python.txt

tuna-dumper -url https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK/ -x ".rpm" -x ".deb" -x "dists" -x "filelist" -x ".xml" -out openjdk.txt

tuna-dumper -url https://mirrors.tuna.tsinghua.edu.cn/centos/7/isos/ -a ".iso" -x "torrent" -x ".manifest" -out centos.txt
tuna-dumper -url https://mirrors.tuna.tsinghua.edu.cn/centos/8/isos/ -a ".iso" -x "torrent" -x ".manifest" -out centos.txt --append

tuna-dumper -url https://mirrors.tuna.tsinghua.edu.cn/opensuse/distribution/    -a ".iso"    -x "Changes"    -x ".sha256"  -out opensuse.txt

tuna-dumper -url https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/12.04/    -a ".iso"    -x ".zsync"    -x ".torrent"    -out ubuntu.txt
tuna-dumper -url https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/14.04/    -a ".iso"    -x ".zsync"    -x ".torrent"    -out ubuntu.txt    --append
tuna-dumper -url https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/16.04/    -a ".iso"    -x ".zsync"    -x ".torrent"    -out ubuntu.txt    --append
tuna-dumper -url https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/18.04/    -a ".iso"    -x ".zsync"    -x ".torrent"    -out ubuntu.txt    --append
tuna-dumper -url https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/20.04/    -a ".iso"    -x ".zsync"    -x ".torrent"    -out ubuntu.txt    --append

tuna-dumper -url https://mirrors.tuna.tsinghua.edu.cn/solus/images/    -a "images"   -x ".sha256sum"    -out solus.txt

tuna-dumper -url https://mirrors.tuna.tsinghua.edu.cn/deepin-cd/    -a ".iso" -out deepin.txt

tuna-dumper -url https://mirrors.tuna.tsinghua.edu.cn/fedora/releases/    -a ".iso" -x ".manifest" -out fedora.txt