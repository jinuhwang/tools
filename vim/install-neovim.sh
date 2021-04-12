#!/bin/bash

# ./nvim.appimage --appimage-extract
if [ ! -d "$HOME/bin" ]; then
    mkdir -p ~/bin
fi
cd ~/bin
curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o nvim
chmod u+x nvim

# Optional: exposing nvim globally
# mv squashfs-root ~/bin && sudo ln -f -s ~/bin/squashfs-root/AppRun /usr/bin/nvim

if [ ! -d "$HOME/.config/nvim" ]
    mkdir -p $HOME/.config/nvim
fi

./install-nvim-plug.sh

sudo npm install -g neovim
gem install neovim
python3 -m pip install --user --upgrade pynvim

