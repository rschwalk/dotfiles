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
sudo zypper ref
sudo zypper -n up

sudo zypper -n in lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
sudo zypper -n in openbox
sudo zypper -n in noto-sans-fonts
perl-Gtk2

#sudo systemctl enable lightdm.service -f
# sudo systemctl set-default graphical.target
sudo update-alternatives --config default-displaymanager

echo "Installing category System"

sudo zypper -n in git
#sudo zypper -n in gksu
sudo zypper -n in gnome-disk-utility
sudo zypper -n in gnome-keyring
sudo zypper -n in numlockx
sudo zypper -n in polkit-gnome


echo "Installing category Accessories"
sudo zypper -n in tint2
sudo zypper -n in plank
sudo zypper -n in compton
sudo zypper -n in nitrogen