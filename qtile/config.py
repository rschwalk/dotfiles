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

import os
import socket
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal


def init_colors():
    solarized_dark =    [["#002b36", "#002b36"],  # 0 panel background
                         ["#859900", "#859900"],  # 1 current screen tab
                         ["#eee8d5", "#eee8d5"],  # 2 font color for group names
                         ["#b58900", "#b58900"],  # 3 border color for layout widget
                         ["#268bd2", "#268bd2"],  # 4 border for other screen tabs
                         ["#839496", "#839496"],  # 5 darker font color for inactive items
                         ["#839496", "#839496"],  # 6 widget font color
                         ["#b58900", "#b58900"],  # 7 active window border
                         ["#268bd2", "#268bd2"],  # 8 widget symbol
                         ["#d33682", "#d33682"]]  # 9 widget symbol


    tomorrow_night =    [["#1d1f21", "#1d1f21"],  # 0 panel background
                         ["#b5bd68", "#b5bd68"],  # 1 current screen tab
                         ["#f0c674", "#f0c674"],  # 2 border color for layout widget
                         ["#b5bd68", "#b5bd68"],  # 3 font color for group names
                         ["#81a2be", "#81a2be"],  # 4 border for other screen tabs
                         ["#c5c8c6", "#c5c8c6"],  # 5 darker font color for inactive items
                         ["#c5c8c6", "#c5c8c6"],  # 6 widget font color
                         ["#b5bd68", "#b5bd68"],  # 7 active window border
                         ["#81a2be", "#81a2be"],  # 8 widget symbol
                         ["#8abeb7", "#8abeb7"]]  # 9 active tab on inactive screen

    return tomorrow_night


def init_keys():
    return [
        # A list of available commands that can be bound to keys can be found
        # at https://docs.qtile.org/en/latest/manual/config/lazy.html
        # Switch between windows
        Key(
            [mod], "h",
            lazy.layout.left(),
            desc="Move focus to left"),
        Key(
            [mod], "l",
            lazy.layout.right(),
            desc="Move focus to right"),
        Key(
            [mod], "j",
            lazy.layout.down(),
            desc="Move focus down"),
        Key(
            [mod], "k",
            lazy.layout.up(),
            desc="Move focus up"),
        Key(
            [mod], "space",
            lazy.layout.next(),
            desc="Move window focus to other window"),
        # Move windows between left/right columns or move up/down in current stack.
        # Moving out of range in Columns layout will create new column.
        Key(
            [mod, "shift"], "h",
            lazy.layout.shuffle_left(),
            desc="Move window to the left"),
        Key(
            [mod, "shift"], "l",
            lazy.layout.shuffle_right(),
            desc="Move window to the right"),
        Key(
            [mod, "shift"], "j",
            lazy.layout.shuffle_down(),
            desc="Move window down"),
        Key(
            [mod, "shift"], "k",
            lazy.layout.shuffle_up(),
            desc="Move window up"),
        # Grow windows. If current window is on the edge of screen and direction
        # will be to screen edge - window would shrink.
        Key(
            [mod, "control"], "h",
            lazy.layout.grow_left(),
            desc="Grow window to the left"),
        Key(
            [mod, "control"], "l",
            lazy.layout.grow_right(),
            desc="Grow window to the right"),
        Key(
            [mod, "control"], "j",
            lazy.layout.grow_down(),
            desc="Grow window down"),
        Key(
            [mod, "control"], "k",
            lazy.layout.grow_up(),
            desc="Grow window up"),
        Key(
            [mod], "n",
            lazy.layout.normalize(),
            desc="Reset all window sizes"),
        # Toggle between split and unsplit sides of stack.
        # Split = all windows displayed
        # Unsplit = 1 window displayed, like Max layout, but still with
        # multiple stack panes
        Key(
            [mod, "shift"],
            "Return",
            lazy.layout.toggle_split(),
            desc="Toggle between split and unsplit sides of stack",
        ),
        Key(
            [mod], "Return",
            lazy.spawn(terminal),
            desc="Launch terminal"),
        # Toggle between different layouts as defined below
        Key(
            [mod], "Tab",
            lazy.next_layout(),
            desc="Toggle between layouts"),
        Key(
            [mod, "shift"], "c",
            lazy.window.kill(),
            desc="Kill focused window"),
        Key(
            [mod, "control"], "r",
            lazy.reload_config(),
            desc="Reload the config"),
        Key(
            [mod, "control"], "q",
            lazy.shutdown(),
            desc="Shutdown Qtile"),
        Key(
            [mod], "r",
            lazy.spawncmd(),
            desc="Spawn a command using a prompt widget"),
        Key(
            [mod, "control"], "p",
            lazy.spawn("i3lock -c 1d1f21"),
            desc="Lock the screen"),
        # Suspend Qtile
        Key(
            [mod, "control"], "x",
            lazy.spawn("/home/rschwalk/dotfiles/scripts/lock_suspend.sh"),
            desc="Suspend with screen lock"),
        Key(
            [mod], "F11",
            lazy.spawn("rofi -show run -fullscreen"),
            desc="Rofi in fullscreen"),
        Key(
            [mod], "F12",
            lazy.spawn("rofi -show run"),
            desc="Rofi run applications"),
        Key(
            [mod, "shift"], "F12",
            lazy.spawn("rofi -show window"),
            desc="Rofi show running applications"),
        # Keyboard focus screen(0)
        Key([mod], "w",
            lazy.to_screen(1),
            desc="Focus to screen 1"),
        # Keyboard focus screen(1)
        Key([mod], "e",
            lazy.to_screen(0),
            desc="Focus to screen 0"),
        Key(
           [], "XF86AudioRaiseVolume",
           lazy.spawn("amixer -q set Master 2%+"),
           desc="Volume Up"),
        Key(
           [], "XF86AudioLowerVolume",
           lazy.spawn("amixer -q set Master 2%-"),
           desc="Volume Down"),
        Key(
           [], "XF86AudioMute",
           lazy.spawn("amixer -q set Master toggle"),
           desc="Mute Volume"),
    ]


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
    group_list = init_group_names()

    return [Group(name, **kwargs) for name, kwargs in group_list]


