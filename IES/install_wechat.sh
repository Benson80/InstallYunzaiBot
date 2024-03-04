#!/bin/bash

# 下载并安装 Wine
wget http://archive.ubuntukylin.com/software/pool/partner/ukylin-wine_70.6.3.25_amd64.deb -O wine.deb
sudo dpkg -i wine.deb
sudo apt install -f
rm wine.deb

# 下载并安装 微信
wget http://archive.ubuntukylin.com/software/pool/partner/ukylin-wechat_3.0.0_amd64.deb -O wechat.deb
sudo dpkg -i wechat.deb
sudo apt install -f
rm wechat.deb

echo "微信安装完成。"
