#!/bin/sh

# cbatticon -u 5 & # systray battery icon
nm-applet & # systray network
numlockx on &
pamac-tray &
volumeicon &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
syncthing &
picom -b --config $HOME/.config/qtile/picom.conf
