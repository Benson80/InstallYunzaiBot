#!/bin/bash

# 安装必要的软件包
pkg install -y proot git python

# 克隆 termux-install-linux 仓库
git clone https://github.com/sqlsec/termux-install-linux

# 切换到 termux-install-linux 目录
cd termux-install-linux

# 运行 termux-linux-install.py 脚本
python termux-linux-install.py
