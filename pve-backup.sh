#!/bin/bash
if [ -f /etc/pve-backup.env ] ; then
        source /etc/pve-backup.env
else
        echo "File /etc/pve-backup.env missing" > /dev/stderr
        exit 1
fi

if [ -d /etc/pve ]; then 
        main_dir="/etc/pve"
else
        main_dir="/etc/proxmox-backup"
fi

/usr/bin/proxmox-backup-client backup root.pxar:/ \
	--backup-id $(hostname -a) \
	--exclude /bin \
        --exclude /boot \
        --exclude /dev \
        --exclude /lib \
        --exclude /lib64 \
        --exclude /local-zfs \
        --exclude /lost+found \
        --exclude /mnt \
        --exclude /opt \
        --exclude /proc \
        --exclude /run \
        --exclude /sbin \
        --exclude /sys \
        --exclude /tmp \
        --exclude /usr \
        --exclude /var/lib/lxcfs \
        --exclude /var/lib/vz \
        --include-dev ${main_dir} \
        --backup-type host \
        --skip-lost-and-found
