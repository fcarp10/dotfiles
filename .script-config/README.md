## Arch Linux ARM configuration

Script for installing additional software and settings.

### Prerequisites 

The script has only been tested in [Arch Linux ARM](https://github.com/dreemurrs-embedded/Pine64-Arch). Short instructions on how to flash the image:

1. Download the pinephone image from [Arch Linux ARM](https://github.com/dreemurrs-embedded/Pine64-Arch/releases) and burn with [etcher](https://github.com/balena-io/etcher) on a SD card.
2. Insert the SD card into the Pinephone, login with user: `alarm`, password: `123456`, open the terminal an update the system `sudo pacman -Syyu`.
3. (optional) Enable SSH: `sudo systemctl enable --now sshd`

### Configuration script

Run `script-config.sh` to install the software:

```
chmod +x post-installation-script.sh
./post-installation-script.sh -h

OPTIONS:
\n -a --apps
\t Installs main packages.
\n -e --extra
\t Installs packages from AUR.
\n -f --extra
\t Installs packages from flathub.
\n -h --help
\t Shows available options.
\n\t Only one option is allowed.
'
```



