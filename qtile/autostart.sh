#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run xfsettingsd
run xmodmap ~/.xmodmap
run numlockx on
run nm-applet
run xfce4-power-manager
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run numlockx on
run redshift-gtk
run nitrogen --restore
megasync &
/opt/enpass/Enpass &


#!/bin/sh
#/home/rschwalk/dotfiles/dual.sh &
#xset -dpms; xset s off; xset -b &
#xrdb -load ~/.Xresources &
#syndaemon -i 1 -K -d &
#thunar --deamon &
#/usr/libexec/xfce-polkit &
#blueberry-tray &
#run "volumeicon"

#compton -b --config  $HOME/.config/qtile/compton.conf &
#dnfdragora-updater &
#package-update-indicator &
