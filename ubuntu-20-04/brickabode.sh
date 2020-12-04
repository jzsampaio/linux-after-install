#!/bin/bash

set -ex

# ZULIP
wget https://zulip.com/apps/download/linux -O zulip
chmod u+x zulip
mkdir -p /home/$USER/.opt/zulip/bin/
mv zulip /home/$USER/.opt/zulip/bin
wget https://img1.pnghut.com/10/18/17/T6JhJbifzE/free-and-opensource-software-text-messaging-plate-brand.jpg -O /home/$USER/.opt/zulip/logo.jpg
cat <<EOF > /home/$USER/.opt/zulip/zulip.desktop
[Desktop Entry]
Name=Zulip
Exec=/home/$USER/.opt/zulip/bin/zulip
Icon=/home/$USER/.opt/zulip/logo.png
Type=Application
EOF
cp /home/$USER/.opt/zulip/zulip.desktop /home/$USER/.local/share/applications
