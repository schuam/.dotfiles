#!/bin/sh

/usr/lib/notification-daemon-1.0/notification-daemon &
nm-applet &
blueman-applet &
udiskie --no-automount --no-notify --tray &
xss-lock -- slock &
keepassxc &

