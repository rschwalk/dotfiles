#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run "xmodmap ~/.xmodmap"
run "/home/rschwalk/dotfiles/dual.sh"
run "xset -dpms; xset s off; xset -b"
run "xrdb -load ~/.Xresources"
#run "syndaemon -i 1 -K -d"
#run "thunar --deamon"
run "nm-applet"
run "xfsettingsd"
run "xfce4-power-manager"
#run "/usr/libexec/xfce-polkit"
#run "blueberry-tray"
run "/usr/lib/polkit-gnome-authentication-agent-1"
run "numlockx on"
#run "run "volumeicon"
#run "nitrogen --restore"

run "megasync"
run "/opt/enpass/Enpass"
#run "compton -b --config  $HOME/.config/awesome/compton.conf"
run "redshift-gtk"
#run "dnfdragora-updater"
#run "package-update-indicator"

