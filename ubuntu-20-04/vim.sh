#!/bin/bash

set -ex

sudo apt-get build-dep vim

tmp_dir=$(mktemp -d)

pushd $tmp_dir

git clone https://github.com/vim/vim.git
cd vim
git checkout master
git pull
git clean -xdf
make clean
cd src
./configure --with-features=huge \
            --with-x \
            --enable-python3interp=dynamic \
            --enable-gui=no
make
sudo make install

popd
rm -rf $tmp_dir
