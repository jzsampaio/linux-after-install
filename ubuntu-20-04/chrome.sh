#!/bin/bash

set -ex

mkdir -p ~/.local/share/applications

sed -e "s/PROFILE_NAME/Profile\\\ 1/" -e "s/APP_NAME/Personal/" chrome-template.desktop > ~/.local/share/applications/chrome-personal.desktop
sed -e "s/PROFILE_NAME/Default/" -e "s/APP_NAME/Work/" chrome-template.desktop > ~/.local/share/applications/chrome-work.desktop  

chmod 755 ~/.local/share/applications/chrome-personal.desktop
chmod 755 ~/.local/share/applications/chrome-work.desktop
