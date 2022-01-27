#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ln -s -f $DIR/zshrc $HOME/.zshrc
ln -s -f $DIR/tmux.conf $HOME/.tmux.conf
ln -s -f $DIR/gitconfig $HOME/.gitconfig
ln -s -f $DIR/alacritty $HOME/.alacritty

rm -rf $DIR/config/nvim
ln -s -f $DIR/config/nvim $HOME/.config/nvim
rm -rf $DIR/config/efm-langserver
ln -s -f $DIR/config/efm-langserver $HOME/.config/efm-langserver
rm -rf $DIR/config/qtile
ln -s -f $DIR/config/qtile $HOME/.config/qtile
