mkdir /loop
mount -o loop /mnt/usbs/loop /loop
cd /loop
tar -xjf /mnt/usbs/root-filesystem-armv4l.tar.bz2
tar -xzf /mnt/usbs/debian_chroot.tgz
cd /
rm -Rf /loop/debian/etc/apt/sources.list
cp /mnt/usbs/sources.list /loop
mv /loop/sources.list /loop/debian/etc/apt/sources.list
