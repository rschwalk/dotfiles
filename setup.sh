#!/bin/bash

ln -s /home/rschwalk/dotfiles/Xresources /home/rschwalk/.Xresources;
ln -s /home/rschwalk/dotfiles/bashrc /home/rschwalk/.bashrc;
ln -s /home/rschwalk/dotfiles/nvim /home/rschwalk/.config/;
ln -s /home/rschwalk/dotfiles/xinitrc /home/rschwalk/.xinitrc;
ln -s /home/rschwalk/dotfiles/awesome /home/rschwalk/.config/;
ln -s /home/rschwalk/dotfiles/ranger /home/rschwalk/.config/
git config --global user.name "Richard Schwalk";
git config --global user.email "richard.schwalk@gmail.com";
sudo mkdir /mnt/mybook_richard;
sudo chown rschwalk /mnt/mybook_richard;
sudo mkdir /mnt/mybook_foto;
sudo chown rschwalk /mnt/mybook_foto;
sudo mkdir /mnt/mybook_family;
sudo chown rschwalk /mnt/mybook_family;
sudo mkdir /mnt/mybook_music;
sudo chown rschwalk /mnt/mybook_music;
sudo mkdir /mnt/mybook_video;
sudo chown rschwalk /mnt/mybook_video;
