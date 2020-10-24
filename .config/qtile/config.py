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

# -----------------------------------------------------------------------------
# imports
# -----------------------------------------------------------------------------

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook

from typing import List  # noqa: F401

import os
import subprocess



# -----------------------------------------------------------------------------
# constants
# -----------------------------------------------------------------------------

WIN = "mod4"
ALT = "mod1"
SHIFT = "shift"
CTRL = "control"

HOME = os.path.expanduser('~')


# -----------------------------------------------------------------------------
# global veriables
# -----------------------------------------------------------------------------

my_terminal = "alacritty"

colors = {
    "background":    {"normal": "#083f4d", "bright": "#0c677e"},
    "foreground":    {"normal": "#839496", "bright": "#eeeeee"},
    "black":         {"normal": "#000000", "bright": "#222222"},
    "red":           {"normal": "#dc322f", "bright": "#df5017"},
    "green":         {"normal": "#169921", "bright": "#1aba27"},
    "yellow":        {"normal": "#b58900", "bright": "#daa400"},
    "blue":          {"normal": "#268bd2", "bright": "#2a9dea"},
    "magenta":       {"normal": "#da54da", "bright": "#fe61fe"},
    "cyan":          {"normal": "#26958c", "bright": "#2db0a5"},
    "white":         {"normal": "#888888", "bright": "#ffffff"},
    "border_focus":  {"normal": "#268bd2", "bright": "#2a9dea"},
    "border_normal": {"normal": "#555555", "bright": "#888888"},
}


# -----------------------------------------------------------------------------
# configuration
# -----------------------------------------------------------------------------

# from default config file
# -----------------------------------------------------------------------------

auto_fullscreen = True
focus_on_window_activation = "smart"

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


# keys
# -----------------------------------------------------------------------------

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

    Key([WIN, CTRL, SHIFT], "m", lazy.window.toggle_fullscreen()),
    Key([WIN, CTRL, SHIFT], "f", lazy.window.toggle_floating()),

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
    Key([ALT], "Return", lazy.spawn(
        my_terminal + " --working-directory " + HOME)),
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

# groups
# -----------------------------------------------------------------------------

group_configs = [
    ("mail", {"layout": "monadtall"}),
    ("web", {"layout": "monadtall"}),
    ("wapp", {"layout": "monadtall"}),
    ("dev_1", {"layout": "monadtall"}),
    ("dev_2", {"layout": "monadtall"}),
    ("dev_3", {"layout": "monadtall"}),
    ("free_1", {"layout": "monadtall"}),
    ("free_2", {"layout": "monadtall"}),
    ("free_3", {"layout": "monadtall"}),
]

groups = [Group(name, **kwargs) for name, kwargs in group_configs]

for i, (name, kwargs) in enumerate(group_configs, 1):
    keys.extend([
        # Go to workspace x
        Key([WIN], str(i), lazy.group[name].toscreen(toggle=False)),
        # Send window to workspace x
        Key([WIN, SHIFT], str(i), lazy.window.togroup(name, switch_group=False)),
    ])

# Show certain set of workspaces on the three monitors
keys.append(
    Key([WIN], "x",
        lazy.to_screen(0), lazy.group[group_configs[0][0]].toscreen(toggle=False),
        lazy.to_screen(1), lazy.group[group_configs[1][0]].toscreen(toggle=False),
        lazy.to_screen(2), lazy.group[group_configs[2][0]].toscreen(toggle=False),
        lazy.to_screen(1),
    )
)
keys.append(
    Key([WIN], "c",
        lazy.to_screen(0), lazy.group[group_configs[3][0]].toscreen(toggle=False),
        lazy.to_screen(1), lazy.group[group_configs[4][0]].toscreen(toggle=False),
        lazy.to_screen(2), lazy.group[group_configs[5][0]].toscreen(toggle=False),
        lazy.to_screen(1),
    )
)
keys.append(
    Key([WIN], "v",
        lazy.to_screen(0), lazy.group[group_configs[6][0]].toscreen(toggle=False),
        lazy.to_screen(1), lazy.group[group_configs[7][0]].toscreen(toggle=False),
        lazy.to_screen(2), lazy.group[group_configs[8][0]].toscreen(toggle=False),
        lazy.to_screen(1),
    )
)


