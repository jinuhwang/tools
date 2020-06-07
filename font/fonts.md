# My go-to font
Roboto Mono for Powerlines (Suggested by J1)

# Where to install fonts
Put `.ttf` files inside `/usr/local/share/fonts` and run `sudo fc-cache -f -v`.
Use `fc-list` to check installation.

# Troubleshooting
From ubuntu18.04, the terminal preference doesn't show non-monospace fonts.

After installing dconf-editor,
```
sudo apt install dconf-editor
```
edit `/org/gnome/terminal/legacy/profiles:/:<profile-id>/font` manually.
Solution from @egmont at [AskUbuntu](https://askubuntu.com/questions/1046871/nerd-font-not-fond-in-terminal-profile/)
