from libqtile import widget
from settings.theme import colors

# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)


def base(fg="text", bg="background"):
    return {"foreground": colors[fg], "background": colors[bg]}


def separator():
    return widget.Sep(**base(), linewidth=0, padding=5)


def icon(fg="text", bg="background", fontsize=16, text="?"):
    return widget.TextBox(**base(fg, bg), fontsize=fontsize, text=text, padding=3)


def powerline(fg="foreground", bg="background"):
    return widget.TextBox(
        **base(fg, bg), text="", fontsize=37, padding=-2  # Icon: nf-oct-triangle_left
    )


def workspaces():
    return [
        separator(),
        widget.GroupBox(
            **base(fg="foreground"),
            font="UbuntuMono Nerd Font",
            fontsize=19,
            margin_y=3,
            margin_x=0,
            padding_y=8,
            padding_x=5,
            borderwidth=1,
            active=colors["active"],
            inactive=colors["inactive"],
            rounded=False,
            highlight_method="block",
            urgent_alert_method="block",
            urgent_border=colors["urgent"],
            this_current_screen_border=colors["focus"],
            this_screen_border=colors["focus"],
            other_current_screen_border=colors["background"],
            other_screen_border=colors["background"],
            disable_drag=True
        ),
        separator(),
        widget.WindowName(**base(fg="focus"), fontsize=14, padding=5),
        separator(),
    ]


primary_widgets = [
    *workspaces(),
    separator(),
    widget.Systray(background=colors["background"], padding=5),
    widget.Sep(  # space separator
        padding=5,
        foreground=colors["background"],
        background=colors["background"],
    ),
    icon(fg="foreground", text=" "),  # updates icon
    widget.CheckUpdates(
        foreground=colors["foreground"],
        background=colors["background"],
        colour_have_updates=colors["urgent"],
        colour_no_updates=colors["foreground"],
        no_update_string="0",
        display_format="{updates}",
        update_interval=1800,
        custom_command="checkupdates",
    ),
    widget.Sep(  # space separator
        padding=5,
        foreground=colors["background"],
        background=colors["background"],
    ),
    widget.KeyboardLayout(
        foreground=colors["foreground"],
        background=colors["background"],
    ),
    widget.Sep(  # line separator
        linewidth=1,
        padding=15,
        foreground=colors["foreground"],
        background=colors["background"],
    ),
    widget.TextBox(
        text="墳 ",  # volume icon
        foreground=colors["foreground"],
        background=colors["background"],
        padding=0,
    ),
    widget.Volume(
        foreground=colors["foreground"],
        background=colors["background"],
    ),
    widget.TextBox(
        text="    ",  # CPU icon
        foreground=colors["foreground"],
        background=colors["background"],
        padding=0,
    ),
    widget.CPU(
        foreground=colors["foreground"],
        background=colors["background"],
        format="{load_percent}%",
        update_interval=10,
    ),
    widget.TextBox(
        text="   ",  # Memory icon
        foreground=colors["foreground"],
        background=colors["background"],
        padding=0,
    ),
    widget.Memory(
        format="{MemPercent}%",
        update_interval=10,
        foreground=colors["foreground"],
        background=colors["background"],
    ),
    widget.TextBox(
        text="   ",  # ThermalSensor icon
        foreground=colors["foreground"],
        background=colors["background"],
        padding=0,
    ),
    widget.ThermalSensor(
        foreground=colors["foreground"],
        foreground_alert=colors["urgent"],
        background=colors["background"],
        metric=True,
        padding=0,
        threshold=80,
    ),
    widget.Sep(  # line separator
        linewidth=1,
        padding=15,
        foreground=colors["foreground"],
        background=colors["background"],
    ),
    icon(fg="foreground", fontsize=17, text=" "),  # calendar icon
    widget.Clock(**base(fg="foreground"), format="%d/%m/%Y - %H:%M "),
    widget.CurrentLayoutIcon(**base(fg="foreground"), scale=0.65),
]

secondary_widgets = [
    *workspaces(),
    separator(),
    widget.Clock(**base(fg="foreground"), format="%d/%m/%Y - %H:%M "),
    widget.CurrentLayoutIcon(**base(fg="foreground"), scale=0.65),
]

widget_defaults = {
    "font": "UbuntuMono Nerd Font Bold",
    "fontsize": 14,
    "padding": 1,
}
extension_defaults = widget_defaults.copy()
