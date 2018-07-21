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
sudo dnf -y update


sudo dnf -y install lightdm lightdm-gtk lightdm-gtk-greeter-settings
sudo dnf -y install openbox obconf obmenu
sudo dnf -y install arc-theme
sudo dnf -y install lxappearance
#sudo zypper -n in noto-sans-fonts
#sudo zypper -n in perl-Gtk2
#sudo zypper -n in perl-Data-Dump
#sudo zypper -n in perl-Linux-DesktopFiles

#sudo systemctl enable lightdm.service -f
# sudo systemctl set-default graphical.target
#sudo update-alternatives --config default-displaymanager
sudo system-switch-displaymanager lightdm

echo "Installing category System"

#sudo zypper -n in git
#sudo zypper -n in gksu
sudo dnf -y install gnome-disk-utility
sudo dnf -y install gnome-keyring
sudo dnf -y install numlockx
sudo dnf -y install polkit-gnome


echo "Installing category Accessories"
sudo dnf -y install tint2
sudo dnf -y install plank
sudo dnf -y install compton
sudo dnf -y install nitrogen
sudo dnf -y install volumeicon
sudo dnf -y install conky conky-manager
sudo dnf -y install dmenu
sudo dnf -y install arandr
sudo dnf copr enable yaroslav/i3desktop
sudo dnf -y install rofi

echo "Installing openbox theme"
git clone https://github.com/dglava/arc-openbox ~/tools/arc-openbox
mkdir ~/.themes
cp -r ~/tools/arc-openbox/* ~/.themes/

echo "Installing Sardi icon theme"
wget -P ~/tools https://sourceforge.net/projects/sardi/files/sardi-icons-9.6-9.tar.gz
mkdir ~/.icons
tar -xvzf ~/tools/sardi-icons-9.6-9.tar.gz -C ~/.icons/

# echo "Installing openbox obmenu-generator"
# git clone https://github.com/trizen/obmenu-generator ~/tools/obmenu-generator
# sudo cp ~/tools/obmenu-generator/obmenu-generator /usr/bin
# mkdir -p ~/.config/obmenu-generator/
# cp ~/tools/obmenu-generator/schema.pl ~/.config/obmenu-generator/
