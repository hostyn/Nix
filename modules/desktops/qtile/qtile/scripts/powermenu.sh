#!/usr/bin/env bash

poweroff="Power Off"
reboot="Reboot"
logout="Log Out"

test+="\x20$poweroff\0icon\x1fsystem-shutdown\n"
test+=" $reboot\0icon\x1fsystem-reboot\n"
test+=" $logout\0icon\x1fsystem-log-out\n"

chosen=$(echo -en $test | rofi -dmenu -p "" -l 3 -i)

[[ "$chosen" =~ "$poweroff" ]] && poweroff && exit 0
[[ "$chosen" =~ "$reboot" ]] && reboot && exit 0
[[ "$chosen" =~ "$logout" ]] && kill -9 -1 && exit 0

exit 1







