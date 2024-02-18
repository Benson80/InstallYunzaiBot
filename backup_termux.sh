#!/bin/bash

# 检查是否运行过 termux-setup-storage
if [ ! -d "/data/data/com.termux/files/home/storage/shared" ]; then
    echo "请先运行 termux-setup-storage 来设置存储权限。"
    exit 1
fi

# 检查是否安装 rsync
if ! command -v rsync &> /dev/null; then
    echo "未找到 rsync，将安装..."
    pkg install rsync
    if [ $? -ne 0 ]; then
        echo "安装 rsync 失败，请检查网络连接和权限。"
        exit 1
    fi
    echo "rsync 安装成功。"
fi

# 检查是否安装 zip
if ! command -v zip &> /dev/null; then
    echo "未找到 zip，将安装..."
    pkg install zip
    if [ $? -ne 0 ]; then
        echo "安装 zip 失败，请检查网络连接和权限。"
        exit 1
    fi
    echo "zip 安装成功。"
fi

# 源地址
base_dir="/data/data/com.termux/files/home/Termux-Linux/Ubuntu/ubuntu-fs/root/"
source_dir="${base_dir}Miao-Yunzai"

# 检查源地址是否存在
if [ ! -d "$source_dir" ]; then
    echo "源地址 $source_dir 不存在，无需备份。"
    exit 1
fi

# 输入目标路径
read -p "请输入目标路径（已包含sdcard，例如：download）: " target_dir

# 拼接完整的目标路径
destination_dir="/sdcard/$target_dir"

# 创建目标路径的父级目录
mkdir -p "$destination_dir"

# 打包源目录
zip_filename="Miao-Yunzai_backup_$(date +'%Y%m%d_%H%M%S').zip"
cd "$base_dir" && zip -r "$zip_filename" "Miao-Yunzai"

# 查看压缩包大小
compressed_size=$(du -sh "$zip_filename" | awk '{print $1}')
echo "压缩包大小: $compressed_size"

read -p "按 Enter 键继续..."

# 复制打包文件到目标路径
rsync -av --progress "$zip_filename" "$destination_dir"

# 删除本地打包文件
rm "$zip_filename"

# 在目标路径解压缩备份文件
unzip "$destination_dir/$zip_filename" -d "$destination_dir"

echo "备份完成。"