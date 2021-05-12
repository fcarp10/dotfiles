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

function install_package_pacman {
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

function install_package_flatpak {
    log "INFO" "installing package "$1" "
    flatpak install -y flathub $1 --user
}

while [ "$1" != "" ]; do
  case $1 in
    --apps | -a )
    log "INFO" "Installing pacman packages..."
    cat packages_pacman.txt | while read y
    do
    install_package_pacman $y
    done
    ;;
    
    --paru | -p )
    log "INFO" "Installing paru..."
    sudo pacman -S --noconfirm --needed base-devel
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    ;;
    
    --aur | -r )
    log "INFO" "Installing AUR packages..."
    cat packages_aur.txt | while read y
    do
    install_package_aur $y
    done
    ;;
    
    --flatpak | -f )
    log "INFO" "Installing flatpak apps..."
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo --user
    cat packages_flatpak.txt | while read y
    do
    install_package_flatpak $y
    done
    ;;
    
    --config | -c )
    log "INFO" "Applying personal configuration..."
    # change shell to zsh
    chsh -s /usr/bin/zsh
    # set up git
    git config --global user.name "Francisco Carpio"
    git config --global user.email "carpiofj@gmail.com"
    git config credential.helper store
    git config --global credential.helper store
    ;;
    
    --help | -h )        echo -e "${usage}"
    exit 1
    ;;
    * )         echo -e "Invalid option $1 \n\n${usage}"
    exit 0
  esac
  shift
done
