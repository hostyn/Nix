# Antonio Sarosi
# https://youtube.com/c/antoniosarosi
# https://github.com/antoniosarosi/dotfiles

# Qtile keybindings

from libqtile.config import Key
from libqtile.command import lazy
from .path import qtile_path, user_path

mod = "mod4"

keys = [Key(key[0], key[1], *key[2:]) for key in [
    # ------------ Window Configs ------------

    # Switch between windows in current stack pane
    ([mod], "j", lazy.layout.down()),
    ([mod], "k", lazy.layout.up()),
    ([mod], "h", lazy.layout.left()),
    ([mod], "l", lazy.layout.right()),

    # Change window sizes (MonadTall)
    ([mod, "shift"], "l", lazy.layout.grow()),
    ([mod, "shift"], "h", lazy.layout.shrink()),

    # Toggle floating
    ([mod, "shift"], "f", lazy.window.toggle_floating()),

    # Toggle fullscreen
    ([], "F12", lazy.window.toggle_fullscreen()),

    # Move windows up or down in current stack
    ([mod, "shift"], "j", lazy.layout.shuffle_down()),
    ([mod, "shift"], "k", lazy.layout.shuffle_up()),

    # Toggle between different layouts as defined below
    ([mod], "Tab", lazy.next_layout()),
    ([mod, "shift"], "Tab", lazy.prev_layout()),

    # Kill window
    ([mod], "w", lazy.window.kill()),

    # Switch focus of monitors
    ([mod], "period", lazy.to_screen(0)),
    ([mod], "comma", lazy.to_screen(1)),

    # Restart Qtile
    ([mod, "control"], "r", lazy.restart()),

    ([mod, "control"], "q", lazy.shutdown()),

    # ------------ App Configs ------------

    # Menu
    ([mod], "m", lazy.spawn("rofi -show drun")),

    # Window Nav
    ([mod, "shift"], "m", lazy.spawn("rofi -show")),

    # Poweroff menu
    ([mod, "shift"], "Delete", lazy.spawn(f"{qtile_path}/scripts/powermenu.sh")),

    # Projects menu
    ([mod], "b", lazy.spawn(f"{qtile_path}/scripts/projects.sh")),

    # Chrome profile menu
    ([mod, "mod1"], "g", lazy.spawn(f"{qtile_path}/scripts/browsermenu.sh")),

    # Browser
    ([mod], "g", lazy.spawn("brave")),

    # Spotify
    ([mod], "s", lazy.spawn("spotify")),

    # File Explorer
    ([mod], "v", lazy.spawn("code")),

    # Terminal
    ([mod], "Return", lazy.spawn("alacritty")),

    # Screenshot
    ([], "Print", lazy.spawn(f"scrot -F {user_path}/Pictures/'Screenshot %d-%m-%y %H:%M.png'")),
    (["control"], "Print", lazy.spawn(f"scrot -s -F {user_path}/Pictures/'Screenshot %d-%m-%y %H:%M.png'")),

    # ------------ Hardware Configs ------------

    # Audio
    ([], "XF86AudioPlay", lazy.spawn(f"{qtile_path}/scripts/player.sh play-pause")),
    ([], "XF86AudioNext", lazy.spawn(f"{qtile_path}/scripts/player.sh next")),
    ([], "XF86AudioPrev", lazy.spawn(f"{qtile_path}/scripts/player.sh previous")),
    ([], "XF86AudioStop", lazy.spawn(f"{qtile_path}/scripts/player.sh stop")),

    ([], "XF86AudioLowerVolume", lazy.spawn(f"{qtile_path}/scripts/volume.sh down")),
    ([], "XF86AudioRaiseVolume", lazy.spawn(f"{qtile_path}/scripts/volume.sh up")),
    ([], "XF86AudioMute", lazy.spawn(f"{qtile_path}/scripts/volume.sh mute")),
    
]]
