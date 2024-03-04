#!/bin/bash

# 下载网易云音乐的 .deb 安装文件
wget http://d1.music.126.net/dmusic/netease-cloud-music_1.2.1_amd64_ubuntu_20190428.deb -O netease-cloud-music.deb

# 安装网易云音乐
sudo dpkg -i netease-cloud-music.deb

# 如果安装过程中有依赖问题，可以尝试修复
sudo apt-get -f install

# 清理安装文件
rm netease-cloud-music.deb

echo "网易云音乐安装完成！"
