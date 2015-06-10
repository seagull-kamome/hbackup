#!/bin/sh

target=$1
mountpoint=/mnt/BlueRose/Backup
seq=`date +%Y%m%d`

mount -t cifs -o iocharset=utf8,user=backupofficer,password=backupofficer \
    //BlueRose.local/Backup ${mountpoint} && \
    tar cj \
      -g ${mountpoint}/${target}/`echo ${seq}|cut -c 1-4`.state \
      -f ${mountpoint}/${target}/${seq}.tar.bz2 \
      -C / \
      --acls --xattrs --selinux --preserve-permissions \
      -X ${mountpoint}/${target}/00.ignore \
      -T ${mountpoint}/${target}/00.targets \
      2>&1 >>/var/log/backup.log

umount /mnt/BlueRose/Backup

exit 0

