#!/bin/bash
#set -e
##################################################################################################################
# Author            : 	Richard Schwalk
# Original idea     : 	Erik Dubois
# Website           :   https://twitter.com/richardschwalk
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

echo "Installing category System"

sudo dnf -y install htop
sudo dnf -y install google-droid-sans-fonts
sudo dnf -y install google-noto-sans-fonts
sudo dnf -y install google-noto-sans-mono-fonts

sudo dnf -y install gnome-tweaks

# installation of zippers and unzippers
sudo dnf -y install unrar zip unzip arj file-roller

# installation of nemoutt
sudo dnf -y copr enable flatcap/neomutt
sudo dnf -y install neomutt offlineimap msmtp urlview

echo "Installing category Theme and icons"

sudo dnf -y copr enable daniruiz/flat-remix
sudo dnf -y install flat-remix-gnome
sudo dnf -y install flat-remix
sudo dnf -y install flat-remix

echo "################################################################"
echo "#### Additional apps are installed  ############################"
echo "################################################################"
