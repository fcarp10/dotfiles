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
chmod 0755 script-config.sh
./script-config.sh -h

OPTIONS:
\n -a --apps
\t Installs pacman packages.
\n -p --paru
\t Installs paru.
\n -r --aur
\t Install AUR packages.
\n -c --config
\t Apply configuration.
\n -f --flatpak
\t Installs flathub apps.
\n -h --help
\t Shows available options.
\n\t Only one option is allowed.
'
```

### Troubleshooting

To install `paru`, it is required to enable zRAM in the 2GB model. 

#### Steps

Create a new configuration file and add the word `zram` to it:

    sudo nano /etc/modules-load.d/zram.conf

Create a second configuration file in:

    sudo nano /etc/modprobe.d/zram.conf

and paste this:

    options zram num_devices=1

Next to configure is the size of the zRAM partition. Create a new file in:

    sudo nano /etc/udev/rules.d/99-zram.rules

and paste the following:

    KERNEL=="zram0", ATTR{disksize}="512M",TAG+="systemd"

In order for zRAM to function, disable traditional swap. Open:

    sudo nano /etc/fstab

Comment out the line starting with `/swap.img`.

For zRAM to run, create a systemd unit file:

    sudo nano /etc/systemd/system/zram.service

Paste the following:

    
    [Unit]
    Description=Swap with zram
    After=multi-user.target

    [Service]
    Type=oneshot 
    RemainAfterExit=true
    ExecStartPre=/sbin/mkswap /dev/zram0
    ExecStart=/sbin/swapon /dev/zram0
    ExecStop=/sbin/swapoff /dev/zram0

    [Install]
    WantedBy=multi-user.target
    
Enable the unit:

    sudo systemctl enable zram

Reboot. 