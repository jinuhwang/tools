# Disk Label
mklabel msdos == MBR
: support DOS-stype MBR partition tables

mklabel gpt == GPT
: support GUID partition tables

```
sudo parted
(parted) select /dev/sdb
# Show information
(parted) print
(parted) mklabel gpt
(parted) mkpart ext4 0% 100%
(parted) quit

lsblk

sudo mkfs.ext4 /dev/sdb1

df -h

sudo mount /dev/sdb1 /mnt/sdd1

df -h
```

# GPT Only
lsblk -o name,type,uuid

sudo vim /etc/fstab
