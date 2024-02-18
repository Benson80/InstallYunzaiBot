#!/bin/bash

if [ -n "$TERMUX_VERSION" ]; then
    # 在 Termux 环境中执行的脚本

    # 提示用户设置存储权限
    read -p "在继续之前，请确保你已经在 Termux 中执行了 termux-setup-storage 命令，并授予存储权限。按Y继续，按其他键退出：" confirm
    if [ "$confirm" != "Y" ] && [ "$confirm" != "y" ]; then
        echo "用户取消，退出脚本。"
        exit 1
    fi

    # 检查是否已安装 v2ray、jq 和 screen
    if ! command -v v2ray &> /dev/null || ! command -v jq &> /dev/null || ! command -v screen &> /dev/null; then
       # 使用 pkg 安装必要的软件包
       pkg install -y v2ray jq screen
    else
       echo "v2ray、jq 和 screen 已安装，跳过安装步骤."
    fi

    # 搜索并复制 config.json 文件
    config_files=$(find /sdcard/Download -name "config.json")

    # 判断是否找到文件
    if [ -n "$config_files" ]; then
        # 找到文件，选择一个并复制到 Ubuntu 目录
        selected_config=$(echo "$config_files" | head -n 1)  # 选择第一个找到的文件

        # 复制文件到 Ubuntu 目录
        cp "$selected_config" /data/data/com.termux/files/home/Termux-Linux/Ubuntu/ubuntu-fs/root/

        echo "已复制 config.json 文件到 /root 目录。"

        # 启动 V2Ray
        v2ray run -c "$config_files"
    else
        # 没有找到文件
        echo "未找到 config.json 文件。"
    fi
else
    # 在 Ubuntu 或其他 Linux 环境中执行的脚本

    # 检查是否已安装 jq、screen 和 unzip
    if ! command -v jq &> /dev/null || ! command -v screen &> /dev/null || ! command -v unzip &> /dev/null; then
       # 使用 apt 安装必要的软件包
       apt-get update
       apt-get install -y jq screen unzip
    else
       echo "jq、screen 和 unzip 已安装，跳过安装步骤."
    fi

    # 创建 V2Ray 安装目录
    mkdir -p ~/v2ray

    # 进入 V2Ray 安装目录
    cd ~/v2ray

    # 检查是否已存在 v2ray-linux-arm64-v8a.zip，如果不存在则下载
    if [ ! -f "v2ray-linux-arm64-v8a.zip" ]; then
       # 下载 V2Ray 执行文件
       curl -OL https://github.com/Benson80/InstallYunzaiBot/raw/main/v2ray/v2ray-linux-arm64-v8a.zip
    else
       echo "v2ray-linux-arm64-v8a.zip 已存在，跳过下载步骤."
    fi

    # 解压下载的文件
    unzip v2ray-linux-arm64-v8a.zip -d /usr/local/bin/

    # 提示用户输入配置文件路径，按回车则使用默认路径
    read -p "请输入 config.json 配置文件的路径（默认为 /root/config.json）: " user_config_path

    # 使用用户输入的路径，如果没有输入则使用默认路径
    config_path=${user_config_path:-"/root/config.json"}

    # 检查输入的路径是否存在
    if [ -f "$config_path" ]; then
        # 设置配置文件权限为只允许拥有者读取和写入
        chmod 600 "$config_path"

        # 启动 V2Ray
        v2ray run -c "$config_path"
    else
        echo "错误：指定的配置文件路径不存在或不可读。"
    fi
fi