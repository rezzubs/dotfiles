from libqtile import bar, layout
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration

from catppuccin import catppuccin as cp


mod = "mod4"
terminal = "kitty"
gap = 6


keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
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
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key(["mod1"], "Tab", lazy.screen.next_group()),
    Key(["mod1", "shift"], "Tab", lazy.screen.prev_group()),
    Key([mod], "d", lazy.spawn("rofi -show drun")),

    #media
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl s 10%-")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl s 10%+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume 0 -5%")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume 0 +5%")),
    Key([mod], "O", lazy.spawn("bash -c cycle-default-sink")),

    #screenshot
    Key([mod, "shift"], "s", lazy.spawn("flameshot gui")),
    # fullscreen toggle
    Key([mod], "f", lazy.window.toggle_fullscreen()),
]

groups = [Group(i) for i in "一二三四五六七八九"]

for i in range(len(groups)):
    keys.extend(
        [
            Key(
                [mod],
                str(i + 1),
                lazy.group[groups[i].name].toscreen(),
                desc="Switch to group {}".format(groups[i].name),
            ),
            Key(
                [mod, "shift"],
                str(i + 1),
                lazy.window.togroup(groups[i].name, switch_group = False),
                desc="Move window to group {}".format(groups[i].name),
            )
        ]
    )


###########
# LAYOUTS #
###########

layouts = [
    layout.Columns(
        margin = gap,
        border_width = 0,
        border_focus = cp["lavender"],
        border_normal = cp["overlay0"],
        border_on_single = True,
    ),
    layout.Max(
        margin = gap,
        border_width = 0,
        border_focus = cp["teal"],
    ),
]

widget_defaults = dict(
    font="JetBrains Mono",
    fontsize=14,
    padding=3,
    background = cp["base"],
    foreground = cp["text"],
)
extension_defaults = widget_defaults.copy()


#######
# BAR #
#######

systray_decoration = {
    "decorations": [
        RectDecoration(colour="#004040", radius=10, filled=True, padding_y=4, group=True)
    ],
    "padding": 10,
}

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(length = 14),
                widget.GroupBox(
                    disable_drag = True,
                    font = 'bold',
                    background = cp["base"],
                    highlight_method = "text",
                    fontsize = 20,
                    this_current_screen_border = cp["text"],
                    active = cp["base"],
                    hide_unused = True,
                    decorations = [
                        RectDecoration(
                            colour = cp["mauve"],
                            filled = True,
                            padding_y = 5,
                            radius = 15,
                        )
                    ]
                ),
                widget.Spacer(length = 10),
                widget.TextBox(
                    foreground = cp["base"],
                    fmt = '  ',
                    fontsize = 20,
                    padding = 0,
                    decorations = [
                        RectDecoration(
                            colour = cp["red"],
                            filled = True,
                            padding_y = 5,
                            radius = [15, 0, 0, 15],
                        )
                    ]
                ),
                widget.Memory(
                    foreground = cp["base"],
                    format = '{MemPercent: .0f}%  ',
                    fontsize = 14,
                    font = 'JetBrains Mono bold',
                    padding = 0,
                    decorations = [
                        RectDecoration(
                            colour = cp["red"],
                            filled = True,
                            padding_y = 5,
                            radius = [0, 15, 15, 0],
                        )
                    ]
                ),
                widget.Image(filename = "~/.config/qtile/assets/base_right.png"),
                widget.Prompt(),
                widget.Spacer(background = cp["crust"]),
                widget.Image(filename = "~/.config/qtile/assets/base_left.png"),
                widget.Clock(
                    format="%a %Y/%m/%d %H:%M",
                    font = 'JetBrains Mono bold',
                ),
                widget.Image(filename = "~/.config/qtile/assets/base_right.png"),
                widget.Spacer(background = cp["crust"]),
                widget.Systray(
                    background = cp["crust"],
                ),
                widget.Spacer(
                    background = cp["crust"],
                    length = 15,
                ),
                widget.Image(filename = "~/.config/qtile/assets/base_left.png"),
                widget.TextBox(
                    foreground = cp["base"],
                    fmt = "  ",
                    fontsize = 18,
                    decorations = [
                        RectDecoration(
                            colour = cp["sky"],
                            filled = True,
                            padding_y = 5,
                            radius = [15, 0, 0, 15],
                        )
                    ]
                ),
                widget.CheckUpdates(
                    clip = True,
                    colour_no_updates = cp["base"],
                    colour_have_updates = cp["base"],
                    no_update_string="0  ",
                    display_format = "{updates}  ",
                    fontsize = 14,
                    font = "JetBrains Mono bold",
                    distro = "Arch_checkupdates",
                    decorations = [
                        RectDecoration(
                            colour = cp["sky"],
                            filled = True,
                            padding_y = 5,
                            radius = [0, 15, 15, 0],
                        )
                    ]
                ),


                #power
                widget.Spacer(length = 10),
                widget.TextBox(
                    foreground = cp["base"],
                    fmt = "  ",
                    fontsize = 20,
                    mouse_callbacks = {
                        "Button1": lazy.spawn("sudo shutdown now"),
                        "Button2": lazy.spawn("sudo reboot"),
                        "Button3": lazy.spawn("sudo systemctl suspend"),
                    },
                    decorations = [
                        RectDecoration(
                            colour = cp["blue"],
                            filled = True,
                            padding_y = 5,
                            radius = 15,
                        )
                    ]
                ),
                widget.Spacer(length = 14),
            ],
40,
background = cp["crust"],
margin = [0, 0, gap, 0],
# border_width=[2, 0, 2, 0],  # Draw top and bottom borders
# border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
),
bottom=bar.Gap(gap),
right=bar.Gap(gap),
left=bar.Gap(gap),
),
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
