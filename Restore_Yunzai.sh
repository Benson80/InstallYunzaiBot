#!/bin/bash

while true; do
    # 获取备份服务器地址
    read -p "输入备份服务器地址： " backup_server

    # 获取备份服务器用户名
    # read -p "输入备份服务器用户名： " backup_username

    # 获取备份服务器上备份文件的路径
    read -p "输入备份文件路径： " backup_path

    start_time=$(date +%s)  # 记录开始时间

    # 执行还原操作
    echo "正在从 $backup_server 复制文件到 $target_server:$target_path ..."
    # scp -r "$backup_username@$backup_server:$backup_path" /root
    scp -r "administrator@$backup_server:$backup_path" /root
    # mv /root/backup/Miao-Yunzai /root
    # rm -rf backup

    end_time=$(date +%s)  # 记录结束时间
    elapsed_time=$((end_time - start_time))  # 计算执行时间

    # 检查 scp 命令的退出状态
    if [ $? -eq 0 ]; then
        echo "还原成功完成。"
        echo "总共用时: $elapsed_time 秒"
        break  # 如果成功则退出循环
    else
        echo "还原失败。请检查输入并重试。"
        read -p "是否重新输入？(y/n): " retry
        if [ "$retry" != "y" ]; then
            echo "退出脚本。"
            exit 1
        fi
    fi
done
