#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Create bin directories
mkdir -p ~/.local/bin ~/bin ~/.zfunc

# Install packages
sudo apt update
sudo apt install -y zsh curl git tmux ripgrep

# Link dotfiles
"$DIR/dotfiles/link_dotfiles.sh"

# Link tools
"$DIR/bin/link.sh"

# Install or update Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    git -C "$HOME/.oh-my-zsh" pull
fi

# Install or update starship
curl -sS https://starship.rs/install.sh | sh -s -- --yes

# Install or update neovim
"$DIR/vim/install-nvim.sh"

# Install or update fzf
if [ ! -d ~/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
else
    git -C ~/.fzf pull
fi
~/.fzf/install --all

# Install or update uv
curl -LsSf https://astral.sh/uv/install.sh | sh
uv generate-shell-completion zsh > ~/.zfunc/_uv

# Change default shell to zsh
chsh -s /usr/bin/zsh
