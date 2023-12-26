#!/bin/bash

# 检查是否已安装 rsync
if command -v rsync &> /dev/null
then
    echo "rsync 已安装"
    # 继续执行备份操作或其他操作
    # ...
else
    echo "rsync 未安装，请安装后再运行脚本。"
fi

# 获取源目录
source_directory=$(pwd)/Miao-Yunzai

# 从用户输入获取目标服务器信息
read -p "请输入目标服务器的IP地址: " target_ip
read -p "请输入目标服务器上的用户名: " target_username
read -p "请输入目标服务器上的备份路径: " target_path

# 构建目标服务器字符串
target_server="${target_username}@${target_ip}:${target_path}"

# 使用 rsync 进行备份
rsync -avz --delete "$source_directory" "$target_server"

# 检查 rsync 命令是否成功执行
if [ $? -eq 0 ]; then
    echo "备份成功！"
else
    echo "备份失败，请检查错误信息。"
fi