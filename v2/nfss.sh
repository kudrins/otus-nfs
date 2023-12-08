#!/bin/bash

# устанавливаем утилиты nfs
yum install -y nfs-utils

# включаем firewall
systemctl enable firewalld --now

# разрешаем в firewall доступ к сервисам NFS
firewall-cmd --add-service="nfs3" --add-service="rpc-bind"  --add-service="mountd" --permanent
firewall-cmd --reload

# включаем сервер NFS
systemctl enable nfs --now

# создаём и настраиваем директорию, которая будет экспортирована
mkdir -p /srv/share/upload
chown -R nfsnobody:nfsnobody /srv/share
chmod 777 /srv/share/upload

# создаём в файле /etc/exports структуру, которая позволит экспортировать ранее созданную директорию
echo "/srv/share 192.168.50.11/32(rw,sync,root_squash)" > /etc/exports

# экспортируем ранее созданную директорию
exportfs -r