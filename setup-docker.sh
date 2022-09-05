#!/bin/bash

set -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# TODO: Link binaries, install fzf
if [ ! -d ~/bin ]; then
    mkdir ~/bin
fi

# Install packages
apt update && apt install -y --upgrade \
    build-essential \
    wget \
    zsh \
    tmux \
    tree \
    vim \
    curl \
    htop \
    less \
    software-properties-common

./dotfiles/copy_dotfiles.sh

# Install neovim
./vim/install-nvim.sh
./vim/install-nvim-plug.sh
nvim +PlugInstall +qall

# Download OMZ
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"

# Install Node
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# nvm install 'lts/*'
# nvm use 'lts/*'

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install

# Install rust and its tools
# ./rust/install-rust.sh
# ./rust/install-helix.sh
# ./rust/install-tools.sh
