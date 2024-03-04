#!/bin/bash

# 下载百度网盘 Linux 客户端安装包
echo "正在下载百度网盘 Linux 客户端安装包..."
wget https://issuepcdn.baidupcs.com/issue/netdisk/LinuxGuanjia/4.17.7/baidunetdisk_4.17.7_amd64.deb

# 安装百度网盘 Linux 客户端
echo "正在安装百度网盘 Linux 客户端..."
sudo dpkg -i baidunetdisk_4.17.7_amd64.deb

# 完成
echo "百度网盘 Linux 客户端安装完成"
