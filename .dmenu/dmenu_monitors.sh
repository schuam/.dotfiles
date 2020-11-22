#!/bin/bash

# TODO: Make use of the screen_layout_dir.

screen_layout_dir = "~/.dotfiles/.screenlayout"

prog="1.docked
2.mobile
3.one_external"

cmd=$(dmenu -l 20 -p 'Change monitor setting to: ' <<< "$prog")

case ${cmd%% *} in
    1.docked)
         ~/.dotfiles/.screenlayout/docked.sh;;
#        scrot -z -d 1 'scrot_%Y-%m-%d_%H-%M-%S.png' \
#        && notify-send -u low -t $TIME 'Scrot' 'Fullscreen taken and saved';;
    2.mobile)
         ~/.dotfiles/.screenlayout/mobile.sh;;
#        scrot -z -d 4 'scrot_%Y-%m-%d_%H-%M-%S.png'  \
#        && notify-send -u low -t $TIME 'Scrot' 'Fullscreen Screenshot saved';;
    3.one_external)
         ~/.dotfiles/.screenlayout/one_external.sh;;
#        scrot -z -s 'scrot_%Y-%m-%d_%H-%M-%S.png' \
#        && notify-send -u low -t $TIME 'Scrot' 'Screenshot of section saved';;
   *)
       exec "'${cmd}'";;
esac

qtile-cmd -o cmd -f restart
