# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook

from typing import List  # noqa: F401

import os
import subprocess

WIN = "mod4"
ALT = "mod1"
SHIFT = "shift"
CTRL = "control"

my_terminal = "alacritty"


keys = [
    # Move window focus
    Key([WIN], "h", lazy.layout.left()),
    Key([WIN], "j", lazy.layout.down()),
    Key([WIN], "k", lazy.layout.up()),
    Key([WIN], "l", lazy.layout.right()),

    Key([ALT], "Tab", lazy.layout.up()),

    # Change window size
    Key([WIN], "i", lazy.layout.grow()),
    Key([WIN], "o", lazy.layout.shrink()),
    Key([WIN], "m", lazy.layout.maximize()),
    Key([WIN], "n", lazy.layout.normalize()),

    # Move window within a layout
    Key([WIN, CTRL], "h", lazy.layout.shuffle_left()),
    Key([WIN, CTRL], "j", lazy.layout.shuffle_down()),
    Key([WIN, CTRL], "k", lazy.layout.shuffle_up()),
    Key([WIN, CTRL], "l", lazy.layout.shuffle_right()),

    # Flip layout (monadtall and monadwide)
    Key([WIN, CTRL], "space", lazy.layout.flip()),

    # Switch layouts
    Key([WIN], "Tab", lazy.next_layout()),

    # Move monitor focus
    Key([WIN], "s", lazy.to_screen(0)),
    Key([WIN], "d", lazy.to_screen(1)),
    Key([WIN], "f", lazy.to_screen(2)),

    # Start applications
    Key([ALT], "Return", lazy.spawn(my_terminal)),
    Key([ALT], "space", lazy.spawn("dmenu_run -p 'Run: '")),
    Key([ALT, CTRL], "b", lazy.spawn("firefox")),
    Key([ALT, CTRL], "m", lazy.spawn("thunderbird")),
    Key([ALT, CTRL], "f", lazy.spawn(my_terminal + " -e vifm")),
    Key([ALT, CTRL], "p", lazy.spawn("pavucontrol")),

    # Close applications
    Key([ALT], "F4", lazy.window.kill()),
    Key([WIN], "w", lazy.window.kill()),

    # Lock screen
    Key([WIN, ALT], "l", lazy.spawn("xscreensaver-command -lock")),

    # Restart/quit Qtile
    Key([WIN, CTRL], "r", lazy.restart()),
    Key([WIN, CTRL], "q", lazy.shutdown()),
]


groups = [Group(i) for i in "12345678"]

for i in groups:
    keys.extend([
        # Go to workspace x
        Key([WIN], i.name, lazy.group[i.name].toscreen()),
        # Send window to workspace x
        Key([WIN, SHIFT], i.name, lazy.window.togroup(i.name, switch_group=False)),
    ])

layout_theme = {
    "border_width": 3,
    "margin": 10,
    "border_focus": "e1acff",
    "border_normal": "333333",
    "max_ratio": 0.85,
    "min_raton": 0.25,
    "ratio": 0.5,
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Matrix(columns=2, **layout_theme),
    layout.TreeTab(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Floating(**layout_theme),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Columns(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

def init_widgets_list():
    widgets_list = [
        widget.CurrentLayout(),
        widget.GroupBox(),
        widget.Prompt(),
        widget.WindowName(),
        widget.Systray(),
        widget.Battery(),
        widget.Clock(format='%a %Y-%m-%d %H:%M'),
        widget.QuickExit(),
    ]
    return widgets_list

def init_bar():
    return bar.Bar(init_widgets_list(), 30, background="333333")


def init_screen():
    return Screen(
        top=init_bar(),
    )

screens = [
    init_screen(),
    init_screen(),
    init_screen(),
]

# Drag floating layouts.
mouse = [
    Drag([WIN], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([WIN], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([WIN], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

@hook.subscribe.startup_complete
def autostart_complete():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart_complete.sh'])

