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
        Key([mod], "j", lazy.layout.down()),
        Key([mod], "k", lazy.layout.up()),
        Key([mod], "h", lazy.layout.left()),
        Key([mod], "l", lazy.layout.right()),
        Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
        Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
        Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
        Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
        Key([mod, "mod1"], "j", lazy.layout.flip_down()),
        Key([mod, "mod1"], "k", lazy.layout.flip_up()),
        Key([mod, "mod1"], "h", lazy.layout.flip_left()),
        Key([mod, "mod1"], "l", lazy.layout.flip_right()),
        Key([mod, "control"], "j", lazy.layout.grow_down()),
        Key([mod, "control"], "k", lazy.layout.grow_up()),
        Key([mod, "control"], "h", lazy.layout.grow_left()),
        Key([mod, "control"], "l", lazy.layout.grow_right()),
        Key([mod, "shift"], "n", lazy.layout.normalize()),
        Key([mod], "space", lazy.layout.toggle_split()),

        # Switch between windows in current stack pane
        #Key([mod], "j", lazy.layout.down()),
        #Key([mod], "k", lazy.layout.up()),

        # Move windows up or down in current stack
        #Key([mod, "control"], "j", lazy.layout.shuffle_down()),
        #Key([mod, "control"], "k", lazy.layout.shuffle_up()),

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
            [mod, "control"], "p",
            lazy.spawn("i3lock -c 1d1f21")
            ),
        # Suspend Qtile
        Key(
            [mod, "control"], "x",
            lazy.spawn("/home/rschwalk/dotfiles/scripts/lock_suspend.sh")
            ),
        Key(
            [mod, ], "d",
            lazy.spawn("dmenu_run -fn 'Source Code Pro:size=12' -nb '#1d1f21' -nf '#b5bd68' -sb '#81a2be' -sf '#1d1f21' -p 'dmenu:'")
            ),
        Key([mod], "r", lazy.spawncmd()),
        Key(
            [mod], "F5",
            lazy.spawn("firefox")
            ),
        Key(
            [mod], "F6",
            lazy.spawn("thunar")
            ),
        Key(
            [mod], "F11",
            lazy.spawn("rofi -show run -fullscreen")
            ),
        Key(
            [mod], "F12",
            lazy.spawn("rofi -show run")
            ),
        Key(
            [mod, "shift"], "F12",
            lazy.spawn("rofi -show window")
            ),
        # Keyboard focus screen(0)
        Key([mod], "w",
            lazy.to_screen(1)
            ),
        # Keyboard focus screen(1)
        Key([mod], "e",
            lazy.to_screen(0)
            ),
        #Key(
        #   [mod, "shift"], "l",
        #   lazy.layout.grow(),                     # Grow size of current window (XmonadTall)
        #   lazy.layout.increase_nmaster(),         # Increase number in master pane (Tile)
        #   ),
        #Key(
        #   [mod, "shift"], "h",
        #   lazy.layout.shrink(),                   # Shrink size of current window (XmonadTall)
        #   lazy.layout.decrease_nmaster(),         # Decrease number in master pane (Tile)
        #   ),
        Key(
           [mod, "shift"], "Left",                 # Move window to workspace to the left
           window_to_prev_group
           ),
        Key(
           [mod, "shift"], "Right",                # Move window to workspace to the right
           window_to_next_group
           ),
        #Key(
        #   [mod], "n",
        #   lazy.layout.normalize()                 # Restore all windows to default size ratios
        #   ),
        Key(
           [mod], "m",
           lazy.layout.maximize()                  # Toggle a window between minimum and maximum sizes
           ),
        Key(
           [mod, "shift"], "f",
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
    solarized_dark =    [["#002b36", "#002b36"], # 0 panel background
                         ["#859900", "#859900"], # 1 current screen tab
                         ["#eee8d5", "#eee8d5"], # 2 font color for group names
                         ["#b58900", "#b58900"], # 3 border color for layout widget
                         ["#268bd2", "#268bd2"], # 4 border for other screen tabs
                         ["#839496", "#839496"], # 5 darker font color for inactive items
                         ["#839496", "#839496"], # 6 widget font color
                         ["#b58900", "#b58900"], # 7 active window border
                         ["#268bd2", "#268bd2"], # 8 widget symbol
                         ["#d33682", "#d33682"]] # 9 widget symbol


    tomorrow_night =    [["#1d1f21", "#1d1f21"], # 0 panel background
                         ["#b5bd68", "#b5bd68"], # 1 current screen tab
                         ["#f0c674", "#f0c674"], # 2 border color for layout widget
                         ["#b5bd68", "#b5bd68"], # 3 font color for group names
                         ["#81a2be", "#81a2be"], # 4 border for other screen tabs
                         ["#c5c8c6", "#c5c8c6"], # 5 darker font color for inactive items
                         ["#c5c8c6", "#c5c8c6"], # 6 widget font color
                         ["#b5bd68", "#b5bd68"], # 7 active window border
                         ["#81a2be", "#81a2be"], # 8 widget symbol
                         ["#8abeb7", "#8abeb7"]] # 9 active tab on inactive screen

    return tomorrow_night

##### GROUPS #####

def init_group_names():
    return [("I", {'layout': 'bsp'}),
            ("II", {'layout': 'bsp'}),
            ("III", {'layout': 'bsp'}),
            ("IV", {'layout': 'bsp'}),
            ("V", {'layout': 'bsp'}),
            ("VI", {'layout': 'bsp'}),
            ("VII", {'layout': 'bsp'}),
            ("VIII", {'layout': 'bsp'}),
            ("IX", {'layout': 'bsp'})]

def init_groups():
    return [Group(name, **kwargs) for name, kwargs in group_names]

##### LAYOUTS #####
def init_floating_layout():
    floating_layout = layout.Floating(float_rules=[
        {"role": "EventDialog"},
        {"role": "Msgcompose"},
        {"role": "Preferences"},
        {"role": "pop-up"},
        {"role": "prefwindow"},
        {"role": "task_dialog"},
        {"wname": "Search Dialog"},
        {"wname": "Preferences"},
        {"wname": "File Transfer"},
        {"wname": 'confirm'},
        {"wmclass": 'dialog'},
        {"wmclass": 'download'},
        {"wmclass": 'error'},
        {"wmclass": 'file_progress'},
        {"wmclass": 'notification'},
        {"wmclass": 'splash'},
        {"wmclass": 'toolbar'},
        {"wmclass": 'confirmreset'},
        {"wmclass": 'makebranch'},
        {"wmclass": 'maketag'},
        {"wmclass": "notify"},
        {"wmclass": "Lxappearance"},
        {"wmclass": "Nitrogen"},
        {"wmclass": "Pavucontrol"},
        {"wmclass": "nvidia-settings"},
        {"wmclass": 'ssh-askpass'},
        {"wmclass": 'MIX_TARGET=host, app = :home_display'},
    ],
    border_focus=colors[7][0]
    )
    return floating_layout

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
            #layout.Stack(stacks=2, **layout_theme),
            #layout.Columns(**layout_theme),
            layout.RatioTile(**layout_theme),
            #layout.VerticalTile(**layout_theme),
            layout.Tile(shift_windows=True, **layout_theme),
            #layout.Matrix(**layout_theme),
            #layout.Zoomy(**layout_theme),
            layout.Floating(**layout_theme)]



