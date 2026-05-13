#!/bin/bash
mkdir /loop
mount -o loop /mnt/usbs/loop /loop
mount -t proc none /loop/debian/proc 
mount -o bind /dev /loop/debian/dev
mount -o bind /sys /loop/debian/sys
export PATH=$PATH:/loop/debian/bin:/loop/debian/sbin:/loop/debian/usr/bin:/loop/debian/usr/sbin
chroot /loop/debian
