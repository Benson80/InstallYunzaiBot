#!/bin/bash

# 获取最新版本的 FRP
FRP_LATEST_VERSION=$(curl -s https://api.github.com/repos/fatedier/frp/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
FRP_DOWNLOAD_URL="https://github.com/fatedier/frp/releases/download/${FRP_LATEST_VERSION}/frp_${FRP_LATEST_VERSION}_linux_amd64.tar.gz"

# 下载 FRP
echo "Downloading FRP ${FRP_LATEST_VERSION}..."
wget -q --show-progress $FRP_DOWNLOAD_URL -O frp.tar.gz

# 解压 FRP
echo "Extracting FRP..."
tar -xf frp.tar.gz

# 创建 FRP 目录并进入
mkdir -p "frp_${FRP_LATEST_VERSION}_linux_amd64" && cd "frp_${FRP_LATEST_VERSION}_linux_amd64"

# 提示用户输入 FRP 服务器的 IP 地址
read -p "Enter the FRP server IP address: " FRP_SERVER_IP

# 创建 FRP 配置文件
cat <<EOF > frpc.ini
[common]
server_addr = $FRP_SERVER_IP
server_port = 7000

[ssh]
type = tcp
local_ip = 127.0.0.1
local_port = 22
remote_port = 6000
EOF

# 启动 FRP
echo "Starting FRP..."
./frpc -c frpc.ini &

echo "FRP service started successfully."
