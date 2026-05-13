#!/bin/ash
mkdir -p /opt
mkdir -p /mnt/usbs/opt
ln -s /mnt/usbs/opt /opt
cd /opt
feed=http://ipkg.nslu2-linux.org/feeds/optware/vt4/cross/unstable
ipk_name=`wget -qO- $feed/Packages | awk '/^Filename: ipkg-opt/ {print $2}'`
wget $feed/$ipk_name
tar -xOvzf $ipk_name ./data.tar.gz | tar -C / -xzvf -
mkdir -p /opt/etc/ipkg
echo "src cross $feed" > /opt/etc/ipkg/feeds.conf
export PATH=/opt/bin:/opt/sbin:/opt/usr/bin:/opt/usr/sbin:$PATH
ipkg update

