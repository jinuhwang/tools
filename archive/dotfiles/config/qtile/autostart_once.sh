#!/usr/bin/env bash

# festival --tts $HOME/.config/qtile/welcome_msg &
xmodmap $HOME/settings/tools/dotfiles/Xmodmap
lxsession &
picom &
# conky -c $HOME/.config/conky/doomone-qtile.conkyrc
# volumeicon &
nm-applet &
fcitx &

### UNCOMMENT ONLY ONE OF THE FOLLOWING THREE OPTIONS! ###
# 1. Uncomment to restore last saved wallpaper
# xargs xwallpaper --stretch < ~/.xwallpaper &
# 2. Uncomment to set a random wallpaper on login
find /home/jinu/settings/wallpapers -name "*.jpg" -type f | shuf -n 1 | xargs nitrogen --set-scaled &
# 3. Uncomment to set wallpaper with nitrogen
# nitrogen --restore &
