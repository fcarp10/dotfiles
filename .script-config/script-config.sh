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
\n -a --apps
\t Installs main packages.
\n -e --extra
\t Installs packages from AUR.
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


list_pacman=(
firefox
syncthing
celluloid
telegram-desktop
zsh
neofetch
keychain
cawbird
gnome-podcasts
gnome-tweaks
retroarch
libretro-snes9x
)

list_aur=(
tela-icon-theme
ttf-meslo-nerd-font-powerlevel10k
)

while [ "$1" != "" ]; do
  case $1 in
    --apps | -a )
    log "INFO" "starting installation of apps"
    install_list "${list_pacman[*]}"
    scale-to-fit cawbird
    scale-to-fit gnome-tweaks
    ;;
    
    --extra | -e )
    log "INFO" "starting the installation of apps from AUR"
    install_list_aur "${list_aur[*]}"
    # change shell to zsh and install powerlevel10k
    chsh -s /usr/bin/zsh
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc
    # set up git
    git config --global user.name "Francisco Carpio"
    git config --global user.email "carpiofj@gmail.com"
    ;;
    
    --help | -h )        echo -e "${usage}"
    exit 1
    ;;
    * )         echo -e "Invalid option $1 \n\n${usage}"
    exit 0
  esac
  shift
done
