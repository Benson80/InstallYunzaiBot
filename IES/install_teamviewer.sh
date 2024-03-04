#!/bin/bash

# 下载 TeamViewer 安装包
echo "正在下载 TeamViewer 安装包..."
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb

# 安装 TeamViewer
echo "正在安装 TeamViewer..."
sudo dpkg -i teamviewer_amd64.deb

# 如果安装过程中出现依赖问题，尝试修复
sudo apt install -f

# 清理安装包
rm teamviewer_amd64.deb

echo "TeamViewer 安装完成。"
