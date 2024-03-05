#!/bin/sh

datetime="$(date +'%Y-%m-%d %I:%M:%S %p')"
battery="$(cat /sys/class/power_supply/BAT0/capacity)"

echo " ${battery}% | $datetime"
