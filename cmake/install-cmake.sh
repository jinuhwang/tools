#!/bin/bash

apt install -y libssl-dev
curl -LO https://github.com/Kitware/CMake/releases/download/v3.18.1/cmake-3.18.1.tar.gz
tar xvzf cmake-3.18.1.tar.gz
cd cmake-3.18.1
./configure
make -j$(nproc)
make install
cd ..
