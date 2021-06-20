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
\n -q --qtile
\t Installs qtile and arcolinux packages.
\n -a --apps
\t Installs apps.
\n -aw --apps-work
\t Installs apps work.
\n -l --laptop
\t Installs laptop and bluetooth packages.
\n -p --printers
\t Installs printers packages.
\n -c --config
\t Apply configuration.
\n -h --help
\t Shows available options.
\n\t Only one option is allowed.
'

function install_package_pacman {
    if [[ $1 != \#* ]] && [ -n "$1" ]; then
        if pacman -Qi $1 &>/dev/null; then
            log "WARN" "the package "$1" is already installed"
        else
            log "INFO" "installing package "$1" "
            sudo pacman -S --noconfirm --needed $1
        fi
    fi
}

function install_package_aur {
    if [[ $1 != \#* ]] && [ -n "$1" ]; then
        if paru -Qi $1 &>/dev/null; then
            log "WARN" "the package "$1" is already installed"
        else
            log "INFO" "installing package "$1" "
            paru -S --noconfirm --needed $1
        fi
    fi
}

while [ "$1" != "" ]; do
    case $1 in

    --qtile | -q)
        log "INFO" "installing qtile and arcolinux packages... please wait"
        cat 1_qtile.txt | while read y; do
            install_package_pacman $y
        done
        cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S)
        cp -arf /etc/skel/. ~
        log "INFO" "enabling sddm as display manager"
        sudo systemctl enable sddm.service -f
        log "INFO" "done, reboot your system"
        ;;

    --apps | -a)
        log "INFO" "installing apps... please wait"
        cat 2_apps.txt | while read y; do
            install_package_pacman $y
        done
        cat 3_aur.txt | while read y; do
            install_package_aur $y
        done
        log "INFO" "done"
        ;;
    
    --apps-work | -aw)
        log "INFO" "installing apps... please wait"
        cat 4_apps-work.txt | while read y; do
            install_package_pacman $y
        done
        cat 5_aur-work.txt | while read y; do
            install_package_aur $y
        done
        log "INFO" "done"
        ;;

    --laptop | -l)
        log "INFO" "installing laptop and bluetooth packages... please wait"
        cat 6_laptop.txt | while read y; do
            install_package_pacman $y
        done
        sudo systemctl enable tlp.service
        sudo systemctl enable bluetooth.service
        sudo systemctl start bluetooth.service
        sudo sed -i 's|#AutoEnable=false|AutoEnable=true|g' /etc/bluetooth/main.conf
        log "INFO" "done"
        ;;

    --printers | -p)
        log "INFO" "installing printers packages... please wait"
        cat 7_printers.txt | while read y; do
            install_package_pacman $y
        done
        sudo systemctl enable org.cups.cupsd.service
        log "INFO" "done"
        ;;

    --config | -c)
        log "INFO" "applying personal configuration... please wait"
        # change shell to zsh
        chsh -s /usr/bin/zsh
        # add pluging to pyenv
        git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
        # set up git
        git config --global user.name "Francisco Carpio"
        git config --global user.email "carpiofj@gmail.com"
        git config credential.helper store
        git config --global credential.helper store
        # set up docker
        sudo systemctl enable docker
        sudo systemctl start docker
        sudo usermod -aG docker $USER
        newgrp docker
        log "INFO" "done"
        ;;

    --help | -h)
        echo -e "${usage}"
        exit 1
        ;;
    *)
        echo -e "Invalid option $1 \n\n${usage}"
        exit 0
        ;;
    esac
    shift
done
