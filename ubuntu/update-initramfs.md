# Check following directory to completely remove kernel entry
/var/lib/initramfs-tools

> `update-initramfs -d -k <version>`
> 
> will remove the entry in /var/lib/initramfs-tools and the image in /boot in one go, just fyi:)
