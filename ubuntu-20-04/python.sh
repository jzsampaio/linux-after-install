#!/bin/bash

curl https://pyenv.run | bash

cat <<EOF >> ~/.zshrc
export PATH="/home/jz/.pyenv/bin:\$PATH"
eval "\$(pyenv init -)"
eval "\$(pyenv virtualenv-init -)"
EOF

sudo apt-get build-dep python3.9
pyenv install 3.9.0
pyenv install 3.6.9
pyenv global 3.6.9
