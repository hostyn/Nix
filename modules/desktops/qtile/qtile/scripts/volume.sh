#!/usr/bin/env bash

# Para que funciona hace falta:
# paru -S pulseaudio-alsa pulseaudio-jack alsa-utlis

timeout=1500

## --- Mute --- ##
if [[ $1 == "mute" ]]; 
then
	muted=$(awk -F"[][]" '/Left:/ { print $4 }' <(amixer set Master toggle))
	volume=$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master) | tr "%" " ")
	[[ $muted == "on" ]] && dunstify -a Volume -u 0 "$volume%" -i $HOME/.config/qtile/scripts/icons/volume_up.png -h int:value:$volume -r 122333 -t $timeout || dunstify -a Volume -u 0 "Muted" -i $HOME/.config/qtile/scripts/icons/volume_off.png -r 122333 -t $timeout
	exit 0
fi


## --- Volume Up --- ##
if [[ $1 == "up" ]];
then
	volume=$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer set Master 5%+) | tr "%" " ")
	dunstify -a Volume -u 0 "$volume%" -i $HOME/.config/qtile/scripts/icons/volume_up.png -h int:value:$volume -r 122333 -t $timeout
	exit 0
fi


## --- Volume Down --- ##
if [[ $1 == "down" ]];
then
	volume=$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer set Master 5%-) | tr "%" " ")
	dunstify -a Volume -u 0 "$volume%" -i $HOME/.config/qtile/scripts/icons/volume_down.png -h int:value:$volume -r 122333 -t $timeout
	exit 0
fi

## --- Invalid Params --- ##
exit 1


