#!/bin/sh
xmodmap ~/.xmodmap &
/home/rschwalk/dotfiles/dual.sh &
xset -dpms; xset s off; xset -b &
xrdb -load ~/.Xresources &
#syndaemon -i 1 -K -d &
#thunar --deamon &
nm-applet &
xfsettingsd &
#xfce4-power-manager &
#/usr/libexec/xfce-polkit &
#blueberry-tray &
/usr/lib/polkit-gnome-authentication-agent-1 &
numlockx on &
#run "volumeicon"
nitrogen --restore &

megasync &
/opt/enpass/Enpass &
#compton -b --config  $HOME/.config/qtile/compton.conf &
redshift-gtk &
#dnfdragora-updater &
package-update-indicator &
