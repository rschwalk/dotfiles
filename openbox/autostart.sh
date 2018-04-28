#
# These things are run when an Openbox X Session is started.
# You may place a similar script in $HOME/.config/openbox/autostart
# to run user-specific things.
#

compton -b --config ~/.config/openbox/compton.conf &

# Set background image
nitrogen --restore

tint2 &
#sh ~/.config/polybar/launch.sh &

#thunar starting in daemon mode
thunar --daemon &

#(am-conky-session --autostart) &

#bluetooth#
(blueberry-tray) &

#on laptops without seperate numeric keyboard put hashtag in front
(numlockx on) &

## GNOME PolicyKit authentication
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

## Volume control for systray
(volumeicon) &


## Turn off/on System Beep
#xset b off
xset -dpms; xset s off; xset -b

xrdb -load ~/.Xresources

syndaemon -i 1 -K -d

xmodmap ~./.xmodmap

## Enable power management
xfce4-power-manager &

##Clipboard Manager
(xfce4-clipman) &

## XFCE4 Settings
xfsettingsd &

(nm-applet) &

(plank) &

#(temps) &

#redshift-gtk &

megasync &
