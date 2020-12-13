## Arcolinux configuration

Script for installing `awesomewm` and all additional packages and settings.

### Prerequisites 

The script has only been tested in ArcoLinuxD. Short instructions on how to install ArcoLinuxD:

1. Download [ArcoLinuxD](https://arcolinux.info/download/) and burn the iso with [etcher](https://github.com/balena-io/etcher).
2. Boot the system from an USB drive, launch calamares and select only: `linux kernel without Nvidia`.
3. After the installation, restart and login.
4. Run `mirror` to update mirrors, run `update` or `sudo pacman -Syyu` to upgrade the system, and reboot.

### Configuration script

Run `script-config.sh` to install the software:

```
chmod +x post-installation-script.sh
./post-installation-script.sh -h

Options:
-c --core: installs core software.
-s --sound: installs sound software.
-p --printers: installs printers software.
-b --bluetooth: installs bluetooth software.
-l --laptop: installs laptop software.
-e --extra: installs extra software.
-h --help: shows available options.
```



