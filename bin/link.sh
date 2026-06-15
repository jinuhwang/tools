#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

mkdir -p ~/.local/bin

for script in "$DIR"/*; do
    name=$(basename "$script")
    [[ "$name" == "link.sh" ]] && continue
    [[ "$name" == "pbcopy" && "$(uname)" == "Darwin" ]] && continue
    ln -sf "$script" "$HOME/.local/bin/$name"
    echo "linked: $name -> ~/.local/bin/$name"
done
