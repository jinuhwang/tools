#!/usr/bin/env bash
set -e

mkdir -p ~/bin

if [[ "$(uname)" == "Darwin" ]]; then
    if brew list neovim &>/dev/null 2>&1; then
        brew upgrade neovim
    else
        brew install neovim
    fi
else
    ARCH=$(uname -m)
    case "$ARCH" in
        x86_64)  TARBALL="nvim-linux-x86_64.tar.gz" ;;
        aarch64) TARBALL="nvim-linux-arm64.tar.gz" ;;
        *) echo "Unsupported arch: $ARCH"; exit 1 ;;
    esac

    cd ~/bin
    curl -sSLO "https://github.com/neovim/neovim/releases/download/nightly/$TARBALL"
    rm -rf nvim-linux-*
    tar xzf "$TARBALL"
    rm -f "$TARBALL"
    ln -sf "${TARBALL%.tar.gz}/bin/nvim" ~/bin/nvim
fi
