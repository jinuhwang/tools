#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ ! -d "$HOME/bin" ]; then
    mkdir -p ~/bin
fi

cd ~/bin

curl -sSLO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
mv squashfs-root nvim.squashfs
ln -s -f nvim.squashfs/AppRun nvim
<<<<<<< HEAD
=======

if [ ! -d "$HOME/.config/nvim" ]; then
    mkdir -p $HOME/.config/nvim
fi

${DIR}/install-nvim-plug.sh

~/bin/nvim +PlugInstall +qall

# sudo npm install -g neovim
# gem install neovim
# python3 -m pip install --user --upgrade pynvim

>>>>>>> 1d69f46 (Fix nvim installation script)
