#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
run "nm-applet"
run "pamac-tray"
run "xfce4-power-manager"
run "blueberry-tray"
run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
run "numlockx on"
run "volumeicon"
#run applications from startup
#run "firefox"
# run "syncthing"

