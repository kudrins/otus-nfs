#!/bin/bash

# устанавливаем утилиты nfs
yum install -y nfs-utils

# включаем firewall
systemctl enable firewalld --now
#
echo "192.168.50.10:/srv/share/ /mnt nfs vers=3,proto=udp 0 0" >> /etc/fstab
#
systemctl daemon-reload
systemctl restart remote-fs.target