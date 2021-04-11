#!/bin/bash

# set up the two monitors for bspwm
# NOTE This is a simplistic approach because I already know the settings I
# want to apply.
monitor=$(xrandr --query | grep 'VGA-1')
if [[ $monitor = *connected* ]]; then
    xrandr --output LVDS-1 --primary --mode 1600x900 --rotate normal --output VGA-1 --mode 1920x1080 --rotate normal --left-of LVDS-1
fi

