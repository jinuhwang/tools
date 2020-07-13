apt install -y libssl-dev
curl -LO https://github.com/Kitware/CMake/releases/download/v3.17.3/cmake-3.17.3.tar.gz
tar xvzf cmake-3.17.3.tar.gz
cd cmake-3.17.3
./configure
make -j$(nproc)
make install

