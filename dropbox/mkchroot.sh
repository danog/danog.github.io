cd /mnt/usbs/
tar -xvjf root-filesystem-armv4l.tar.bz2
tar -xzf debian_chroot.tgz
cd /
rm -Rf /mnt/usbs/debian/etc/apt/sources.list
mv /mnt/usbs/sources.list /mnt/usbs/debian/etc/apt/sources.list
