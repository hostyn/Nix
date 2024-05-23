# Antonio Sarosi
# https://youtube.com/c/antoniosarosi
# https://github.com/antoniosarosi/dotfiles

# Qtile workspaces

from libqtile.config import Key, Group
from libqtile.command import lazy
from .keys import mod, keys


# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)
# Icons: 
# nf-fa-firefox, 
# nf-fae-python, 
# nf-dev-terminal, 
# nf-fa-code, 
# nf-oct-git_merge, 
# nf-linux-docker,
# nf-mdi-image, 
# nf-mdi-layers

groups_with_keys = [
  ["   ", "e"],
  ["   ", "r"],
  [" 󰨞  ", "t"],
  ["   ", "y"],
  ["    ", "u"],
  ["    ", "i"],
  ["   ", "o"],
  ["   ", "p"],
]

groups = []

for group in groups_with_keys:
  groups.append(Group(group[0]))
  keys.extend([
    Key([mod], group[1], lazy.group[group[0]].toscreen()),
    Key([mod, "shift"], group[1], lazy.window.togroup(group[0]))
  ])
