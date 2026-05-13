#!/bin/bash
mkdir -p /opt
mount -o loop /mnt/usbs/loopipkg /opt
export PATH=/opt/bin:/opt/sbin:/opt/usr/bin:/opt/usr/sbin:$PATH
ipkg $*

