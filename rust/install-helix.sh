#!/bin/bash

git clone https://github.com/helix-editor/helix
pushd helix
cargo install --path helix-term
hx --grammar fetch
hx --grammar build
ln -s `pwd`/runtime ~/.config/helix
popd