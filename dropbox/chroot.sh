mount -o bind /proc /mnt/usbs/debian/proc
mount -o bind /dev /mnt/usbs/debian/dev
mount -o bind /sys /mnt/usbs/debian/sys
export PATH=/mnt/usbs/root-filesystem-armv4l/sbin:/usr/sbin:/bin:/usr/bin:/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/hddapp/bin:/usr/hddapp/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/syno/bin:/usr/syno/sbin:/usr/local/bin:/usr/local/sbin:/mnt/usbs/root-filesystem-armv4l/bin:/mnt/usbs/debian/bin:/mnt/usbs/debian/sbin:/mnt/usbs/debian/usr/bin:/mnt/usbs/debian/usr/sbin
chroot /mnt/usbs/debian
