#!/usr/bin/env bash

players=$(playerctl -l)

mkdir $HOME/.cache/custom-scripts 2>/dev/null
lastPaused=$(/bin/cat $HOME/.cache/custom-scripts/lastPaused 2>/dev/null)
isPaused=1
# Check if the player is paused
for i in $players; do
    [[ $(playerctl -p $i status) == "Playing" ]] && isPaused=0 && break
done

###############################################################################
################################ PLAY/PAUSE ###################################
###############################################################################
if [[ $1 == "play-pause" ]]; then


# If the player is paused, unpause it
if [[ $isPaused -eq 1 ]]; then
  # If theres not a last paused player, just try to play the first one
  if [[ $lastPaused == "" ]]; then
    playerctl play
    exit 0
  # If there is a last paused player, try to play it
  else
    playerctl play -p $lastPaused 2>/dev/null
    # If the last paused player dont exist, try to play the first one instead
    [[ $? -eq 0 ]] && exit 0
    # Remove the last paused player from the cache
    echo "" > $HOME/.cache/custom-scripts/lastPaused
    playerctl play
    exit 0
  fi
fi

# If the player is playing, pause it and save the last paused player
for i in $players; do
    status=$(playerctl -p $i status)
    [[ $status == "Playing" ]] && playerctl pause -p $i && echo $i > $HOME/.cache/custom-scripts/lastPaused
done

exit 1
fi


###############################################################################
############################## NEXT/PREV/STOP #################################
###############################################################################
if [[ "next previous stop" =~ (^|[[:space:]])$1($|[[:space:]]) ]]; then


if [[ $isPaused -eq 1 ]]; then
  if [[ $lastPaused == "" ]]; then
    playerctl $1
    exit 0
  else
    playerctl $1 -p $lastPaused 2>/dev/null
    [[ $? -eq 0 ]] && exit 0
    echo "" > $HOME/.cache/custom-scripts/lastPaused
    playerctl $1
    exit 0
  fi
fi

for i in $players; do
    status=$(playerctl -p $i status)
    [[ $status == "Playing" ]] && playerctl $1 -p $i && exit 0
done

exit 1
fi
exit 1
