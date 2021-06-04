# Arcolinux configuration

Arcolinux installation and script for installing `qtile` and additional software.

## Prerequisites 

The script has only been tested in ArcoLinuxD. Short instructions on how to install ArcoLinuxD:

1. Download [ArcoLinuxD](https://arcolinux.info/download/) and burn the iso with [etcher](https://github.com/balena-io/etcher).
2. Boot the system from an USB drive, launch calamares and select only: `linux kernel without Nvidia`.
3. After the installation, restart and login.
4. Run `mirror` to update mirrors, run `update` or `sudo pacman -Syyu` to upgrade the system, and reboot.

## Configuration script

Run `script-config.sh` to install the software:

```
chmod +x script-config.sh
./script-config.sh -h

OPTIONS:
\n -q --qtile
\t Installs qtile and arcolinux packages.
\n -a --audio
\t Installs audio packages.
\n -p --printers
\t Installs printers packages.
\n -l --laptop
\t Installs laptop and bluetooth packages.
\n -A --apps
\t Installs apps.
\n -c --config
\t Apply configuration.
\n -h --help
\t Shows available options.
\n\t Only one option is allowed.
```



