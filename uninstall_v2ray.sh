#!/bin/bash

# 检查系统环境
if [ -n "$TERMUX_VERSION" ]; then
    # 在 Termux 环境中执行的脚本

    # 检查是否已安装 v2ray、jq 和 screen
    if command -v v2ray &> /dev/null || command -v jq &> /dev/null || command -v screen &> /dev/null; then
        # 已安装，提示用户是否卸载
        read -p "v2ray、jq 和 screen 已安装，是否要卸载？(Y/N): " uninstall_confirm
        if [ "$uninstall_confirm" == "Y" ] || [ "$uninstall_confirm" == "y" ]; then
            # 使用 pkg 卸载软件包
            pkg uninstall -y v2ray jq screen -y
            echo "v2ray、jq 和 screen 已卸载."
        else
            echo "用户取消卸载，未进行任何操作."
        fi
    else
        echo "v2ray、jq 和 screen 未安装，跳过卸载步骤."
    fi

    # 继续执行其他 Termux 相关命令...
else
    # 在 Ubuntu 或其他 Linux 环境中执行的脚本

    # 检查是否已安装 jq、screen 和 unzip
    if command -v jq &> /dev/null || command -v screen &> /dev/null || command -v unzip &> /dev/null; then
        # 已安装，提示用户是否卸载
        read -p "jq、screen 和 unzip 已安装，是否要卸载？(Y/N): " uninstall_confirm
        if [ "$uninstall_confirm" == "Y" ] || [ "$uninstall_confirm" == "y" ]; then
            # 使用 apt 卸载软件包
            apt-get remove --purge jq screen unzip -y
            echo "jq、screen 和 unzip 已卸载."
        else
            echo "用户取消卸载，未进行任何操作."
        fi
    else
        echo "jq、screen 和 unzip 未安装，跳过卸载步骤."
    fi

    # 继续执行其他 Ubuntu 相关命令...
fi