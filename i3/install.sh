#!/bin/bash

# Install rofi
# But I'm not using rofi at the moment
curl -sSLO https://github.com/davatorium/rofi/releases/download/1.6.1/rofi-1.6.1.tar.gz
tar xvzf rofi-1.6.1.tar.gz
cd rofi-1.6.1
mkdir build && cd build
sudo apt install -y \
    libglib2.0-dev \
    meson \
    libcario2-dev \
    libpango1.0-dev \
    libxkbcommon-dev \
    libgdk-pixbuf2.0-dev \
    libstartup-notification0-dev \
    libxkbcommon-x11-dev \
    libxkb-util-dev \
    libxcb-ewmh-dev \
    libxcb-icccm4-dev \
    libxcb-xrm-dev  \
    libxcb-xinerama0-dev \
    libxcb-xrandr0-dev \
    ninja

meson setup build
ninja -C build
sudo ninja -C build install

# Install polybar
# sudo apt install polybar nitrogen

# git clone https://github.com/unix121/i3wm-themer
# cd i3wm-themer/
# python3 -m pip install -r requirements.txt
# install_ubuntu.sh