def init_layout_theme():
    return {"border_width": 2,
            "margin": 2,
            "border_focus": colors[7][0],
            "border_normal": colors[5][0]
            }


def init_layouts():
    return [layout.Max(**layout_theme),
            layout.MonadTall(**layout_theme),
            layout.MonadWide(**layout_theme),
            layout.Bsp(**layout_theme),
            layout.RatioTile(**layout_theme),
            layout.Tile(shift_windows=True, **layout_theme),
            layout.Floating(**layout_theme)]


def init_widget_defaults():
    return dict(font="Noto Sans Mono Regular",
                fontsize=11,
                padding=3,
                foreground=colors[7],
                background=colors[0])


def init_widgets_list():
    label_font_size = 14
    widget_font_size = 12
    prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list = [
        widget.Sep(
            linewidth=0,
            padding=6,
            foreground=colors[1],
        ),
        widget.GroupBox(
            font="Noto Sans Mono Bold",
            fontsize=label_font_size,
            margin_y=5,
            margin_x=0,
            padding_y=5,
            padding_x=5,
            borderwidth=3,
            active=colors[3],
            inactive=colors[5],
            highlight_color=colors[0],
            rounded=True,
            highlight_method="line",
            this_current_screen_border=colors[1],
            this_screen_border=colors[9],
            other_current_screen_border=colors[5],
            other_screen_border=colors[4],
            foreground=colors[2],
        ),
        # widget.Prompt(
        #     prompt="Run:",
        #     font="Noto Sans Mono Regular",
        #     fontsize=widget_font_size,
        #     padding=10,
        #     foreground=colors[3],
        #     background=colors[1]
        # ),
        widget.Sep(
            linewidth=2,
            padding=10,
            foreground=colors[1],
        ),
        widget.WindowName(
            font="Noto Sans Mono",
            fontsize=widget_font_size,
            foreground=colors[6],
        ),
        widget.Sep(
            linewidth=2,
            padding=10,
            foreground=colors[1],
        ),
    ]
    return widgets_list


