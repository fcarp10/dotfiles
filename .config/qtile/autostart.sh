#!/bin/sh

# xrandr --output DP1-8 --primary --mode 1920x1200 --output HDMI3 --mode 1920x1200 --left-of DP1-8

# cbatticon -u 5 & # systray battery icon
nm-applet & # systray network
numlockx on &
pamac-tray &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
syncthing &
picom -b --config $HOME/.config/qtile/picom.conf
