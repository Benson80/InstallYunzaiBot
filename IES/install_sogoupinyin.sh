#!/bin/bash

# 下载搜狗输入法安装包
echo "正在下载搜狗输入法安装包..."
wget https://benson80.eu.org/sogoupinyin_4.2.1.145_amd64.deb

# 安装搜狗输入法
echo "正在安装搜狗输入法..."
sudo dpkg -i sogoupinyin_4.2.1.145_amd64.deb

# 如果安装过程中出现依赖问题，尝试修复
sudo apt install -f

# 清理安装包
rm sogoupinyin_4.2.1.145_amd64.deb

echo "搜狗输入法安装完成。"
