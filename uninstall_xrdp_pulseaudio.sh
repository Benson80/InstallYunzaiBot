#!/bin/bash

# 停止 xrdp 服务
sudo systemctl stop xrdp
sudo systemctl disable xrdp

# 卸载 xrdp
sudo apt purge xrdp -y
sudo apt autoremove -y

# 停止 PulseAudio 服务
pulseaudio -k

# 卸载 PulseAudio
sudo apt purge pulseaudio -y
sudo apt autoremove -y

# 删除相关文件夹和文件
sudo rm -rf /var/lib/xrdp-pulseaudio-installer
sudo rm -rf /etc/xrdp
sudo rm -rf ~/.config/pulse
sudo rm -rf ~/.pulse

echo "xrdp and PulseAudio have been completely uninstalled."
