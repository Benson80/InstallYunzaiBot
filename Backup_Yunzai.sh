#!/bin/bash

# 检查是否已安装 rsync
if command -v rsync &> /dev/null; then
    echo "rsync 已安装"
else
    echo "安装 rsync"
    apt-get install rsync
fi

# 检查是否已安装 smbclient
if ! command -v smbclient &> /dev/null; then
    echo "安装 smbclient"
    apt-get install smbclient
fi

# 检查是否已安装 net-tools（ifconfig）和 iproute2（ip）
if ! command -v ifconfig &> /dev/null || ! command -v ip &> /dev/null; then
    echo "安装 net-tools 和 iproute2"
    apt-get install net-tools iproute2
fi

# 检查是否已安装 fuse
if ! command -v fusermount &> /dev/null; then
    echo "安装 fuse"
    apt-get install fuse
fi

# 获取源目录
source_directory=$(pwd)/Miao-Yunzai

# 从用户输入获取目标服务器信息
read -p "请输入目标服务器的IP地址: " target_ip
read -p "请输入目标服务器上的用户名: " target_username
read -p "请输入目标服务器上的共享文件夹名称: " target_share
read -s -p "请输入目标服务器上的用户密码: " target_password
echo

# 使用 smbclient 进行共享文件夹挂载
smbclient //$target_ip/$target_share -U $target_username%$target_password -c "mkdir /mnt/backup; exit"

# 获取网络接口名称（使用 ip 命令）
network_interface=$(ip -o link show | awk -F': ' '{print $2; exit}')

# 如果 network_interface 为空，尝试使用 ifconfig 命令
if [ -z "$network_interface" ]; then
    network_interface=$(ifconfig -a | grep -o '^[^ ]*' | awk 'NR==1{print $1}')
fi

# 使用 rsync 进行备份
rsync -avz --delete --info=progress2 --exclude='.git' --exclude='node_modules' --stats --rsh="ssh -o 'BindAddress=$network_interface'" "$source_directory" /mnt/backup

# 检查 rsync 命令是否成功执行
if [ $? -eq 0 ]; then
    echo "备份成功！"
else
    echo "备份失败，请检查错误信息。"
fi

# 使用 fusermount 进行卸载
fusermount -u /mnt/backup
