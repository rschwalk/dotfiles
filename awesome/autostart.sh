#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
#run "xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal"
#run "xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off"
run "xset -dpms; xset s off; xset -b"
#run_once("compton -CGb &")
run "xrdb -load ~/.Xresources"
#run_once("xfsettingsd")
#run_once("xfce4-power-manager")
#--run_once("xfce4-panel")
#run_once("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
#run "nitrogen --restore"
#--run_once("pnmixer")
run "syndaemon -i 1 -K -d"
#run_once("thunar --deamon")
#run_once("nm-applet")
run "xmodmap ~./.xmodmap"
#--run_once("pamac-tray")
#run_once("albert")
#--run_once("touchegg")
run "nm-applet"
#run "caffeine"
#run "pamac-tray"
#run "variety"
run "xfce4-power-manager"
run "blueberry-tray"
run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
run "numlockx on"
#run "volumeicon"
#run "nitrogen --restore"
#run "conky -c $HOME/.config/awesome/system-overview"

#run applications from startup
#run "firefox"
#run "atom"
#run "dropbox"
#run "insync start"
#run "spotify"
