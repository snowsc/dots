#!/bin/sh
# Fix external monitor after suspend/resume.

# Find DISPLAY and XAUTHORITY from the running dwm/X session
pid=$(pgrep -x dwm || pgrep -x Xorg || pgrep -x X)
if [ -z "$pid" ]; then
    echo "No X session found" >&2
    exit 1
fi

eval "$(cat /proc/$pid/environ | tr '\0' '\n' | grep -E '^(DISPLAY|XAUTHORITY)=' | sed 's/^/export /')"
export DISPLAY XAUTHORITY

# Turn off disconnected outputs that still have a mode assigned
xrandr --query | awk '/disconnected/ && / [0-9]+x[0-9]+\+/ {print $1}' | while read -r output; do
    xrandr --output "$output" --off
done

# Enable connected outputs with no active mode
xrandr --query | awk '/^[^ ]+ connected / && !/ [0-9]+x[0-9]+\+/ {print $1}' | grep -v 'eDP-1' | while read -r output; do
    mode=$(xrandr --query | awk -v out="$output" '
        $0 ~ "^"out" " {found=1; next}
        found && /^\s+[0-9]+x[0-9]+/ {print $1; exit}
    ')
    if [ -n "$mode" ]; then
        xrandr --output "$output" --mode "$mode" --right-of eDP-1
    fi
done
