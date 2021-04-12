#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# ./nvim.appimage --appimage-extract
if [ ! -d "$HOME/bin" ]; then
    mkdir -p ~/bin
fi
cd ~/bin
curl -SLO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
nvim.appimage --appimage-extract
rm nvim.appimage
mv squashfs-root nvim.squashfs-root
ln -s -f nvim.squashfs-root/AppRun nvim

if [ ! -d "$HOME/.config/nvim" ]; then
    mkdir -p $HOME/.config/nvim
fi

sh ${DIR}/install-nvim-plug.sh

nvim +PlugInstall +qa

ln -s -f $DIR/../dotfiles/init.vim $HOME/.config/nvim/init.vim
nvim +PlugInstall

# sudo npm install -g neovim
# gem install neovim
# python3 -m pip install --user --upgrade pynvim

