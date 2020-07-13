#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ ! -d ~/bin ]; then
    mkdir ~/bin
fi

apt-get install -y software-properties-common
# To upgrade Vim
add-apt-repository ppa:jonathonf/vim -y
add-apt-repository ppa:ubuntu-toolchain-r/test -y

update-alternatives \
    --install /usr/bin/gcc gcc /usr/bin/gcc-7 60 \
    --slave /usr/bin/gcc-ar gcc-ar /usr/bin/gcc-ar-7 \
    --slave /usr/bin/gcc-nm gcc-nm /usr/bin/gcc-nm-7 \
    --slave /usr/bin/gcc-ranlib gcc-ranlib /usr/bin/gcc-ranlib-7

update-alternatives \
    --install /usr/bin/g++ g++ /usr/bin/g++-7 60 \

# Install packages
apt update && apt install -y --upgrade \
    build-essential \
    g++-7 \
    htop \
    wget \
    less \
    zsh \
    tmux \
    tree \
    vim-gtk

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
