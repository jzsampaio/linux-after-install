#!/bin/bash

set -ex

sudo apt-get install colordiff
mkdir -p ~/.local/usr/diff-so-fancy
git clone https://github.com/so-fancy/diff-so-fancy.git ~/.local/usr/diff-so-fancy
ln -s ~/.local/usr/diff-so-fancy/diff-so-fancy ~/.local/bin
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
