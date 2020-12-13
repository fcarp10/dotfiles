# Dotfiles and Arch Linux ARM configuration for the Pinephone

Repository for dotfiles and Arch Linux configuration script.

## Arch Linux ARM configuration

Instructions [here](https://github.com/fcarp10/dotfiles-pinephone/blob/master/.script-config/README.md) 

## Dotfiles configuration 

### Initial configuration
Creates a folder in `$HOME` and adds an alias to `zsh`:
```
git init --bare $HOME/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc
```

### Add files

Example of how to add a file:
```
config status
config add .zshrc
config commit -m "Add zshrc"
config push
```

### Apply configuration to existing installation

1. Add the next alias to `.zsh`:
    ```
    echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc
    ```
2. Clone the dotfiles repository:
    ```
    git clone --bare https://github.com/fcarp10/dotfiles $HOME/.dotfiles
    ```
3. Make sure you delete or backup all conflicting files. Then, checkout the content from the repository to `$HOME`:
    ```
    config checkout
    ```
4. Set flag `showUntrackedFiles` on this specific local repository:
    ```
    config config --local status.showUntrackedFiles no
    ```
    
- For more details go [here](https://www.atlassian.com/git/tutorials/dotfiles)
