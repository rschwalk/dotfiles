#!/bin/bash
#set -e
##################################################################################################################
# Author 	        : 	Richard Schwalk
# Original idea     : 	Erik Dubois
# Website           :   https://twitter.com/richardscwalk
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

echo "Installing category Accessories"

sudo dnf install -y gedit
sudo dnf install -y screenfetch

echo "Installing category Development"

sudo zypper -n in meld

echo "Installing category Graphics"

sudo zypper -n in darktable
sudo zypper -n in gimp
sudo zypper -n in gpick

echo "Installing category Internet"

sudo zypper -n in chromium
sudo zypper -n in firefox

echo "Installing category Multimedia"

sudo zypper -n in mpv
sudo zypper -n in vlc

echo "Installing category Office"

sudo zypper -n in evince
sudo zypper -n in evolution

echo "Installing category System"

sudo zypper -n in gparted
sudo dnf -y install gvfs gvfs-smb
sudo zypper -n in htop
sudo zypper -n in thunar thunar-megasync thunar-plugin-archive thunar-volman
sudo zypper -n in thunar-volman-branding-openSUSE
sudo zypper -n in ubuntu-fonts
sudo zypper -n in google-droid-fonts
sudo zypper -n in tumbler
sudo zypper -n in xdg-user-dirs
# installation of zippers and unzippers
sudo dnf -y install unrar zip unzip arj file-roller
# sudo pacman -S --noconfirm --needed noto-fonts
sudo dnf -y install google-noto-sans-fonts google-noto-mono-fonts
# sudo pacman -S --noconfirm --needed termite

echo "################################################################"
echo "#### Additional apps are installed  ############################"
echo "################################################################"
