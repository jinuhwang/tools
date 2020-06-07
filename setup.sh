DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Install packages
apt update && apt install -y --no-install-recommends \
    build-essential \
    zsh \
    tmux

# Copy dotfiles (Symbolic links are stale in the docker image, extract it to startup script later)
cp $DIR/dotfiles/zshrc $HOME/.zshrc
cp $DIR/dotfiles/vimrc $HOME/.vimrc
cp $DIR/dotfiles/tmux.conf $HOME/.tmux.conf
cp $DIR/dotfiles/gitconfig $HOME/.gitconfig


# Install Vim Plugin
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

# Setup Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
