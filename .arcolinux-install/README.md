# Arcolinux installation

Script for installing `awesomewm` and all additional packages for `arcolinux`.

### Arcolinux installation

1. Download [ArcoLinuxD](https://arcolinux.info/download/) and burn the iso with [etcher](https://github.com/balena-io/etcher).
2. Boot the system from an USB drive and launch calamares.
3. In calamares, select only: `linux kernel without Nvidia`.
4. After the installation, restart and login.
5. Run `mirror` to update mirrors, run `update` or `sudo pacman -Syyu` to upgrade the system, and reboot.

### Post-installation script

Run `post-installation-script.sh` to install the software. The available options are:

```
-c --core: installs core software.
-s --sound: installs sound software.
-p --printers: installs printers software.
-b --bluetooth: installs bluetooth software.
-l --laptop: installs laptop software.
-e --extra: installs extra software.
```
