#!/bin/bash

while true; do
    # 获取目标服务器地址
    read -p "输入目标服务器地址： " target_server

    # 获取用户名
    # read -p "输入用户名： " username

    # 获取目标路径
    read -p "输入服务器上的目标路径： " target_path

    # 记录开始时间
    start_time=$(date +%s)

    # 执行备份操作
    echo "正在备份文件到 $target_server:$target_path ..."
    time scp -r /root/Miao-Yunzai/ "administrator@$target_server:$target_path"
    # scp -r /root/Miao-Yunzai/ administrator@192.168.1.154:/D:/vm
	
    # 记录结束时间
    end_time=$(date +%s)

    # 计算备份所花费的时间
    elapsed_time=$((end_time - start_time))

    # 检查 scp 命令的退出状态
    if [ $? -eq 0 ]; then
        echo "备份成功完成。"
        echo "备份所花费的时间：$elapsed_time 秒"
        break  # 如果备份成功，退出循环
    else
        echo "备份失败。请检查输入并重试。"
        
        # 提示用户选择是否重新输入
        read -p "是否重新输入？(y/n): " retry_input
        if [ "$retry_input" != "y" ]; then
            echo "退出脚本。"
            exit 1
        fi
    fi
done
