# Dotfiles

Repository for dotfiles.

Tutorial on: https://www.atlassian.com/git/tutorials/dotfiles

## Initial configuration
Creates a folder in `$HOME` and adds an alias to `zsh`:
```
git init --bare $HOME/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc
```

## Add files

Example of how to add a file:
```
config status
config add .zshrc
config commit -m "Add zshrc"
config push
```
