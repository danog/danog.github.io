mkdir /loop
mount -o loop /mnt/usbs/loop /loop
mount -o bind /proc /loop/debian/proc
mount -o bind /dev /loop/debian/dev
mount -o bind /sys /loop/debian/sys
export PATH=/loop/root-filesystem-armv4l/usr/sbin:/usr/sbin:/bin:/usr/bin:/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/hddapp/bin:/usr/hddapp/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/syno/bin:/usr/syno/sbin:/usr/local/bin:/usr/local/sbin:/loop/root-filesystem-armv4l/bin:/loop/debian/bin:/loop/debian/sbin:/loop/debian/usr/bin:/loop/debian/usr/sbin
chroot /loop/debian