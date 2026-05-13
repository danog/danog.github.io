#!/bin/ash
ln -s /mnt/usbs/opt /opt
export PATH=/opt/bin:/opt/sbin:/opt/usr/bin:/opt/usr/sbin:$PATH
ipkg update
ipkg $*
