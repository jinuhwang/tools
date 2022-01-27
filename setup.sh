#!/bin/bash

set -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Create bin directory
if [ ! -d ~/bin ]; then
    mkdir ~/bin
fi

# Install packages
sudo apt update
sudo apt install -y --upgrade
    build-essential \
    wget \
    tmux \
    tree \
    curl \
    software-properties-common

# Link dotfiles
./dotfiles/link_dotfiles.sh

# Install neovim
./vim/install-nvim.sh
./vim/install-nvim-plug.sh
nvim +PlugInstall +qall

# Download OMZ and starship
sudo apt install -y --upgrade zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
sh -c "$(curl -fsSL https://starship.rs/install.sh) -y"

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install

chsh --shell /usr/bin/zsh
zsh
