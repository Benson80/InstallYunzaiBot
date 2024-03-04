#!/bin/bash

# 下载 QQ Linux 版安装包
wget https://dldir1.qq.com/qqfile/qq/QQNT/ad5b5393/linuxqq_3.1.2-13107_amd64.deb -O qq.deb

# 安装 QQ Linux 版
sudo dpkg -i qq.deb

# 如果安装过程中出现依赖问题，尝试修复
sudo apt install -f

# 清理安装包
rm qq.deb

echo "QQ Linux版安装完成。"
