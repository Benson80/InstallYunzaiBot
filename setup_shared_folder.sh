#!/bin/bash

# 安装Samba
sudo apt update
sudo apt install samba

# 创建共享文件夹
sudo mkdir -p /srv/share
sudo chmod -R 777 /srv/share  # 调整权限为可读写

# 配置Samba共享
sudo cat <<EOF >> /etc/samba/smb.conf
[share]
   comment = Shared Folder
   path = /srv/share
   browsable = yes
   guest ok = yes
   read only = no
   create mask = 0777
   directory mask = 0777
EOF

# 重新启动Samba服务
sudo systemctl restart smbd
