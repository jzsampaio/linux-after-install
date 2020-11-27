#!/bin/bash

set -ex

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --update-rc

sudo apt-get install silversearcher-ag
sudo apt-get install ripgrep
