#!/bin/bash

ewwPath="$HOME/.config/eww/bar"
tmpPath="$HOME/.cache/eww/bar"

windows="
            window_workspace
            window_music 
            window_clock
            window_volume
            window_brightness 
            window_battery 
        "

toggle() {
    if [ -f $tmpPath ]; then
        rm $tmpPath
        eww -c $ewwPath close-all
    else
        touch $tmpPath
        eww -c $ewwPath open-many $windows
    fi
}

if [ "$1" == "--open-all" ]; then
    touch $tmpPath
    eww -c $ewwPath open-many $windows
elif [ "$1" == "--toggle" ]; then
    toggle
fi







