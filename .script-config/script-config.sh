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
\n -c --config
\t Apply configuration.
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

while [ "$1" != "" ]; do
  case $1 in
    --awesome | -A )
    log "INFO" "starting installation of awesomewm packages..."
    cat packages_awesome.txt | while read y
    do
    install_package_pacman $y
    done
    cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S)
    cp -arf /etc/skel/. ~
    log "INFO" "enabling lightdm as display manager"
    sudo systemctl enable lightdm.service -f
    log "INFO" "done, reboot your system"
    ;;

    --qtile | -Q )
    log "INFO" "starting installation of qtile packages..."
    cat packages_qtile.txt | while read y
    do
    install_package_pacman $y
    done
    cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S)
    cp -arf /etc/skel/. ~
    log "INFO" "enabling sddm as display manager"
    sudo systemctl enable sddm.service -f
    log "INFO" "done, reboot your system"
    ;;

    --arcolinuxd | -a )
    log "INFO" "starting installation of arcolinux packages..."
    cat packages_arcolinux.txt | while read y
    do
    install_package_pacman $y
    done
    log "INFO" "done"
    ;;

    --sound | -s )
    log "INFO" "starting installation of audio packages..."
    cat packages_audio.txt | while read y
    do
    install_package_pacman $y
    done
    log "INFO" "done"
    ;;

    --printers | -p )
    log "INFO" "starting installation of printers packages..."
    cat packages_printers.txt | while read y
    do
    install_package_pacman $y
    done
    sudo systemctl enable org.cups.cupsd.service
    log "INFO" "done"
    ;;

    --bluetooth | -b )
    log "INFO" "starting installation of bluetooth packages..."
    cat packages_bluetooth.txt | while read y
    do
    install_package_pacman $y
    done
    sudo systemctl enable bluetooth.service
    sudo systemctl start bluetooth.service
    sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf
    log "INFO" "done"
    ;;

    --laptop | -l )
    log "INFO" "starting installation of laptop packages..."
    cat packages_laptop.txt | while read y
    do
    install_package_pacman $y
    done
    sudo systemctl enable tlp.service
    log "INFO" "done"
    ;;

    --extra | -e )
    log "INFO" "starting installation of extra packages..."
    cat packages_pacman.txt | while read y
    do
    install_package_pacman $y
    done
    cat packages_aur.txt | while read y
    do
    install_package_aur $y
    done
    log "INFO" "done"
    ;;

	--config | -c )
    log "INFO" "applying personal configuration..."
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
	log "INFO" "done"
    ;;

    --help | -h )        echo -e "${usage}"
    exit 1
    ;;
    * )         echo -e "Invalid option $1 \n\n${usage}"
    exit 0
  esac
  shift
done
