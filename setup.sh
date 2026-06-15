#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Install packages
sudo apt update
sudo apt install -y zsh curl git tmux ripgrep

# Link dotfiles
"$DIR/dotfiles/link_dotfiles.sh"

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install starship
curl -sS https://starship.rs/install.sh | sh -s -- --yes

# Install neovim
"$DIR/vim/install-nvim.sh"

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh
mkdir -p ~/.zfunc && uv generate-shell-completion zsh > ~/.zfunc/_uv

# Change default shell to zsh
chsh -s /usr/bin/zsh
