# Antonio Sarosi
# https://youtube.com/c/antoniosarosi
# https://github.com/antoniosarosi/dotfiles

# Theming for Qtile

from os import path
import subprocess
import json

qtile_path = path.join(path.expanduser("~"), ".config", "qtile")


def load_theme():
    theme = "dark"

    theme_file = path.join(qtile_path, "themes", f"{theme}.json")
    if not path.isfile(theme_file):
        raise Exception(f'"{theme_file}" does not exist')

    with open(path.join(theme_file)) as f:
        return json.load(f)


if __name__ == "settings.theme":
    colors = load_theme()
