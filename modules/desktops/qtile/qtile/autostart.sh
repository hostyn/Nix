#!/bin/sh

# Set resolution -- arandr config
#xrandr --output DVI-D-0 --off --output HDMI-0 --mode 1920x1080 --pos 0x180 --rotate normal --output DP-0 --primary --mode 2560x1440 --pos 1920x0 --rotate normal --output DP-1 --off

# Disbable blanking
xset s noblank &
xset s off &
xset -dpms

xrandr --output Virtual-1 --mode 1920x1080

# Picom
# picom --no-vsync --config $HOME/.config/qtile/config/picom.conf &

# Background
feh --bg-fill $HOME/.config/wall.jpg &

# systray volume
volumeicon &
udiskie -tna &

# polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# nm-applet
nm-applet &

gnome-keyring-daemon --start &


