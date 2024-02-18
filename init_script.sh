#!/bin/bash

# 1. 启用 Termux Wake Lock
termux-wake-lock

# 2. 更改 Termux 软件源
termux-change-repo

# 3. 更新软件包
pkg update -y

# 4. 安装 wget
pkg install wget -y

# 5. 下载 init-termux.sh
wget https://szrq2022.cf/startYunzai/init-termux.sh

# 6. 运行 init-termux.sh
bash init-termux.sh

# 7. 将 "sshd" 添加到 ~/.bashrc
echo "sshd" >> ~/.bashrc

# 8. 安装 Linux 子系统
bash <(curl -sL https://szrq2022.cf/startYunzai/termux-install-linux.sh)

# 9. 启动 Ubuntu
bash <(curl -sL https://szrq2022.cf/startYunzai/start-ubuntu.sh)