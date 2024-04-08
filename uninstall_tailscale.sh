#!/bin/bash

# 停止 Tailscale 服务
sudo tailscale down

# 删除 Tailscale 可执行文件
sudo rm -f /usr/bin/tailscale

# 删除 Tailscale 数据目录
sudo rm -rf ~/.tailscale

echo "Tailscale 已成功卸载。"
