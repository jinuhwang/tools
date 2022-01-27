#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ln -s -f $DIR/zshrc $HOME/.zshrc
ln -s -f $DIR/tmux.conf $HOME/.tmux.conf
ln -s -f $DIR/gitconfig $HOME/.gitconfig
ln -s -f $DIR/alacritty $HOME/.alacritty

if [ ! -d ~/.config ]; then
    mkdir ~/.config
fi
rm -rf $HOME/.config/nvim
ln -s -f $DIR/config/nvim $HOME/.config/nvim
rm -rf $HOME/.config/efm-langserver
ln -s -f $DIR/config/efm-langserver $HOME/.config/efm-langserver
rm -rf $HOME/.config/qtile
ln -s -f $DIR/config/qtile $HOME/.config/qtile
