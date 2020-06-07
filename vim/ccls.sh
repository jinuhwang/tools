apt install zlib1g-dev libncurses-dev
git clone --depth=1 --recursive https://github.com/MaskRay/ccls
cd ccls

wget -c http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
tar xf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$PWD/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04
cmake --build Release
cp Release/ccls $HOME/bin/ccls
# https://github.com/MaskRay/ccls/wiki/coc.nvim
