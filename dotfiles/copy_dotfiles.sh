#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# Copy dotfiles (Symbolic links are stale in the docker image, extract it to startup script later)

cp $DIR/zshrc $HOME/.zshrc
cp $DIR/tmux.conf $HOME/.tmux.conf
cp $DIR/gitconfig $HOME/.gitconfig
# cp $DIR/nvmrc $HOME/.nvmrc

if [ ! -d ~/.config ]; then
    mkdir ~/.config
fi
rm -rf $HOME/.config/nvim
cp -r $DIR/config/nvim $HOME/.config/nvim
rm -rf $HOME/.config/efm-langserver
cp -r $DIR/config/efm-langserver $HOME/.config/efm-langserver
