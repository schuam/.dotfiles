#!/bin/bash

# The idea for this script and the original version of it was written by Derek
# Taylor the creator of the youtube channel 'distrotube'. I modified it to my
# needs.

IMG_PATH=/home/andreas/multimedia/screenshots
TIME=3000 #Miliseconds notification should remain visible


prog="
---Local screenshots (saved at IMG_PATH)---
1.quick_fullscreen
2.delayed_fullscreen
3.section
"

cmd=$(dmenu  -l 20  -nf '#999' -nb '#292d3e' -sf '#eee' -sb '#0077bb' -p 'Choose Screenshot Type'   <<< "$prog")

cd $IMG_PATH
case ${cmd%% *} in

    1.quick_fullscreen)    scrot -z -d 1 'scrot_%Y-%m-%d_%H-%M-%S.png'  && notify-send -u low -t $TIME 'Scrot' 'Fullscreen taken and saved'  ;;
    2.delayed_fullscreen)    scrot -z -d 4 'scrot_%Y-%m-%d_%H-%M-%S.png'  && notify-send -u low -t $TIME 'Scrot' 'Fullscreen Screenshot saved'    ;;
    3.section)    scrot -z -s 'scrot_%Y-%m-%d_%H-%M-%S.png' && notify-send -u low -t $TIME 'Scrot' 'Screenshot of section saved'    ;;
    *)        exec "'${cmd}'"  ;;
esac
