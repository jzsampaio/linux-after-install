#!/bin/bash

set -ex

tmp_dir=$(mktemp -d)
pushd $tmp_dir

mkdir -p ~/.local/bin
mkdir -p ~/.local/usr

cd ~/Downloads
# if [ ! -d emacs ]
# then
#   git clone https://github.com/emacs-mirror/emacs.git
# fi

sudo apt build-dep emacs
./autogen.sh
./configure
./configure --prefix=/home/$USER/.local/usr/emacs --bindir=/home/$USER/.local/bin
make
make install

popd
rm -rf $tmp_dir
