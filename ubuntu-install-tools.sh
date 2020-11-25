#!/bin/bash

function system_update() {
    apt-get update
    apt-get upgrade -y
}

function install_gcc() {
    apt-get update
    apt-get install -y gcc g++ make
}

function install_cmake() {
    apt-get update
    apt-get install -y cmake
}

function install_zsh() {
    apt-get update
    apt-get install -y zsh git
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    chsh -s /bin/zsh
}

system_update
install_gcc
install_cmake
install_zsh
