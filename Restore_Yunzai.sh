#!/bin/bash

# 获取备份服务器地址
read -p "输入备份服务器地址： " backup_server

# 获取备份服务器用户名
read -p "输入备份服务器用户名： " backup_username

# 获取备份服务器上备份文件的路径
read -p "输入备份文件路径： " backup_path

# 执行还原操作
echo "正在从 $backup_server 复制文件到 $target_server:$target_path ..."
scp -r "$backup_username@$backup_server:$backup_path" /root
mv /root/backup/Miao-Yunzai /root
rm -rf backup

# 检查 scp 命令的退出状态
if [ $? -eq 0 ]; then
    echo "还原成功完成。"
else
    echo "还原失败。请检查输入并重试。"
fi