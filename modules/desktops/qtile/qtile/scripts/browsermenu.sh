#!/usr/bin/env bash

icon="\0icon\x1fbrave\n"
hostyn96="HOSTYN96"
inothy="INOTHY"
r3="R3"
ua="UA"
incognito="Incognito"

options="\x20$hostyn96$icon $inothy$icon $r3$icon $ua$icon $incognito$icon"

chosen=$(echo -en $options | rofi -dmenu -p "" -l 4 -i)

[[ "$chosen" =~ "$hostyn96" ]] && brave --profile-directory="Default" && exit 0
[[ "$chosen" =~ "$inothy" ]] && brave --profile-directory="Profile 1" && exit 0
[[ "$chosen" =~ "$r3" ]] && brave --profile-directory="Profile 2" && exit 0
[[ "$chosen" =~ "$ua" ]] && brave --profile-directory="Profile 3" && exit 0
[[ "$chosen" =~ "$incognito" ]] && brave --profile-directory="Default" --incognito && exit 0

exit 1

