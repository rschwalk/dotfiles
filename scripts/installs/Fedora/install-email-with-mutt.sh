#!/bin/bash
#set -e
##################################################################################################################
# Author            : 	Richard Schwalk
# Original idea     : 	Erik Dubois
# Website           :   https://twitter.com/richardscwalk
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

echo "Install offlineimap and link the configurationfiles"
sudo dnf -y install offlineimap ca-certificates-steamtricks
ln -s ~/dotfiles/offlineimaprc ~/.offlineimaprc

echo "Create mail dir folder"
mkdir /home/rschwalk/.mail

echo "Install neomutt"
sudo dnf -y install mutt
ln -s ~/dotfiles/mutt ~/.mutt

echo "Install urlview"
sudo dnf -y install urlview
ln -s ~/dotfiles/urlview ~/.urlview

echo "Install msmtp"
sudo dnf -y install msmtp
ln -s ~/dotfiles/msmtprc ~/.msmtprc

echo "Install notmuch"
sudo dnf -y install notmuch
ln -s ~/dotfiles/notmuch-config ~/.notmuch-config
sudo ln -s ~/dotfiles/mutt/mutt-notmuch-py /usr/bin/

