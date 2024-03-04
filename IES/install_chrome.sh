#!/bin/bash

# 下载 Google Chrome 安装包
echo "正在下载 Google Chrome 安装包..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# 如果下载失败，尝试使用国内镜像站点下载
if [ $? -ne 0 ]; then
    echo "尝试使用国内镜像站点下载 Google Chrome..."
    wget https://benson80.eu.org/google-chrome-stable_current_amd64.deb
fi

# 安装 Google Chrome
echo "正在安装 Google Chrome..."
sudo dpkg -i google-chrome-stable_current_amd64.deb

# 完成
echo "Google Chrome 安装完成"