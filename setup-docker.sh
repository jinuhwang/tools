#!/bin/bash

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
    software-properties-common

# To upgrade Vim
add-apt-repository ppa:jonathonf/vim -y
# Install packages
apt update && apt install -y --upgrade \
    vim


# Download Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"

# Install Node for coc.nvim
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# Install Vim Plugin
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
./dotfiles/copy_dotfiles.sh

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# Install ccls for coc.nvim
cd $DIR
./cmake/install-cmake.sh
./vim/ccls.sh

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install
