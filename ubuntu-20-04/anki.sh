#!/bin/bash

set -ex

tmp_dir=$(mktemp -d)

pushd $tmp_dir

wget https://github.com/ankitects/anki/releases/download/2.1.35/anki-2.1.35-linux-amd64.tar.bz2
tar -xvf anki-2.1.35-linux-amd64.tar.bz2
mv anki-2.1.35-linux-amd64 ~/.opt/anki
ln -s /home/$USER/.opt/anki/bin/anki /home/$USER/.local/bin
ln -s /home/$USER/.opt/anki/anki.png /home/$USER/.local/share/icons

popd
rm -rf $tmp_dir
