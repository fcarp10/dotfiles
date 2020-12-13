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
\n -c --core
\t Installs core software.
\n -s --sound
\t Installs sound software.
\n -p --printers
\t Installs printers software.
\n -b --bluetooth
\t Installs bluetooth software.
\n -l --laptop
\t Installs laptop software.
\n -e --extra
\t Installs extra software.
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
	if yay -Qi $1 &> /dev/null; then
		log "WARN" "the package "$1" is already installed"
	else
		log "INFO" "installing package "$1" "
    	yay -S --noconfirm --needed $1
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


list_core=(
lightdm
arcolinux-lightdm-gtk-greeter
arcolinux-lightdm-gtk-greeter-settings
arcolinux-wallpapers-git
awesome
vicious
arcolinux-awesome-git
arcolinux-awesome-dconf-git
arcolinux-config-awesome-git
arcolinux-logout-git
)

list_audio=(
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

list_printers=(
cups
cups-pdf
ghostscript
gsfonts
gutenprint
gtk3-print-backends
libcups
system-config-printer
)

list_bluetooth=(
pulseaudio-bluetooth
bluez
bluez-libs
bluez-utils
blueberry
)

list_laptop=(
tlp
)

list_extra=(
## arcolinux specific
downgrade
inxi
pamac-aur
arcolinux-tweak-tool-git
arcolinux-bin-git
arcolinux-hblock-git
arcolinux-root-git
arcolinux-arc-themes
## awesome specific
arandr
dmenu
## additional software
firefox
thunderbird
chromium
torbrowser-launcher
syncthing
xreader
thunar
gvfs
file-roller
zip
unrar
p7zip
nomacs
code
gnome-screenshot
celluloid
slack-desktop
wps-office
alacritty
telegram-desktop
jdk-openjdk
pyenv
etcher-bin
docker
zsh
## latex
texlive-bibextra
texlive-bin
texlive-core
texlive-fontsextra
texlive-formatextra
texlive-latexextra
texlive-pictures
texlive-publishers
texlive-science
## fonts
arcolinux-fonts-git
)

list_aur=(
tela-icon-theme
ttf-meslo-nerd-font-powerlevel10k
jabref
drawio-desktop
)

while [ "$1" != "" ]; do
  case $1 in
    --core | -c )
    log "INFO" "starting installation of core software"
    install_list "${list_core[*]}"
    log "INFO" "enabling lightdm as display manager"
    sudo systemctl enable lightdm.service -f
    log "INFO" "core software has been installed, reboot your system"
    ;;
    
    --sound | -s )       
    log "INFO" "starting installation of sound software"
    install_list "${list_audio[*]}"
    log "INFO" "sound software has been installed"
    ;;
    
    --printers | -p )
    log "INFO" "starting the installation of printers software"
    install_list "${list_printers[*]}"
    sudo systemctl enable org.cups.cupsd.service
    log "INFO" "printers software has been installed"
    ;;
    
    --bluetooth | -b )
    log "INFO" "starting the installation of bluetooth software"
    install_list "${list_bluetooth[*]}"
    sudo systemctl enable bluetooth.service
    sudo systemctl start bluetooth.service
    sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf
    log "INFO" "bluetooth software has been installed"
    ;;
    
    --laptop | -l )
    log "INFO" "starting the installation of laptop software"
    install_list "${list_laptop[*]}"
    sudo systemctl enable tlp.service
    log "INFO" "laptop software has been installed"
    ;;
    
    --extra | -e )
    log "INFO" "starting the installation of extra software"
    install_list "${list_extra[*]}"
    install_list_aur "${list_aur[*]}"
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
