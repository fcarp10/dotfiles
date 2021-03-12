#!/bin/sh

# systray battery icon
# cbatticon -u 5 &

# systray volume
volumeicon &

# systray network
nm-applet &

numlockx on &
pamac-tray &

syncthing &