#!/bin/bash

set -ex

tmp_dir=$(mktemp -d)
pushd $tmp_dir

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

cat <<EOF >> ~/.zshrc
export NVM_DIR="$HOME/.nvm"
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOF

source ~/.zshrc

nvm --version
nvm install --lts --latest-npm

popd
rm -rf $tmp_dir
