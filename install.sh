#!/bin/bash

install() {
    if [ -x "$(command -v apt-get)" ]; then
        sudo apt-get install "$1" -y
    elif [ -x "$(command -v pacman)" ]; then
        sudo pacman -S "$1"
    elif [ -x "$(command -v brew)" ]; then
        brew -S "$1"
    else
        echo "You don't appear to be using a package manager I know of, please install $1 manually"
    fi
}

install zsh
install tmux
install vim
install zoxide

chsh -s "$(command -v zsh)"

if [[ -f ~/.zshrc ]]; then
    mv ~/.zshrc ~/.zshrc.old
fi
if [[ -f ~/.tmux.conf ]]; then
    mv ~/.tmux.conf ~/.tmux.conf.old
fi
if [[ -f ~/.vimrc ]]; then
    mv ~/.vimrc ~/.vimrc.old
fi

echo "source $HOME/dotfiles/zsh/zshrc.sh" > ~/.zshrc
echo "source-file $HOME/dotfiles/tmux/tmux.conf" > ~/.tmux.conf
echo "so $HOME/dotfiles/vim/vimrc.vim" > ~/.vimrc
