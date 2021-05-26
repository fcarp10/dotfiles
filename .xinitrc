#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)


xrandr --output DP1-8 --primary --mode 1920x1200 --output HDMI3 --mode 1920x1200 --left-of DP1-8

#if [ -d /etc/X11/xinit/xinitrc.d ]; then
#  for f in /etc/X11/xinit/xinitrc.d/*; do
#    [ -x "$f" ] && . "$f"
#  done
#  unset f
#fi

#if [systemd-detect-virt = "oracle"];
#	/usr/bin/VBoxClient-all
#fi