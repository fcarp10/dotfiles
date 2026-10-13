#!/bin/zsh

alias aliases='function _get_alias(){ grep -r alias $HOME/.config/zsh/.zshrc.d/aliases.zsh | grep -v \# |  grep alias; };_get_alias'

## mappings ##
alias l='lsd'
alias ls='lsd'
alias lla='lsd -la'
alias ll='lsd -l'
alias l.='lsd -d .* --color=auto'
alias cat='bat'
alias ..='cd ..'
alias ...='cd ../../'
alias nv='nvim'
alias mkdir='mkdir -p'

## pacman ##
alias pac-orphans='sudo pacman -Qtdq | sudo pacman -Rns -'
alias pac-optional='sudo pacman -Qttdq | sudo pacman -Rns -'
alias pac-find='function _find-pacman(){ pacman -Qi | grep Name | grep $1;};_find-pacman'
alias pac-installed='grep -i installed /var/log/pacman.log'
alias pac-upgraded='grep -i upgraded /var/log/pacman.log'
alias pac-mirrors='sudo reflector --country Germany --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
alias pac-explicit='comm -23 <(paru -Qqett | sort) <(paru -Qqg base-devel | sort | uniq)'
alias pac-aur='sudo pacman -Qqm'

## docker ##
alias docker-rmct='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
alias docker-rmimg='docker rmi -f $(docker images -a -q)'

## git ##
alias git-clean-branches='git fetch --prune && git branch -vv | grep 'gone]' | awk "{print $1}" | xargs git branch -D'
alias git-delete-merged-branches='git branch --merged | grep -v '^\*\|main\|master' | xargs git branch -d'

## utils ##
alias burn-img='function _burn_img(){sudo dd if=$1 of=$2 status=progress; };_burn_img'
alias color-picker='grim -g "$(slurp -p)" -t ppm - | convert - -format "%[pixel:p{0,0}]" txt:-'

## apps ##
alias steam-hdr='gamescope --fullscreen -w 2560 -h 1440 -r 360 --adaptive-sync --hdr-enabled --hdr-debug-force-output --hdr-sdr-content-nits 450 --steam -- env ENABLE_GAMESCOPE_WSI=1 steam -bigpicture'
alias llama='llama-server -hf yuxinlu1/gemma-4-12B-agentic-fable5-composer2.5-v2-3.5x-tau2-GGUF:Q6_K -c 64000 --n-gpu-layers 99 --no-mmap -fa on --jinja --temp 1.0 --top-p 0.95 --top-k 64 --host 127.0.0.1 --port 8033'