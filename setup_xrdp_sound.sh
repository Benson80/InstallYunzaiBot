#!/bin/bash

# 更新软件包并安装 xrdp
apt update
apt install -y xrdp

# 检查 xrdp 服务状态
#service xrdp status

# 升级系统
apt update
apt upgrade -y

# 安装依赖软件包
apt-get install software-properties-common -y
apt-get install git libpulse-dev autoconf m4 intltool dpkg-dev libtool libsndfile-dev libcap-dev libjson-c-dev make gcc curl wget -y

# 安装 PulseAudio
apt-get install pulseaudio -y

# 安装 PulseAudio 编译依赖
apt-get build-dep pulseaudio -y

# 下载 PulseAudio 源代码
apt source pulseaudio

# 进入 PulseAudio 源代码目录
cd pulseaudio-*/

# 配置 PulseAudio
./configure

# 返回上级目录
cd ../

# 下载和安装 pulseaudio-module-xrdp
git clone https://github.com/neutrinolabs/pulseaudio-module-xrdp.git
cd pulseaudio-module-xrdp
./bootstrap
./configure PULSE_DIR="/root/pulseaudio-13.99.1"

# 编译 pulseaudio-module-xrdp
make

# 将模块文件安装到相应位置
cd src/.libs
install -t "/var/lib/xrdp-pulseaudio-installer" -D -m 644 *.so
install -t "/usr/lib/pulse-13.99.1/modules" -D -m 644 *.so

echo "xrdp with sound enabled is now running."
echo "Please restart your Ubuntu for changes to take effect."
