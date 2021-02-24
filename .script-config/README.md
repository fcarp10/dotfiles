## Arcolinux configuration

Script for installing `awesomewm` or `qtile` and additional packages and settings.

### Prerequisites 

The script has only been tested in ArcoLinuxD. Short instructions on how to install ArcoLinuxD:

1. Download [ArcoLinuxD](https://arcolinux.info/download/) and burn the iso with [etcher](https://github.com/balena-io/etcher).
2. Boot the system from an USB drive, launch calamares and select only: `linux kernel without Nvidia`.
3. After the installation, restart and login.
4. Run `mirror` to update mirrors, run `update` or `sudo pacman -Syyu` to upgrade the system, and reboot.

### Configuration script

Run `script-config.sh` to install a set of packages:

```
chmod +x script-config.sh
./script-config.sh -h

OPTIONS:
\n -A --awesome
\t Installs core packages for awesomewm.
\n -Q --qtile
\t Installs core packages for qtile.
\n -a --arcolinuxd
\t Installs extra packages from arcolinux.
\n -s --sound
\t Installs sound packages.
\n -p --printers
\t Installs printers packages.
\n -b --bluetooth
\t Installs bluetooth packages.
\n -l --laptop
\t Installs laptop packages.
\n -e --extra
\t Installs extra packages.
\n -h --help
\t Shows available options.
\n\t Only one option is allowed.
```



