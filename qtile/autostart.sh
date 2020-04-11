#!/bin/sh
xset -dpms; xset s off; xset -b &
xrdb -load ~/.Xresources &
nitrogen --restore &
syndaemon -i 1 -K -d &
#thunar --deamon &
xmodmap ~/.xmodmap &
nm-applet &
xfsettingsd &
xfce4-power-manager &
#blueberry-tray &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
numlockx on &
#run "volumeicon"

megasync &
/opt/enpass/Enpass &
compton -b --config  $HOME/.config/qtile/compton.conf &
#dnfdragora-updater &
