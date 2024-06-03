#!/usr/bin/env bash

if [ -z "$NIXOS_SCREENSHOTDIR" ]; then
  echo "Environment variable NIXOS_SCREENSHOTDIR is missing"
  exit 1
fi

OUTPATH="$NIXOS_SCREENSHOTDIR/images"
FINALIMG="$OUTPATH/$(date '+%Y-%m-%dT%H-%M-%S.png')"

if [[ ! -d "$OUTPATH" ]]; then
  notify-send -u critical "$NIXOS_SCREENSHOTDIR inaccessible or $NIXOS_SCREENSHOTDIR/images missing"
  exit 1
fi

if [[ $(pgrep -c -f "screenshot.sh") -gt 1 ]]; then
  exit 0
fi

if [[ "$1" == "--satty" ]]; then
  grim -g "$(slurp -o -r -c '#ffffffff' -w 0)" - | satty --early-exit --filename - --fullscreen --output-filename "$FINALIMG"
  wl-copy < "$FINALIMG"
else
  hyprpicker -r -z & sleep 0.2
  HYPRPICKER_PID=$!
  region="$(slurp -b "#cad3f533" -c "#ffffffff" -d -w 0)"
  grim -g "$region" - | { sleep 0.2; kill $HYPRPICKER_PID; swappy -f - -o "$FINALIMG"; }
  wl-copy < "$FINALIMG"
fi