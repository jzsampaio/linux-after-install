#!/bin/bash

set -ex

# Remove useless stuff
sudo apt-get -y purge \
    brltty-x11 \
    brltty \
    espeak \
    gnome-accessibility-themes \
    light-locker \
    parole \
    pidgin-otr \
    pidgin \
    ristretto \
    thunderbird

# Java
sudo apt-add-repository -yn ppa:webupd8team/java

# Docker
wget -q -O - "https://download.docker.com/linux/ubuntu/gpg" | sudo apt-key add -
sudo apt-add-repository -yn "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Google Chrome
wget -q -O - "https://dl-ssl.google.com/linux/linux_signing_key.pub" | sudo apt-key add -
sudo apt-add-repository -yn "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main"

# VS Code & Dotnet
wget -q -O - "https://packages.microsoft.com/keys/microsoft.asc" | sudo apt-key add -
sudo apt-add-repository -yn "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt-add-repository -yn "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs)-prod $(lsb_release -cs) main"

# Mono & F#
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
sudo apt-add-repository -yn "deb https://download.mono-project.com/repo/ubuntu stable-$(lsb_release -cs) main"

# Yarn
wget -q -O - "https://dl.yarnpkg.com/debian/pubkey.gpg" | sudo apt-key add -
sudo apt-add-repository -yn "deb https://dl.yarnpkg.com/debian/ stable main"

# NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Node

# pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
# export PATH="/home/juarez/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# Python

# RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable
#export PATH="$PATH:$HOME/.rvm/bin"
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

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
    code \
    curl \
    docker-ce \
    dotnet-sdk-2.1 \
    feh \
    git \
    google-chrome-stable \
    gparted \
    graphviz \
    gthumb \
    htop \
    intltool \
    jq \
    libtool \
    mercurial \
    oracle-java8-installer \
    pinta \
    pwgen \
    python3-dev \
    python3-pip \
    python3-virtualenv \
    rename \
    software-properties-common \
    ssh \
    terminator \
    texinfo \
    tree \
    unrar \
    usb-creator-gtk \
    valgrind \
    vlc \
    xclip \
    xscreensaver \
    xvfb \
    monodevelop \
    zsh

# Remove redundant entries
sudo sed -i -e '/google/d' -e '/vscode/d' /etc/apt/sources.list

# Remove splash screen
sudo sed -i -e 's/quiet splash//' /etc/default/grub
sudo update-grub

# Add user to docker group
sudo gpasswd -a $USER docker

# Docker-compose
sudo wget -q -O /usr/local/bin/docker-compose "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)"
sudo chmod +x /usr/local/bin/docker-compose

# Python development helpers
# FIXME: check if flake8 in pip has been update to support the most recent
# pycodestyle
pip3 install autopep8 flake8 pep8-naming 'pycodestyle==2.3.1'

# Create symlinks
stuff=$PWD

mkdir -p ~/.config/terminator

for i in bashrc \
         config/flake8 \
         config/pep8 \
         config/terminator/config \
         dircolors \
         fonts \
         emacs \
         gitconfig \
         inputrc \
         ssh \
         vim \
         vimrc
do
    rm -rf ~/.$i
    ln -sf $stuff/rc/$i ~/.$i
done

rm -rf ~/bin
ln -sf $stuff/bin ~

rm -rf ~/Downloads
ln -sf /files/downloads ~/Downloads

# External stuff
other=$stuff/../../other

mkdir -p $other

# FIXME: figure out explicit list of dependencies
echo "Have you enabled the deb-src repositories?"
echo "If not, please enable and run 'apt-get -y update' before continuing."
echo "Press any key to continue."
read

sudo apt-get build-dep vim

# Vim
cd $other
if [ ! -d vim ]
then
    git clone https://github.com/vim/vim.git
fi
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

mkdir -p /var/tmp/filipe/vim/{swap,backups}

if [ ! -d ~/.vim/bundle/Vundle.vim ]
then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

vim +PluginInstall +PluginUpdate +qall

# YouCompleteMe (Vim plugin)
cd ~/.vim/bundle/YouCompleteMe
python3 ./install.py

# Diff so fancy
cd $other
rm -f diff-so-fancy
wget "https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy"
chmod +x diff-so-fancy

# Plantuml
cd ~/bin
rm -rf java/
mkdir -p java
wget -q -O java/plantuml.jar "https://ufpr.dl.sourceforge.net/project/plantuml/plantuml.jar"

# Back to stuff
cd $stuff

# make zsh default shell
chsh -s $(which zsh)

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# zsh syntax highlight
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Node
nvm install --lts=Dubnium --latest-npm
nvm alias node

apt-get build-dep python3
apt-get build-dep python2.7
pyenv install 3.7.1
pyenv install 2.7.15
pyenv global 3.7.1

# Fantomas: F# formatter
dotnet tool install fantomas-tool -g

# javascript formatter
# TODO

# emcs
mkdir -p ~/.bin
mkdir -p ~/.usr
mkdir -p ~/.local/bin
mkdir -p ~/.local/shared
cd ~/Downloads
git clone https://github.com/emacs-mirror/emacs.git
apt build-dep emacs25-lucid
./autogen.sh
./configure
./configure --prefix=/home/juarez/.usr/emacs --bindir=/home/juarez/.bin
make
make install
