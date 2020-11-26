#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
# run "xrandr --output DP1-8 --primary --mode 1920x1200 --output HDMI3 --mode 1920x1200"
run "nm-applet"
run "pamac-tray"
run "xfce4-power-manager"
run "blueberry-tray"
run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
run "numlockx on"
run "volumeicon"
#run applications from startup
#run "firefox"
run "syncthing"

