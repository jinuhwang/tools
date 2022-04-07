!/bin/bash

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

if [ ! -d ~/.zfunc ]; then
    mkdir ~/.zfunc
fi

source $HOME/.cargo/env
rustup completions zsh > ~/.zfunc/_rustup

