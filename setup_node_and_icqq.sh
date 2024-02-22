#!/bin/bash

# 检查系统是否已安装 Node.js
if ! command -v node &> /dev/null; then
    echo "安装 Node.js ..."
    # 使用包管理器安装 Node.js，这里使用的是 Node.js 官方提供的安装脚本
    curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
    sudo apt-get install -y nodejs
    echo "Node.js 安装完成"
else
    echo "Node.js 已经安装"
fi

# 检查系统是否已安装 pnpm
if ! command -v pnpm &> /dev/null; then
    echo "安装 pnpm ..."
    # 使用 npm 安装 pnpm
    npm install -g pnpm
    echo "pnpm 安装完成"
else
    echo "pnpm 已经安装"
fi

cd "$(pwd)/Miao-Yunzai" || exit 1

# 使用 pnpm 安装 icqq 模块
echo "安装 icqq 模块 ..."
pnpm install icqq -w
echo "icqq 模块安装完成"
