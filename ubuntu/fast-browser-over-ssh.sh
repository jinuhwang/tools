# Add Following line in /etc/ssh/sshd_confg https://www.reddit.com/r/archlinux/comments/9wf2nd/ssh_no_arcfour_cipher/
# Ciphers chacha20-poly1305@openssh.com
# chacha20 seems to be the fastest among available option
ssh -YC4c chacha20-poly1305@openssh.com jinu-aws firefox -no-remote

