Use `xmodmap -e 'command'` to try out remapping
Then, write the command into `~/.Xmodmap`.

inside ~/.xinitrc, add
```
[ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi
```

To check keycode and name, use `xev`.
To check current mapping, run `xrandr`.

