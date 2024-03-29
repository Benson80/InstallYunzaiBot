#!/bin/bash

# 创建 root 用户并设置密码为 123456
echo 'root:123456' | sudo chpasswd

# 修改 sshd_config 文件
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# 重启 SSH 服务
sudo systemctl restart ssh
