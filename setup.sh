DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ -d ~/bin ]; then
    mkdir ~/bin
fi

# Install packages
add-apt-repository ppa:jonathonf/vim
apt update && apt install -y \
    build-essential \
    zsh \
    tmux

# Download Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"

# Copy dotfiles (Symbolic links are stale in the docker image, extract it to startup script later)
cp $DIR/dotfiles/zshrc $HOME/.zshrc
cp $DIR/dotfiles/vimrc $HOME/.vimrc
cp $DIR/dotfiles/tmux.conf $HOME/.tmux.conf
cp $DIR/dotfiles/gitconfig $HOME/.gitconfig

# Install Node for coc.nvim
curl -sL install-node.now.sh/lts | bash

# Install Vim Plugin
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# Install ccls for coc.nvim
sh $DIR/vim/ccls.sh
