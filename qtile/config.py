# A customized config.py for Qtile window manager (http://www.qtile.org)
# Modified by Richard Schwalk (https://github.com/rschwalk)
#
# Inpired by: Derek Taylor (DistroTube)
# http://www.youtube.com/c/DistroTube Original Copiright text:
#
# Copyright (c) 2010 Aldo Cortesi, dequis, Randall Ma, Tycho Andersen,
# Craig Barnes, horsik, Tao Sauvage
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

import os, subprocess
import socket
from libqtile import hook
from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget

from typing import List  # noqa: F401

rsTheme = {
        'focus':       '#A75112',
        'other_focus': '#cfb017',
        'normal':        '#7d7a68',
        'foreground':  '#a6a28c',
        'background':  '#20201d',
        'text':        '#c0c0c0',
        'text_unfocus': '#7d7a68',
    }

theme = rsTheme

##### DEFINING SOME WINDOW FUNCTIONS #####

@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

##### LAUNCH APPS IN SPECIFIED GROUPS #####

def app_or_group(group, app):
    def f(qtile):
        if qtile.groupMap[group].windows:
            qtile.groupMap[group].cmd_toscreen()
        else:
            qtile.groupMap[group].cmd_toscreen()
            qtile.cmd_spawn(app)
    return f

##### KEYBINDINGS #####

def init_keys():

    mod = "mod4"
    keys = [
        # Switch between windows in current stack pane
        Key([mod], "k", lazy.layout.down()),
        Key([mod], "j", lazy.layout.up()),

        # Move windows up or down in current stack
        Key([mod, "control"], "k", lazy.layout.shuffle_down()),
        Key([mod, "control"], "j", lazy.layout.shuffle_up()),

        # Switch window focus to other pane(s) of stack
        #Key([mod], "space", lazy.layout.next()),

        # Swap panes of split stack
        #Key([mod, "shift"], "space", lazy.layout.rotate()),

        # Toggle between split and unsplit sides of stack.
        # Split = all windows displayed
        # Unsplit = 1 window displayed, like Max layout, but still with
        # multiple stack panes
        #Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
        # Open terminal
        Key(
            [mod], "Return",
            lazy.spawn(terminal)
            ),

        # Toggle between different layouts as defined below
        Key(
            [mod], "Tab",
            lazy.next_layout()
            ),
        # Kill active window
        Key(
            [mod, "shift"], "c",
            lazy.window.kill()
            ),
        # Restart Qtile
        Key(
            [mod, "control"], "r",
            lazy.restart()
            ),
        # Shutdown Qtile
        Key(
            [mod, "control"], "q",
            lazy.shutdown()
            ),
        # Lock Qtile
        Key(
            [mod, "control"], "l",
            lazy.spawn("i3lock -c 20201d")
            ),
        # Suspend Qtile
        Key(
            [mod, "control"], "x",
            lazy.spawn("/home/rschwalk/dotfiles/scripts/lock_suspend.sh")
            ),
        Key(
            [mod, ], "d",
            lazy.spawn("dmenu_run -fn 'Noto Sans Font:size=10' -nb '#002b36' -nf '#268bd2' -sb '#859900' -sf '#eee8d5' -p 'dmenu:'")
            ),
        Key([mod], "r", lazy.spawncmd()),
        # Keyboard focus screen(0)
        Key([mod], "w",
            lazy.to_screen(1)
            ),
        # Keyboard focus screen(1)
        Key([mod], "e",
            lazy.to_screen(0)
            ),
        Key(
           [mod, "shift"], "l",
           lazy.layout.grow(),                     # Grow size of current window (XmonadTall)
           lazy.layout.increase_nmaster(),         # Increase number in master pane (Tile)
           ),
        Key(
           [mod, "shift"], "h",
           lazy.layout.shrink(),                   # Shrink size of current window (XmonadTall)
           lazy.layout.decrease_nmaster(),         # Decrease number in master pane (Tile)
           ),
        Key(
           [mod, "shift"], "Left",                 # Move window to workspace to the left
           window_to_prev_group
           ),
        Key(
           [mod, "shift"], "Right",                # Move window to workspace to the right
           window_to_next_group
           ),
        Key(
           [mod], "n",
           lazy.layout.normalize()                 # Restore all windows to default size ratios
           ),
        Key(
           [mod], "m",
           lazy.layout.maximize()                  # Toggle a window between minimum and maximum sizes
           ),
        Key(
           [mod, "shift"], "KP_Enter",
           lazy.window.toggle_floating()           # Toggle floating
           ),
        Key(
           [], "XF86AudioRaiseVolume",
           lazy.spawn("amixer -q set Master 2%+")    # Volume up
           ),
        Key(
           [], "XF86AudioLowerVolume",
           lazy.spawn("amixer -q set Master 2%-")    # Volume down
           ),
        Key(
           [], "XF86AudioMute",
           lazy.spawn("amixer -q set Master toggle") # Mute volume
           ),
    ]

    return keys


##### BAR COLORS #####

