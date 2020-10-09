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

mod = "mod4"

keys = [
    # Window management
    Key(
        [mod], "j",
        lazy.layout.down(),
        desc="Move window focus down the current stack",
    ),
    Key(
        [mod], "k",
        lazy.layout.up(),
        desc="Move window focus up the current stack",
    ),
    Key(
        [mod], "h",
        lazy.layout.left(),
        desc="Move window focus to the left",
    ),
    Key(
        [mod], "l",
        lazy.layout.right(),
        desc="Move window focus to the right",
    ),
    Key(
        [mod], "e",
        lazy.to_screen(0),
        desc='Keyboard focus to monitor 1',
    ),
    Key(
        [mod], "r",
        lazy.to_screen(1),
        desc='Keyboard focus to monitor 2',
    ),
    Key(
        [mod, "shift"], "j",
        lazy.layout.shuffle_down(),
        desc="Move window down in the currentn stack",
    ),
    Key(
        [mod, "shift"], "k",
        lazy.layout.shuffle_up(),
        desc="Move window up in the current stack",
    ),
    Key(
        [mod, "shift"], "h",
        lazy.layout.swap_left(),
        desc="Move window focus ot the left",
    ),
    Key(
        [mod, "shift"], "l",
        lazy.layout.swap_right(),
        desc="Move window focus ot the right",
    ),
    Key(
        ["mod1"], "Tab",
        lazy.layout.next(),
        desc="Switch focus to next window",
    ),
    Key(
        [mod, "shift"], "space",
        lazy.layout.flip(),
        desc="Flip layout",
    ),
    Key(
        [mod, "control"], "h",
        lazy.layout.grow(),
        desc="Expand window (MonadTall)",
    ),
    Key(
        [mod, "control"], "l",
        lazy.layout.shrink(),
        desc="Shrink window (MonadTall)",
    ),
    Key(
        [mod, "control"], "n",
        lazy.layout.normalize(),
        desc="normalize window size ratios",
    ),
    Key(
        [mod, "control"], "m",
        lazy.layout.maximize(),
        desc="toggle window between minimum and maximum sizes",
    ),
    # Start applications
    Key(
        [mod], "Return",
        lazy.spawn("alacritty"),
        desc="Open terminal emulator",
    ),
    Key(
        ["mod1"], "Return",
        lazy.spawn("alacritty"),
        desc="Open terminal emulator",
    ),
    Key(
        ["mod1"], "space",
        lazy.spawn("dmenu_run -fn xtf:inconsolata:pixelsize=12 -p 'Run: '"),
        desc="Open dmenu",
    ),
    Key(
        [mod, "mod1"], "b",
        lazy.spawn("firefox"),
        desc="Open browser",
    ),
    Key(
        [mod, "mod1"], "p",
        lazy.spawn("pavucontrol"),
        desc="Open audio control",
    ),
    # Close applications
    Key(
        ["mod1"], "F4",
        lazy.window.kill(),
        desc="Close window with focus",
    ),
    Key(
        [mod], "w",
        lazy.window.kill(),
        desc="Close window with focus",
    ),
    # Layouts
    Key(
        [mod], "Tab",
        lazy.next_layout(),
        desc="Toggle between layouts",
    ),
    # Lock screen
    Key(
        [mod, "mod1"], "l",
        lazy.spawn("xscreensaver-command -lock"),
        desc="Lock screen",
    ),
    # Restart/quit Qtile
    Key(
        [mod, "control"], "r",
        lazy.restart(),
        desc="Restart Qtile",
    ),
    Key(
        [mod, "control"], "q",
        lazy.shutdown(),
        desc="Shutdown Qtile",
    ),
]


groups = [Group(i) for i in "asdfuiop"]

for i in groups:
    keys.extend([
        Key(
            [mod], i.name,
            lazy.group[i.name].toscreen(),
            desc="Switch focus to another group",
        ),
        Key(
            [mod, "shift"], i.name,
            lazy.window.togroup(i.name, switch_group=True),
            desc="Send window to another group",
        ),
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
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
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
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])

