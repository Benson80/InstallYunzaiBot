#!/bin/bash

# 提示用户是否要卸载 Tailscale
read -p "是否要卸载 Tailscale 软件包及其相关配置和数据？(y/n): " choice

if [[ $choice =~ ^[Yy]$ ]]; then
    # 停止 Tailscale 服务
    sudo tailscale down

    # 卸载 Tailscale 软件包
    sudo apt purge tailscale tailscale-archive-keyring

    # 删除 Tailscale 数据目录
    sudo rm -rf ~/.tailscale

    echo "Tailscale 已成功卸载。"
else
    echo "取消卸载操作。"
fi
