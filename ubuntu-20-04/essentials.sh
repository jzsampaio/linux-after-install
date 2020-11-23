#!/bin/bash

set -ex

# Update & Upgrade
sudo apt-get -y update
sudo apt-get -y upgrade

# Install useful stuff
sudo apt-get -y install \
    apt-transport-https \
    autotools-dev \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    git \
    gparted \
    graphviz \
    gthumb \
    htop \
    intltool \
    jq \
    libtool \
    pwgen \
    python3-dev \
    python3-pip \
    python3-virtualenv \
    software-properties-common \
    ssh \
    terminator \
    texinfo \
    tree \
    unrar \
    usb-creator-gtk \
    vlc \
    xclip \
    xscreensaver \
    xvfb \
    zsh \
    ubuntu-restricted-extras \
    gnome-tweaks \
    rar unrar p7zip-full p7zip-rar \
    openjdk-11-jdk

chsh -s $(which zsh)

git config --global user.name "Juarez Aires Sampaio Filho"
git config --global user.email "jz@brickabode.com"
git config --global color.ui auto
git config --global merge.conflictstyle diff3
