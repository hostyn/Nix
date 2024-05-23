# Qtile Config File
# http://www.qtile.org/

# Antonio Sarosi
# https://youtube.com/c/antoniosarosi
# https://github.com/antoniosarosi/dotfiles


from libqtile import hook

from settings.keys import mod, keys
from settings.groups import groups
from settings.layouts import layouts, floating_layout
from settings.widgets import widget_defaults, extension_defaults
from settings.screens import screens
from settings.mouse import mouse
from settings.path import qtile_path

from os import path
import subprocess


@hook.subscribe.startup_once
def autostart():
    subprocess.call([path.join(qtile_path, 'autostart.sh')])

@hook.subscribe.client_new
def floating_dialogs(window):
    dialog = window.window.get_wm_type() == 'dialog'
    popup = window.window.get_wm_window_role() == 'pop-up'
    transient = window.window.get_wm_transient_for()
    if dialog or transient or popup:
        window.floating = True


auto_fullscreen = True
bring_front_click = False
cursor_warp = True
dgroups_key_binder = None
dgroups_app_rules = []
focus_on_window_activation = 'urgent'
follow_mouse_focus = True
wmname = 'LG3D'

main = None
