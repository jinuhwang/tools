#!/bin/bash

sudo apt update
sudo apt install snapd
sudo snap install --edge nvim --classic
sudo ln -s -f /snap/bin/nvim /usr/bin/nvim 


if [ ! -d "$HOME/.config/nvim" ]
    mkdir -p $HOME/.config/nvim

ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

sudo npm install -g neovim
gem install neovim
python3 -m pip install --user --upgrade pynvim
