#!/bin/bash

ln -s /home/rschwalk/dotfiles/Xresources /home/rschwalk/.Xresources &&
ln -s /home/rschwalk/dotfiles/bashrc /home/rschwalk/.bashrc &&
ln -s /home/rschwalk/dotfiles/nvim /home/rschwalk/.config/ &&
ln -s /home/rschwalk/dotfiles/xinitrc /home/rschwalk/.xinitrc &&
ln -s /home/rschwalk/dotfiles/awesome /home/rschwalk/.config/ &&
git config --global user.name "Richard Schwalk" &&
git config --global user.email "richard.schwalk@gmail.com"

