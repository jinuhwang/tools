#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# Copy dotfiles (Symbolic links are stale in the docker image, extract it to startup script later)

cp $DIR/zshrc $HOME/.zshrc
cp $DIR/vimrc $HOME/.vimrc
cp $DIR/tmux.conf $HOME/.tmux.conf
cp $DIR/gitconfig $HOME/.gitconfig
cp $DIR/p10k.zsh $HOME/.p10k.zsh

vim +PlugInstall +qall
