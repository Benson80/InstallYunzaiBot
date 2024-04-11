#!/bin/bash

# 询问用户输入手机的 IP 地址
read -p "请输入手机的 IP 地址: " PHONE_IP

# 验证 IP 地址格式
if ! [[ $PHONE_IP =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
    echo "错误：输入的IP地址格式不正确。请重新输入。"
    exit 1
fi

# 设置用户名和端口号
USERNAME="root"
PORT="8022"

# SSH 连接命令
ssh -p $PORT $USERNAME@$PHONE_IP
