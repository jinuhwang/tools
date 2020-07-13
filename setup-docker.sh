#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# TODO: Link binaries, install fzf
if [ ! -d ~/bin ]; then
    mkdir ~/bin
fi

# To upgrade Vim
add-apt-repository ppa:jonathonf/vim -y

# Install packages
apt update && apt install -y --upgrade \
    build-essential \
    wget \
    zsh \
    tmux \
    tree \
    vim

# Download Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"

# Copy dotfiles (Symbolic links are stale in the docker image, extract it to startup script later)
cp $DIR/dotfiles/zshrc $HOME/.zshrc
cp $DIR/dotfiles/vimrc $HOME/.vimrc
cp $DIR/dotfiles/tmux.conf $HOME/.tmux.conf
cp $DIR/dotfiles/gitconfig $HOME/.gitconfig
cp $DIR/dotfiles/p10k.zsh $HOME/.p10k.zsh

# Install Node for coc.nvim
curl -sL install-node.now.sh/lts | bash -s -- -y

# Install Vim Plugin
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# Install ccls for coc.nvim
cd $DIR
./cmake/install-cmake.sh
./vim/ccls.sh

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install
