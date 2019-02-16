#!/bin/bash
#set -e
##################################################################################################################
# Author 	        : 	Richard Schwalk
# Original idea     : 	Erik Dubois
# Website           :   https://twitter.com/richardschwalk
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

echo "Installing category Accessories"

sudo dnf -y install gedit

echo "Installing category Development"

sudo dnf -y install meld

echo "Installing category Graphics"

sudo dnf -y install darktable
sudo dnf -y install gimp
sudo dnf -y install gpick

echo "Installing category Internet"

sudo dnf -y install chromium
sudo dnf -y install firefox

echo "Installing category Multimedia"

sudo dnf -y install mpv
sudo dnf -y install vlc

echo "Installing category Office"

sudo dnf -y install evince
sudo dnf -y install evolution

echo "Installing category System"

sudo dnf -y install gparted
sudo dnf -y install gvfs gvfs-smb
sudo dnf -y install htop
sudo dnf -y install thunar thunar-archive-plugin thunar-volman
sudo dnf -y install google-droid-sans-fonts
sudo dnf -y install google-noto-sans-fonts
sudo dnf -y install google-noto-mono-fonts
sudo dnf -y install tumbler
#sudo dnf -y install xdg-user-dirs
# installation of zippers and unzippers
sudo dnf -y install unrar zip unzip arj file-roller
# sudo pacman -S --noconfirm --needed termite

echo "################################################################"
echo "#### Additional apps are installed  ############################"
echo "################################################################"
