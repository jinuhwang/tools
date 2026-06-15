#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ln -s -f $DIR/zshrc $HOME/.zshrc
ln -s -f $DIR/tmux.conf $HOME/.tmux.conf
ln -s -f $DIR/gitconfig $HOME/.gitconfig
ln -s -f $DIR/bin/pbcopy $HOME/.local/bin/pbcopy

mkdir -p ~/.config
ln -sf $DIR/starship.toml $HOME/.config/starship.toml

rm -rf $HOME/.config/nvim
ln -s -f $DIR/config/nvim $HOME/.config/nvim

rm -rf $HOME/.config/efm-langserver
ln -s -f $DIR/config/efm-langserver $HOME/.config/efm-langserver

rm -rf $HOME/.config/i3
ln -s -f $DIR/config/i3 $HOME/.config/i3
