#!/usr/bin/env bash

CONFIG_FILES="$HOME/.config/waybar/config $HOME/.config/waybar/style.css"

trap "killall .waybar-wrapped" EXIT

while true; do
  waybar &
  inotifywait -e create,modify $CONFIG_FILES
  killall .waybar-wrapped
done