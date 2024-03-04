#!/bin/bash

# 添加 uGet PPA 源并安装 uGet
sudo add-apt-repository ppa:plushuang-tw/uget-stable
sudo apt update
sudo apt install uget

# 安装 aria2
sudo apt install aria2

echo "uGet 和 aria2 安装完成！"
