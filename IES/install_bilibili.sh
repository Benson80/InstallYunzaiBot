#!/bin/bash

# 检查系统架构
architecture=$(dpkg --print-architecture)

# 设置默认的下载链接
download_link="https://github.com/msojocs/bilibili-linux/releases/download/v1.13.0-2/io.github.msojocs.bilibili_1.13.0-2_amd64.deb"

# 如果架构是 ARM64，则使用 ARM64 的下载链接
if [ "$architecture" = "arm64" ]; then
    download_link="https://github.com/msojocs/bilibili-linux/releases/download/v1.13.0-2/io.github.msojocs.bilibili_1.13.0-2_arm64.deb"
fi

# 下载 B 站客户端安装包
wget "$download_link" -O bilibili.deb

# 安装 B 站客户端
sudo dpkg -i bilibili.deb

# 清理下载的安装包
rm bilibili.deb

echo "B站客户端安装完成。"
