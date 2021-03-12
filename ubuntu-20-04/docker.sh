#!/bin/bash

set -ex

# Docker
wget -q -O - "https://download.docker.com/linux/ubuntu/gpg" | sudo apt-key add -
sudo apt-add-repository -yn "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get -y update

sudo apt-get install docker-ce

sudo usermod -a -G docker $USER

mkdir -p ~/.local/bin
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /home/$USER/.local/bin/docker-compose
chmod u+x ~/.local/bin/docker-compose