##### WIDGETS #####

def init_widget_defaults():
    return dict(font="Noto Sans Mono Regular",
            fontsize = 11,
            padding = 3,
            foreground = colors[7],
            background=colors[0])

def init_widgets_list():
    label_font_size = 14
    widget_font_size = 12
    prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list = [
               widget.Sep(
                        linewidth = 0,
                        padding = 6,
                        foreground = colors[1],
                        ),
               widget.GroupBox(
                        font="Source Code Pro",
                        fontsize = 10,
                        margin_y = 5,
                        margin_x = 0,
                        padding_y = 5,
                        padding_x = 5,
                        borderwidth = 3,
                        active = colors[3],
                        inactive = colors[5],
                        highlight_color = colors[0],
                        rounded = True,
                        highlight_method = "line",
                        this_current_screen_border = colors[1],
                        this_screen_border = colors[9],
                        other_current_screen_border = colors[5],
                        other_screen_border = colors[4],
                        foreground = colors[2],
                        ),
               widget.Prompt(
                        prompt=prompt,
                        font="Noto Sans Mono Regular",
                        fontsize = widget_font_size,
                        padding=10,
                        foreground = colors[3],
                        background = colors[1]
                        ),
               widget.Sep(
                        linewidth = 2,
                        padding = 10,
                        foreground = colors[1],
                        ),
               widget.TextBox(
                        font="Noto Sans Mono Bold",
                        text=" Layout:",
                        foreground=colors[8],
                        fontsize=label_font_size
                        ),
               widget.CurrentLayout(
                        fontsize=widget_font_size,
                        foreground = colors[6],
                        ),
               widget.Sep(
                        linewidth = 2,
                        padding = 10,
                        foreground = colors[1],
                        ),
               widget.WindowName(
                        font="Noto Sans Mono Regular",
                        fontsize = widget_font_size,
                        foreground = colors[6],
                        ),
               widget.Sep(
                        linewidth = 2,
                        padding = 10,
                        foreground = colors[1],
                        ),
               widget.Systray(
                        ),
               widget.Sep(
                        linewidth = 2,
                        padding = 10,
                        foreground = colors[1],
                        ),
               #widget.TextBox(
               #         font="Noto Sans Mono Bold",
               #         text="CPU:",
               #         foreground=colors[8],
               #         fontsize=label_font_size
               #         ),
               #widget.CPU(
               #         font="Noto Sans Mono Regular",
               #         fontsize = widget_font_size,
               #         foreground = colors[6],
               #        ),
               #widget.Sep(
               #         linewidth = 2,
               #         padding = 10,
               #         foreground = colors[1],
               #         ),
               widget.TextBox(
                        font="Noto Sans Mono Bold",
                        text="Mem.:",
                        foreground=colors[8],
                        fontsize=label_font_size
                        ),
               widget.Memory(
                        font="Noto Sans Mono Regular",
                        fontsize = widget_font_size,
                        foreground = colors[6],
                       ),
               widget.Sep(
                        linewidth = 2,
                        padding = 10,
                        foreground = colors[1],
                        ),
               widget.TextBox(
                        font="Noto Sans Mono Bold",
                        text="Net:",
                        foreground=colors[8],
                        fontsize=label_font_size
                        ),
               widget.Net(
                        font="Noto Sans Mono Regular",
                        fontsize = widget_font_size,
                        interface = "enp27s0",
                        foreground = colors[6],
                        ),
               widget.Sep(
                        linewidth = 2,
                        padding = 10,
                        foreground = colors[1],
                        ),
               widget.TextBox(
                        font="Noto Sans Mono Bold",
                        text="Vol.:",
                        foreground=colors[8],
                        fontsize=label_font_size
                        ),
               widget.Volume(
                        font="Noto Sans Mono Regular",
                        fontsize = widget_font_size,
                        foreground = colors[6],
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
                        ),
               widget.TextBox(
                        font="Noto Sans Mono Bold",
                        text="T:",
                        foreground=colors[8],
                        padding = 5,
                        fontsize=label_font_size
                        ),
               widget.Clock(
                        font="Noto Sans Mono Bold",
                        fontsize = widget_font_size,
                        foreground = colors[6],
                        format="%A, %B %d - %H:%M"
                        ),
               widget.Sep(
                        linewidth = 2,
                        padding = 5,
                        foreground = colors[1],
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
    widgets_screen2 += orig_list[3:9]
    widgets_screen2 += orig_list[-3:]
    return widgets_screen2

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=0.95, size=22, background=colors[0])),
            #Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=0.95, size=22, background=colors[0])),
            ]

##### FLOATING WINDOWS #####

@hook.subscribe.client_new
def floating(window):
    floating_types = ['notification', 'toolbar', 'splash', 'dialog', 'app']
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
   # widgets_screen2 = init_widgets_screen2()

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

