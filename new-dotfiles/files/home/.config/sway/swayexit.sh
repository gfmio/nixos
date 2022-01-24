#!/bin/bash

function lock {
    # swaylock --ignore-empty-password --show-failed-attempts -f -e -i /home/gfmio/Pictures/wallpaper.png -s fill;
    exec loginctl lock-session;
}

case "$1" in
    lock)
        lock
        ;;
    logout)
        swaymsg exit
        ;;
    suspend)
        lock && systemctl suspend
        ;;
    reboot)
        systemctl reboot
        ;;
    poweroff)
        systemctl poweroff
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|reboot|poweroff}"
        exit 2
esac

exit 0
