#!/bin/sh
# Fix external monitor after suspend/resume.
# Called by /etc/systemd/system-sleep/xrandr-resume.sh; also safe to run by hand.

# Find DISPLAY and XAUTHORITY from the running dwm/X session
pid=$(pgrep -x dwm || pgrep -x Xorg || pgrep -x X)
if [ -z "$pid" ]; then
    echo "No X session found" >&2
    exit 1
fi

eval "$(cat /proc/$pid/environ | tr '\0' '\n' | grep -E '^(DISPLAY|XAUTHORITY)=' | sed 's/^/export /')"
export DISPLAY XAUTHORITY

# Wait up to 10s for the dock's outputs to come back after resume
i=0
while [ $i -lt 10 ] && ! xrandr --query | grep -v '^eDP-1 ' | grep -q ' connected '; do
    sleep 1
    i=$((i + 1))
done

# Turn off disconnected outputs that still have a mode assigned
xrandr --query | awk '/disconnected/ && / [0-9]+x[0-9]+\+/ {print $1}' | while read -r output; do
    xrandr --output "$output" --off
done

# Reset every connected external output. After resume the DP link through the
# dock can fail to come up (kernel logs "Failed to get ACT") while X still thinks
# the output is active, so turn each one off and back on to force a fresh link.
xrandr --query | awk '/^[^ ]+ connected / {print $1}' | grep -v '^eDP-1$' | while read -r output; do
    xrandr --output "$output" --off
    sleep 2
    xrandr --output "$output" --auto --right-of eDP-1
    logger -t fix-monitors "reset $output"
done
