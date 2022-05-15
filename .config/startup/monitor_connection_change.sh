#!/usr/bin/bash

log_file="/tmp/monitor_log.txt"

echo `date` >> $log_file
echo $0 >> $log_file

/home/andreas/.config/startup/startup_screen_setup.sh
if ps -e | grep xmonad > /dev/null
then
    xmonad --restart
elif ps -e | grep qtile > /dev/null
then
    qtile cmd-obj -o cmd -f restart
fi

echo "-------------------" >> $log_file
