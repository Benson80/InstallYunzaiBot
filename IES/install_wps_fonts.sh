#!/bin/bash

# 下载 wps-fonts.zip
echo "正在下载 wps-fonts.zip..."
wget http://szrq.hkfree.work/startYunzai/IES/wps-fonts.jpg
mv wps-fonts.jpg wps-fonts.zip

# 创建目录并解压 wps-fonts.zip
echo "正在解压 wps-fonts.zip..."
mkdir wps-fonts
unzip wps-fonts.zip -d wps-fonts

# 进入解压目录
cd wps-fonts

# 复制文件到系统字体存放位置
echo "正在复制文件到系统字体存放位置..."
sudo cp * /usr/share/fonts

# 生成索引信息
echo "生成索引信息..."
sudo mkfontscale
sudo mkfontdir

# 更新字体缓存
echo "更新字体缓存..."
sudo fc-cache

echo "字体安装完成。"