def init_colors():
    solarized = [["#002b36", "#002b36"], # panel background
                 ["#859900", "#859900"], # green: background for current screen tab
                 ["#eee8d5", "#eee8d5"], # font color for group names
                 ["#073642", "#073642"], # background color for layout widget
                 ["#073642", "#073642"], # background for other screen tabs
                 ["#839496", "#839496"], # darker font color for inactive items
                 ["#d73737", "#d73737"],
                 ["#268bd2", "#268bd2"], # blue
                 ["#9CC4FF", "#9CC4FF"],
                 ["#002b36", "#002b36"],
                 ["#002b36", "#002b36"]]

    atelierdune =   [["#20201d", "#20201d"], # 0 panel background
                     ["#cfb017", "#cfb017"], # 1 current screen tab
                     ["#20201d", "#20201d"], # 2 font color for group names
                     ["#20201d", "#20201d"], # 3 border color for layout widget
                     ["#6684e1", "#6684e1"], # 4 border for other screen tabs
                     ["#7d7a68", "#7d7a68"], # 5 darker font color for inactive items
                     ["#d73737", "#d73737"], # 6 widget font color
                     ["#60ac39", "#60ac39"], # 7 active window border
                     ["#6684e1", "#6684e1"]] # 8 widget symbol

    return atelierdune

##### GROUPS #####

def init_group_names():
    return [("ONE", {'layout': 'monadtall'}),
            ("TWO", {'layout': 'monadtall'}),
            ("THREE", {'layout': 'monadtall'}),
            ("FOUR", {'layout': 'monadtall'}),
            ("FIVE", {'layout': 'monadtall'}),
            ("SIX", {'layout': 'monadtall'}),
            ("SEVEN", {'layout': 'monadtall'}),
            ("EIGHT", {'layout': 'monadtall'})]

def init_groups():
    return [Group(name, **kwargs) for name, kwargs in group_names]

##### LAYOUTS #####
def init_floating_layout():
    return layout.Floating(border_focus="#3B4022")

def init_layout_theme():
    return {"border_width": 2,
            "margin": 4,
            "border_focus": colors[7][0],
            "border_normal": colors[5][0]
           }

def init_border_args():
    return {"border_width": 2}

def init_layouts():
    return [layout.Max(**layout_theme),
            layout.MonadTall(**layout_theme),
            layout.MonadWide(**layout_theme),
            layout.Bsp(**layout_theme),
            #layout.TreeTab(
            #    font = "Noto Sans ",
            #    fontsize = 10,
            #    sections = ["FIRST", "SECOND"],
            #    section_fontsize = 11,
            #    bg_color = "141414",
            #    active_bg = "90C435",
            #    active_fg = "000000",
            #    inactive_bg = "384323",
            #    inactive_fg = "a0a0a0",
            #    padding_y = 5,
            #    section_top = 10,
            #    panel_width = 320,
            #    **layout_theme
            #    ),
            layout.Slice(side="left", width=192, name="gimp", role="gimp-toolbox",
                fallback=layout.Slice(side="right", width=256, role="gimp-dock",
                fallback=layout.Stack(num_stacks=1, **border_args))),
            #layout.Stack(stacks=2, **layout_theme),
            #layout.Columns(**layout_theme),
            #layout.RatioTile(**layout_theme),
            #layout.VerticalTile(**layout_theme),
            #layout.Tile(shift_windows=True, **layout_theme),
            #layout.Matrix(**layout_theme),
            #layout.Zoomy(**layout_theme),
            layout.Floating(**layout_theme)]



##### WIDGETS #####

def init_widget_defaults():
    return dict(font="Noto Sans Mono",
            fontsize = 11,
            padding = 2,
            foreground = colors[7],
            background=colors[0])

