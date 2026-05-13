dd if=/dev/zero of=/mnt/usbs/swap.swap bs=1M count=512
mkswap /mnt/usbs/swap.swap
swapon /mnt/usbs/swap.swap
