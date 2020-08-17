#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ln -s -f $DIR/zshrc $HOME/.zshrc
ln -s -f $DIR/vimrc $HOME/.vimrc
ln -s -f $DIR/tmux.conf $HOME/.tmux.conf
ln -s -f $DIR/gitconfig $HOME/.gitconfig
ln -s -f $DIR/nvmrc $HOME/.nvmrc

vim +PlugInstall +qall
