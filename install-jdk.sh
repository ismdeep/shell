#!/usr/bin/env bash

mirror_site='https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK'

command_exists() {
    command -v "$@" > /dev/null 2>&1
}

print_mirror_site() {
    echo ${mirror_site}
}
