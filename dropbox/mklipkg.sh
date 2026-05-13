#!/bin/bash
mkdir -p /opt
dd if=/dev/zero of=/mnt/usbs/loopipkg bs=1M count=$1
mkfs.ext2 -F /mnt/usbs/loopipkg
mount -o loop /mnt/usbs/loopipkg /opt
cd /opt
feed=http://ipkg.nslu2-linux.org/feeds/optware/vt4/cross/unstable
ipk_name=`wget -qO- $feed/Packages | awk '/^Filename: ipkg-opt/ {print $2}'`
wget $feed/$ipk_name
tar -xOvzf $ipk_name ./data.tar.gz | tar -C / -xzvf -
mkdir -p /opt/etc/ipkg
echo "src cross $feed" > /opt/etc/ipkg/feeds.conf
export PATH=/opt/bin:/opt/sbin:/opt/usr/bin:/opt/usr/sbin:$PATH
ipkg update
echo "Done!!!"
