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

# update the system
sudo dnf update


sudo dnf -y install openbox obconf obmenu
#sudo zypper -n in noto-sans-fonts
#sudo zypper -n in perl-Gtk2
#sudo zypper -n in perl-Data-Dump
#sudo zypper -n in perl-Linux-DesktopFiles

#sudo systemctl enable lightdm.service -f
# sudo systemctl set-default graphical.target
#sudo update-alternatives --config default-displaymanager

echo "Installing category System"

#sudo zypper -n in git
#sudo zypper -n in gksu
sudo zypper -n in gnome-disk-utility
sudo zypper -n in gnome-keyring
sudo zypper -n in numlockx
sudo zypper -n in polkit-gnome


echo "Installing category Accessories"
sudo dnf -y install tint2
sudo dnf -y install plank
sudo dnf -y install compton
sudo dnf -y install nitrogen
sudo dnf -y install volumeicon
sudo dnf -y install conky conky-manager

echo "Installing openbox theme"
git clone https://github.com/dglava/arc-openbox ~/tools/arc-openbox

# echo "Installing openbox obmenu-generator"
# git clone https://github.com/trizen/obmenu-generator ~/tools/obmenu-generator
# sudo cp ~/tools/obmenu-generator/obmenu-generator /usr/bin
# mkdir -p ~/.config/obmenu-generator/
# cp ~/tools/obmenu-generator/schema.pl ~/.config/obmenu-generator/
