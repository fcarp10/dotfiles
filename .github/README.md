# Dotfiles

![Desktop Screenshot](screenshots/screenshot-2026-06.png)

This repository contains my personal dotfiles for a Linux desktop environment using Wayland compositors.

### Window Manager and desktop shell
- [niri](https://github.com/YaLTeR/niri): A scrollable-tiling Wayland compositor.
- [noctalia](https://github.com/noctalia-dev/noctalia): A minimal desktop shell for Wayland.

### Terminal 
- [alacritty](https://github.com/alacritty/alacritty): A cross-platform, OpenGL terminal emulator.
- [zsh](https://www.zsh.org/): A shell designed for interactive use.
- [antidote](https://github.com/mattmc3/antidote): A zsh plugin manager, the cure to slow zsh plugin management.

### System Tools
- [btop](https://github.com/aristocratos/btop): A monitor of resources, processes, with a customizable interface.
- [fastfetch](https://github.com/fastfetch-cli/fastfetch): A maintained, feature-rich and performance oriented, neofetch like system information tool.
- [auto-cpufreq](https://github.com/AdnanHodzic/auto-cpufreq): Automatic CPU speed & power optimizer for Linux.
- [paru](https://github.com/Morganamilo/paru): Feature packed AUR helper.

### Editors
- [neovim](https://github.com/neovim/neovim): Hyperextensible Vim-based text editor.
- [vscodium](https://github.com/VSCodium/vscodium): Community-driven, freely-licensed binary distribution of VS Code without MS branding/telemetry/licensing.
- [zed](https://github.com/zed-industries/zed): A high-performance code editor from the creators of Atom and Tree-sitter.

### Utilities
- [fusuma](https://github.com/iberianpig/fusuma): A multitouch gesture recognizer.
- [openrgb](https://gitlab.com/CalcProgrammer1/OpenRGB): Open source RGB lighting control that doesn't depend on manufacturer software.
- [logid](https://github.com/PixlOne/logiops): An unofficial userspace driver for HID++ Logitech devices.

## Install

Install dotfiles with stow:
```
stow */
```

To delete, run:
```
stow -D */
```
