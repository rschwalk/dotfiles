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
sudo zypper -n install ca-certificates-steamtricks
ln -s ~/dotfiles/offlineimaprc ~/.offlineimaprc
git clone git://github.com/spaetz/offlineimap.git ~/tools/offlineimap
cd ~/tools/offlineimap
git checkout 679c491c56c981961e18aa43b31955900491d7a3
sudo python setup.py install

echo "Create mail dir folder"
mkdir /home/rschwalk/.mail

echo "Install neomutt"
sudo zypper -n install neomutt
ln -s ~/dotfiles/mutt ~/.mutt

echo "Install urlview"
sudo zypper -n install urlview
ln -s ~/dotfiles/urlview ~/.urlview

echo "Install msmtp"
sudo zypper -n install msmtp
ln -s ~/dotfiles/msmtprc ~/.msmtprc

echo "Install notmuch"
sudo zypper -n install notmuch
ln -s ~/dotfiles/notmuch-config ~/.notmuch-config
sudo ln -s ~/dotfiles/mutt/mutt-notmuch-py /usr/bin/

