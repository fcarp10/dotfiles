#!/bin/bash

###############################################################################
# Author	:	Francisco Carpio
# Github	:	https://github.com/fcarp10
###############################################################################
#   This script has been inspired by Arcolinux scripts created by Erik Dubois.
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
###############################################################################

BLUE='\033[0;34m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
RED='\033[0;31m'
NO_COLOR='\033[0m'

function log {
    if [[ $1 == "INFO" ]]; then
        printf "${BLUE}INFO:${NO_COLOR} %s \n" "$2"
    elif [[ $1 == "DONE" ]]; then
        printf "${GREEN}SUCCESS:${NO_COLOR} %s \n" "$2"
    elif [[ $1 == "WARN" ]]; then
        printf "${ORANGE}WARNING:${NO_COLOR} %s \n" "$2"
    else
        printf "${RED}FAILED:${NO_COLOR} %s \n" "$2"
    fi
}

usage='Usage:
'$0' [OPTION]

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
'

function install_package {
	if pacman -Qi $1 &> /dev/null; then
		log "WARN" "the package "$1" is already installed"
	else
		log "INFO" "installing package "$1" "
    	sudo pacman -S --noconfirm --needed $1
    fi
}

function install_package_aur {
	if paru -Qi $1 &> /dev/null; then
		log "WARN" "the package "$1" is already installed"
	else
		log "INFO" "installing package "$1" "
    	paru -S --noconfirm --needed $1
    fi
}

function install_list {
    for name in $@ ; do
        install_package $name
    done
}

function install_list_aur {
    for name in $@ ; do
        install_package_aur $name
    done
}

# -A --awesome: installs core packages for awesomewm.
awesome_core=(
lightdm
arcolinux-lightdm-gtk-greeter
arcolinux-lightdm-gtk-greeter-settings
arcolinux-wallpapers-git
thunar
awesome
dmenu
vicious
arcolinux-awesome-git
arcolinux-awesome-dconf-git
arcolinux-config-awesome-git
arcolinux-logout-git
arandr
lxappearance
picom
)

# -Q --qtile: installs core packages for qtile.
qtile_core=(
sddm
arcolinux-sddm-sugar-candy-git
sddm-config-editor-git
arcolinux-wallpapers-git
thunar
qtile
sxhkd
dmenu
python-psutil
xcb-util-cursor
arcolinux-qtile-git
arcolinux-qtile-dconf-git
arcolinux-config-qtile-git
arcolinux-logout-git
arandr
lxappearance
picom
)

# -a --arcolinuxd: installs extra packages from arcolinux.
arco_extra=(
downgrade
inxi
pamac-aur
arcolinux-tweak-tool-git
arcolinux-bin-git
arcolinux-hblock-git
arcolinux-root-git
arcolinux-arc-themes-git
arcolinux-fonts-git
)

# -s --sound: installs sound packages.
audio=(
pulseaudio
pulseaudio-alsa
pavucontrol
alsa-firmware
alsa-lib
alsa-plugins
alsa-utils
gstreamer
gst-plugins-good
gst-plugins-bad
gst-plugins-base
gst-plugins-ugly
playerctl
volumeicon
)

# -p --printers: installs printers packages.
printers=(
cups
cups-pdf
ghostscript
gsfonts
gutenprint
gtk3-print-backends
libcups
system-config-printer
)

# -b --bluetooth: installs bluetooth packages.
bluetooth=(
pulseaudio-bluetooth
bluez
bluez-libs
bluez-utils
blueberry
)

# -l --laptop: installs laptop packages.
laptop=(
tlp
)

# -e --extra: installs extra packages.
extra=(
firefox
thunderbird
chromium
torbrowser-launcher
syncthing
xreader
gvfs
file-roller
zip
unrar
p7zip
nomacs
gnome-screenshot
celluloid
slack-desktop
onlyoffice
alacritty
bashtop
neofetch
telegram-desktop
jdk-openjdk
pyenv
etcher-bin
docker
zsh
texlive-bibextra
texlive-bin
texlive-core
texlive-fontsextra
texlive-formatextra
texlive-latexextra
texlive-pictures
texlive-publishers
texlive-science
paru-bin
)
aur=(
ttf-meslo-nerd-font-powerlevel10k
jabref
drawio-desktop
vscodium-bin
vscodium-bin-marketplace
)

while [ "$1" != "" ]; do
  case $1 in
    --awesome | -A )
    log "INFO" "starting installation of core packages for awesomewm"
    install_list "${awesome_core[*]}"
    cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S)
    cp -arf /etc/skel/. ~
    log "INFO" "enabling lightdm as display manager"
    sudo systemctl enable lightdm.service -f
    log "INFO" "core packages for awesomewm have been installed, reboot your system"
    ;;

    --qtile | -Q )
    log "INFO" "starting installation of core packages for qtile"
    install_list "${qtile_core[*]}"
    cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S)
    cp -arf /etc/skel/. ~
    log "INFO" "enabling sddm as display manager"
    sudo systemctl enable sddm.service -f
    log "INFO" "core packages for qtile have been installed, reboot your system"
    ;;

    --arcolinuxd | -a )
    log "INFO" "starting installation of extra packages from arcolinux."
    install_list "${arco_extra[*]}"
    log "INFO" "extra packages from arcolinux have been installed"
    ;;
    
    --sound | -s )       
    log "INFO" "starting installation of sound packages"
    install_list "${audio[*]}"
    log "INFO" "sound packages have been installed"
    ;;
    
    --printers | -p )
    log "INFO" "starting the installation of printers packages"
    install_list "${printers[*]}"
    sudo systemctl enable org.cups.cupsd.service
    log "INFO" "printers packages have been installed"
    ;;
    
    --bluetooth | -b )
    log "INFO" "starting the installation of bluetooth packages"
    install_list "${bluetooth[*]}"
    sudo systemctl enable bluetooth.service
    sudo systemctl start bluetooth.service
    sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf
    log "INFO" "bluetooth packages have been installed"
    ;;
    
    --laptop | -l )
    log "INFO" "starting the installation of laptop packages"
    install_list "${laptop[*]}"
    sudo systemctl enable tlp.service
    log "INFO" "laptop packages have been installed"
    ;;
    
    --extra | -e )
    log "INFO" "starting the installation of extra packages"
    install_list "${extra[*]}"
    install_list_aur "${aur[*]}"
    # change shell to zsh and install powerlevel10k
    chsh -s /usr/bin/zsh
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc
    # add pluging to pyenv
    git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
    # set up git
    git config --global user.name "Francisco Carpio"
    git config --global user.email "carpiofj@gmail.com"
    # set up docker
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo usermod -aG docker $USER
    newgrp docker
    ;;
    
    --help | -h )        echo -e "${usage}"
    exit 1
    ;;
    * )         echo -e "Invalid option $1 \n\n${usage}"
    exit 0
  esac
  shift
done