# layouts
# -----------------------------------------------------------------------------

layout_theme = {
    "border_focus": colors["border_focus"]["bright"],
    "border_normal": colors["border_normal"]["normal"],
    "border_width": 3,
    "margin": 10,
    "ratio": 0.5,
    "max_ratio": 0.85,
    "min_raton": 0.25,
    "new_at_current": False,
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Matrix(columns=2, **layout_theme),
    layout.Floating(**layout_theme),
]

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
    {'wmclass': 'gitk' },
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])


# screens
# -----------------------------------------------------------------------------

def init_widgets(primary_monitor=False):
    widgets = []
    widgets.append(widget.Sep(
        linewidth = 0,
        padding = 8,
    ))
    widgets.append(widget.GroupBox(
        active=colors["foreground"]["bright"],
        inactive=colors["foreground"]["normal"],
        this_screen_border=colors["border_normal"]["bright"],
        this_current_screen_border=colors["border_focus"]["bright"],
        other_screen_border=colors["border_normal"]["normal"],
        other_current_screen_border=colors["border_normal"]["normal"],
        margin=3,
    ))
    widgets.append(widget.Sep(
        linewidth = 2,
        padding = 8,
        foreground = colors["foreground"]["normal"],
    ))
    widgets.append(widget.CurrentLayout(
        foreground=colors["foreground"]["normal"],
    ))
    widgets.append(widget.Sep(
        linewidth = 2,
        padding = 8,
        foreground = colors["foreground"]["normal"],
    ))
    widgets.append(widget.WindowName(
        foreground = colors["foreground"]["bright"],
    ))

    if primary_monitor == True:
        widgets.append(widget.Systray())
        widgets.append(widget.Sep(
            linewidth = 2,
            padding = 8,
            foreground = colors["foreground"]["normal"],
        ))

    widgets.append(widget.Battery(
        foreground = colors["foreground"]["normal"],
        low_foreground = colors["red"]["bright"],
        low_percentage = 5.0,
        update_interval = 60,
        full_char = "",
        charge_char = "+",
        discharge_char = "-",
        empty_char = "",
        format = "{char} {percent:02.1%}",
    ))
    widgets.append(widget.Sep(
        linewidth = 2,
        padding = 8,
        foreground = colors["foreground"]["normal"],
    ))
    widgets.append(widget.TextBox(
        text="Vol:",
        foreground=colors["foreground"]["normal"],
    ))
    widgets.append(widget.PulseVolume(
        foreground=colors["foreground"]["normal"]
    ))
    widgets.append(widget.Sep(
        linewidth = 2,
        padding = 8,
        foreground = colors["foreground"]["normal"],
    ))
    widgets.append(widget.Clock(
        foreground=colors["foreground"]["normal"],
        format='%Y-%m-%d %H:%M',
    ))
    widgets.append(widget.Sep(
        linewidth = 0,
        padding = 8,
    ))

    return widgets


def init_bar(primary_monitor=False):
    return bar.Bar(
        init_widgets(primary_monitor),
        30,
        background=colors["background"]["normal"],
    )


def init_screen(primary_monitor=False):
    return Screen(
        top=init_bar(primary_monitor),
    )


screens = [
    init_screen(primary_monitor=False),
    init_screen(primary_monitor=True),
    init_screen(primary_monitor=False),
]


# -----------------------------------------------------------------------------
# other stuff
# -----------------------------------------------------------------------------

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


# -----------------------------------------------------------------------------
# hooks
# -----------------------------------------------------------------------------

@hook.subscribe.startup_once
def autostart_complete():
    subprocess.call([HOME + '/.config/qtile/autostart_once.sh'])


@hook.subscribe.startup_complete
def autostart_complete():
    subprocess.call([HOME + '/.config/qtile/autostart_complete.sh'])