def init_widgets_list():
    prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list = [
               widget.Sep(
                        linewidth = 0,
                        padding = 6,
                        foreground = colors[1],
                        background = colors[0]
                        ),
               widget.GroupBox(font="Noto Sans Bold",
                        fontsize = 9,
                        margin_y = 0,
                        margin_x = 0,
                        padding_y = 5,
                        padding_x = 5,
                        borderwidth = 3,
                        active = colors[6],
                        inactive = colors[5],
                        rounded = True,
                        highlight_method = "border",
                        this_current_screen_border = colors[1],
                        this_screen_border = colors [4],
                        other_current_screen_border = colors[5],
                        other_screen_border = colors[5],
                        foreground = colors[2],
                        background = colors[0]
                        ),
               widget.Prompt(
                        prompt=prompt,
                        font="Noto Sans Mono",
                        padding=10,
                        foreground = colors[3],
                        background = colors[1]
                        ),
               widget.Sep(
                        linewidth = 2,
                        padding = 10,
                        foreground = colors[1],
                        background = colors[0]
                        ),
               widget.TextBox(
                        font="Noto Sans Bold",
                        text=" Layout:",
                        padding = 5,
                        foreground=colors[8],
                        background=colors[0],
                        fontsize=14
                        ),
               widget.CurrentLayout(
                        fontsize=12,
                        foreground = colors[6],
                        background = colors[0],
                        padding = 5
                        ),
               widget.Sep(
                        linewidth = 2,
                        padding = 10,
                        foreground = colors[1],
                        background = colors[0]
                        ),
               widget.WindowName(font="Noto Sans ",
                        fontsize = 12,
                        foreground = colors[6],
                        background = colors[0],
                        padding = 5
                        ),
               widget.Sep(
                        linewidth = 2,
                        padding = 10,
                        foreground = colors[1],
                        background = colors[0]
                        ),
               widget.Systray(
                        background=colors[0],
                        padding = 5
                        ),
               widget.Sep(
                        linewidth = 2,
                        padding = 10,
                        foreground = colors[1],
                        background = colors[0]
                        ),
               widget.TextBox(
                        font="Noto Sans Bold",
                        text=" Net:",
                        foreground=colors[8],
                        background=colors[0],
                        padding = 0,
                        fontsize=14
                        ),
               widget.Net(
                        interface = "enp27s0",
                        foreground = colors[6],
                        background = colors[0],
                        padding = 5
                        ),
               widget.Sep(
                        linewidth = 2,
                        padding = 10,
                        foreground = colors[1],
                        background = colors[0]
                        ),
               widget.TextBox(
                        font="Noto Sans Bold",
                        text=" Vol.:",
                        padding = 5,
                        foreground=colors[8],
                        background=colors[0],
                        fontsize=14
                        ),
               widget.Volume(
                        foreground = colors[6],
                        background = colors[0],
                        padding = 5
                       ),
               #widget.Sep(
               #         linewidth = 2,
               #         padding = 10,
               #         foreground = colors[1],
               #         background = colors[0]
               #         ),
               #widget.TextBox(
               #         font="Noto Sans Bold",
               #         text=" ♫",
               #         padding = 5,
               #         foreground=colors[8],
               #         background=colors[0],
               #         fontsize=14
               #         ),
               #widget.Cmus(
               #         max_chars = 40,
               #         update_interval = 0.5,
               #         foreground=colors[6],
               #         background = colors[0]
               #         ),
               widget.Sep(
                        linewidth = 2,
                        padding = 10,
                        foreground = colors[1],
                        background = colors[0]
                        ),
               widget.TextBox(
                        font="Noto Sans Bold",
                        text=" T:",
                        foreground=colors[8],
                        background=colors[0],
                        padding = 5,
                        fontsize=14
                        ),
               widget.Clock(
                        font="Noto Sans Bold",
                        foreground = colors[6],
                        background = colors[0],
                        format="%A, %B %d - %H:%M"
                        ),
               widget.Sep(
                        linewidth = 2,
                        padding = 5,
                        foreground = colors[1],
                        background = colors[0]
                        ),
    #        widget.GroupBox(foreground=theme["text"],
    #            active=theme["text"],
    #            inactive=theme["text_unfocus"],
    #            background=theme["background"],
    #            this_current_screen_border=theme["focus"],
    #            this_screen_border=theme["normal"],
    #            other_current_screen_border=theme["other_focus"]),
    #        widget.Prompt(),
    #        # widget.WindowName(),
    #        widget.Spacer(length=bar.STRETCH),
    #        widget.Systray(),
    #        widget.TextBox("🕑", foreground=theme["foreground"]),
    #        widget.Clock(format='%Y-%m-%d %a %H:%M', foreground=theme["foreground"]),
            ]

    return widgets_list

##### SCREENS ##### (TRIPLE MONITOR SETUP)

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1                       # Slicing removes unwanted widgets on Monitors 1,3

def init_widgets_screen2():
    orig_list = init_widgets_list()
    widgets_screen2 = orig_list[:2]
    widgets_screen2 += orig_list[3:7]
    return widgets_screen2

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=0.95, size=22, background=colors[0])),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=0.95, size=22, background=colors[0])),
            ]

##### FLOATING WINDOWS #####

@hook.subscribe.client_new
def floating(window):
    floating_types = ['notification', 'toolbar', 'splash', 'dialog']
    transient = window.window.get_wm_transient_for()
    if window.window.get_wm_type() in floating_types or transient:
        window.floating = True

def init_mouse():
    return [Drag([mod], "Button1", lazy.window.set_position_floating(),      # Move floating windows
                 start=lazy.window.get_position()),
            Drag([mod], "Button3", lazy.window.set_size_floating(),          # Resize floating windows
                 start=lazy.window.get_size()),
            Click([mod, "shift"], "Button1", lazy.window.bring_to_front())]  # Bring floating window to front

##### SETUP #####
if __name__ in ["config", "__main__"]:
    mod = "mod4"                                     # Sets mod key to SUPER/WINDOWS
    terminal = "alacritty"
    myConfig = "/home/rschwalk/.config/qtile/config.py"    # Qtile config file location

    colors = init_colors()
    keys = init_keys()
    mouse = init_mouse()
    group_names = init_group_names()
    groups = init_groups()
    floating_layout = init_floating_layout()
    layout_theme = init_layout_theme()
    border_args = init_border_args()
    layouts = init_layouts()
    screens = init_screens()
    widget_defaults = init_widget_defaults()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()

##### GROUP KEYBINDINGS #####
for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))          # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))   # Send current window to another group

##### STARTUP APPLICATIONS #####

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
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

