# Antonio Sarosi
# https://youtube.com/c/antoniosarosi
# https://github.com/antoniosarosi/dotfiles

# Qtile workspaces

from libqtile.config import Key, Group, Match
from libqtile.command import lazy
from settings.keys import mod, keys
from libqtile import hook

# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)


workspaces = [
    {
        "name": "   ",
        "key": "1",
        "matches": [Match(wm_class="firefox"), Match(wm_class="chromium")],
    },  # nf-oct-browser
    {
        "name": "   ",
        "key": "2",
        "matches": [Match(wm_class="alacritty")],
    },  # nf-dev-terminal
    {"name": "   ", "key": "3", "matches": [Match(wm_class="vscodium")]},  # nf-fa-code
    {
        "name": "   ",
        "key": "4",
        "matches": [Match(wm_class="thunar")],
    },  # nf-mdi-folder
    {
        "name": " ﬐  ",
        "key": "5",
        "matches": [Match(wm_class="telegram-desktop"), Match(wm_class="slack")],
    },  # nf-mdi-wechat
    {
        "name": "   ",
        "key": "6",
        "matches": [Match(wm_class="thunderbird")],
    },  # nf-mdi-email
]

groups = []
for workspace in workspaces:
    matches = workspace["matches"] if "matches" in workspace else None
    groups.append(Group(workspace["name"], matches=matches, layout="monadtall"))
    keys.append(Key([mod], workspace["key"], lazy.group[workspace["name"]].toscreen()))
    keys.append(
        Key([mod, "shift"], workspace["key"], lazy.window.togroup(workspace["name"]))
    )
