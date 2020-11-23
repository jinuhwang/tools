#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ln -s -f $DIR/zshrc $HOME/.zshrc
ln -s -f $DIR/vimrc $HOME/.vimrc
ln -s -f $DIR/tmux.conf $HOME/.tmux.conf
ln -s -f $DIR/gitconfig $HOME/.gitconfig
ln -s -f $DIR/nvmrc $HOME/.nvmrc
ln -s -f $DIR/vimrc $HOME/.vimrc

if [ ! -d "$HOME/.config/nvim" ]
then
    mkdir -p $HOME/.config/nvim
fi

ln -s -f $DIR/init.vim $HOME/.config/nvim/init.vim
ln -s -f $DIR/coc-settings.json $HOME/.config/nvim/coc-settings.json
ln -s -f $DIR/alacritty.yml $HOME/.alacritty.yml

nvim +PlugInstall +qall
nvim '+CocInstall -sync coc-marketplace coc-clangd coc-snippets' +qall
nvim '+CocCommand -sync clangd.install' +qall
