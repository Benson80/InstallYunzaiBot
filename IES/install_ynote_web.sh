#!/bin/bash

# 下载软件包
wget https://artifact.lx.netease.com/download/ynote-electron/%E6%9C%89%E9%81%93%E4%BA%91%E7%AC%94%E8%AE%B0-web.deb -O ynote_web.deb

# 安装软件包
sudo dpkg -i ynote_web.deb

# 如果安装过程中有依赖问题，可以尝试修复
sudo apt-get -f install

# 清理安装文件
rm ynote_web.deb

echo "有道云笔记Web版安装完成！"
