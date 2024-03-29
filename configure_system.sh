#!/bin/bash

# 创建 root 用户并设置密码为 123456
echo 'root:123456' | sudo chpasswd

# 修改 sshd_config 文件
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# 重启 SSH 服务
sudo systemctl restart ssh

# 更改 /root 目录的权限以便可视化读取（请谨慎使用，这可能会带来安全风险）
chmod -R 777 /root
