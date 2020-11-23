#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# Copy dotfiles (Symbolic links are stale in the docker image, extract it to startup script later)

cp $DIR/zshrc $HOME/.zshrc
cp $DIR/vimrc $HOME/.vimrc
cp $DIR/tmux.conf $HOME/.tmux.conf
cp $DIR/gitconfig $HOME/.gitconfig
cp $DIR/p10k.zsh $HOME/.p10k.zsh
cp $DIR/nvmrc $HOME/.nvmrc

if [ ! -d "$HOME/.config/nvim" ]
then
    mkdir -p $HOME/.config/nvim
fi

cp $DIR/init.vim $HOME/.config/nvim/init.vim
cp $DIR/coc-settings.json $HOME/.config/nvim/coc-settings.json
cp $DIR/alacritty.yml $HOME/.alacritty.yml

nvim +PlugInstall +qall
nvim '+CocInstall -sync coc-marketplace coc-clangd coc-snippets' +qall
nvim '+CocCommand -sync clangd.install' +qall
