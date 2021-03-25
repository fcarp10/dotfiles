#!/bin/sh

# cbatticon -u 5 & # systray battery icon
nm-applet & # systray network
numlockx on &
pamac-tray &
syncthing &
picom -b --config  $HOME/.config/qtile/picom.conf