def init_main_widget_list():
    label_font_size = 14
    widget_font_size = 12
    separator = widget.Sep(
        linewidth=2,
        padding=10,
        foreground=colors[1],
    )

    main_widgets = [
        widget.Systray(
        ),
        separator,
        widget.TextBox(
                    font="Noto Sans Mono Bold",
                    text="CPU:",
                    foreground=colors[8],
                    fontsize=label_font_size
        ),
        widget.CPU(
                    font="Noto Sans Mono Regular",
                    fontsize=widget_font_size,
                    foreground=colors[6],
        ),
        separator,
        widget.TextBox(
            font="Noto Sans Mono Bold",
            text="Mem.:",
            foreground=colors[8],
            fontsize=label_font_size
        ),
        widget.Memory(
            font="Noto Sans Mono Regular",
            fontsize=widget_font_size,
            foreground=colors[6],
        ),
        separator,
        widget.TextBox(
            font="Noto Sans Mono Bold",
            text="Net:",
            foreground=colors[8],
            fontsize=label_font_size
        ),
        widget.Net(
            font="Noto Sans Mono Regular",
            fontsize=widget_font_size,
            interface="enp27s0",
            foreground=colors[6],
        ),
        separator,
        widget.TextBox(
            font="Noto Sans Mono Bold",
            text="Vol.:",
            foreground=colors[8],
            fontsize=label_font_size
        ),
        widget.Volume(
            font="Noto Sans Mono Regular",
            fontsize=widget_font_size,
            foreground=colors[6],
        ),
        separator,
        widget.TextBox(
            font="Noto Sans Mono Bold",
            text="T:",
            foreground=colors[8],
            padding=5,
            fontsize=label_font_size
        ),
        widget.Clock(
            font="Noto Sans Mono Bold",
            fontsize=widget_font_size,
            foreground=colors[6],
            format="%A, %B %d - %H:%M"
        ),
        separator,
    ]

    return main_widgets


def init_widgets_for_secondary_screen():
    return init_widgets_list()


def init_widgets_for_main_screen():
    main_widgets = init_widgets_list() + init_main_widget_list()

    return main_widgets


def init_screens():
    return [
        Screen(
            top=bar.Bar(
                init_widgets_for_secondary_screen(),
                24,
                # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
                # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
            ),
        ),
        Screen(
            top=bar.Bar(
                init_widgets_for_main_screen(),
                28,
                # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
                # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
            ),
        ),
    ]


# SETUP #####
if __name__ in ["config", "__main__"]:
    mod = "mod4"
    terminal = "alacritty"

    colors = init_colors()

    keys = init_keys()

    groups = init_groups()

    for i, (name, kwargs) in enumerate(init_group_names(), 1):
        keys.extend(
            [
                # mod1 + letter of group = switch to group
                Key(
                    [mod],
                    str(i),
                    lazy.group[name].toscreen(),
                    desc="Switch to group {}".format(name),
                ),
                # mod1 + shift + letter of group = switch to & move focused
                # window to group
                Key(
                    [mod, "shift"],
                    str(i),
                    lazy.window.togroup(name, switch_group=True),
                    desc="Switch to & move focused window to group {}".format(name),
                ),
                # Or, use below if you prefer not to switch to that group.
                # # mod1 + shift + letter of group = move focused window to group
                # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
                #     desc="move focused window to group {}".format(i.name)),
            ]
        )

    layout_theme = init_layout_theme()
    layouts = init_layouts()

    # layouts = [
    #     layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    #     layout.Max(),
    #     # Try more layouts by unleashing below layouts.
    #     # layout.Stack(num_stacks=2),
    #     # layout.Bsp(),
    #     # layout.Matrix(),
    #     # layout.MonadTall(),
    #     # layout.MonadWide(),
    #     # layout.RatioTile(),
    #     # layout.Tile(),
    #     # layout.TreeTab(),
    #     # layout.VerticalTile(),
    #     # layout.Zoomy(),
    # ]

    widget_defaults = dict(
        font="sans",
        fontsize=12,
        padding=3,
    )
    extension_defaults = widget_defaults.copy()

    screens = init_screens()

    # Drag floating layouts.
    mouse = [
        Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
        Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
        Click([mod], "Button2", lazy.window.bring_to_front()),
    ]

    dgroups_key_binder = None
    dgroups_app_rules = []  # type: list
    follow_mouse_focus = True
    bring_front_click = False
    cursor_warp = False
    floating_layout = layout.Floating(
        float_rules=[
            # Run the utility of `xprop` to see the wm class and name of an X client.
            *layout.Floating.default_float_rules,
            Match(wm_class="confirmreset"),  # gitk
            Match(wm_class="makebranch"),  # gitk
            Match(wm_class="maketag"),  # gitk
            Match(wm_class="ssh-askpass"),  # ssh-askpass
            Match(title="branchdialog"),  # gitk
            Match(title="pinentry"),  # GPG key password entry
        ]
    )
    auto_fullscreen = True
    focus_on_window_activation = "smart"
    reconfigure_screens = True

    # If things like steam games want to auto-minimize themselves when losing
    # focus, should we respect this or not?
    auto_minimize = True

    # When using the Wayland backend, this can be used to configure input devices.
    wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
