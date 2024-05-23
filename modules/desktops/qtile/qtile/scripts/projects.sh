#!/usr/bin/env bash

projects="$HOME/Projects"

/bin/ls $projects | xargs -i_ echo -en "_\0icon\x1ffolder\n" | rofi -dmenu -l 10 -p "" -i | xargs -i_ code $projects/_
