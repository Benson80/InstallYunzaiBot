#!/bin/bash

# 获取目标服务器地址
read -p "输入目标服务器地址： " target_server

# 获取用户名
read -p "输入用户名： " username

# 获取目标路径
read -p "输入服务器上的目标路径： " target_path

# 执行备份操作
echo "正在备份文件到 $target_server:$target_path ..."
scp -r /root/Miao-Yunzai/ "$username@$target_server:$target_path"
# scp -r /root/Miao-Yunzai/ administrator@192.168.1.154:/D:/vm

# 检查 scp 命令的退出状态
if [ $? -eq 0 ]; then
    echo "备份成功完成。"
else
    echo "备份失败。请检查输入并重试。"
fi