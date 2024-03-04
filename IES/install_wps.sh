#!/bin/bash

# 下载 WPS Office 安装包
echo "正在下载 WPS Office 安装包..."
wget https://benson80.eu.org/wps-office_11.1.0.11719_amd64.deb

# 安装 WPS Office
echo "正在安装 WPS Office..."
sudo dpkg -i wps-office_11.1.0.11719_amd64.deb

# 如果安装过程中出现依赖问题，尝试修复
sudo apt install -f

# 清理安装包
rm wps-office_11.1.0.11719_amd64.deb

echo "WPS Office 安装完成。"
