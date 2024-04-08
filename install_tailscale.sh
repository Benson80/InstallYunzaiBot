#!/bin/bash

# 下载并运行 Tailscale 安装脚本
curl -fsSL https://tailscale.com/install.sh | sudo sh

# 启动 Tailscale 并连接到服务
sudo tailscale up

# 查看 Tailscale 状态
tailscale status
