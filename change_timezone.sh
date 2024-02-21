#!/bin/bash

# 设置新的时区
new_timezone='Asia/Shanghai'  # 将 'Asia/Shanghai' 替换为您所在地区的正确时区

# 打印当前时间和时区
echo "当前时间和时区："
date

# 打印当前时区
echo "当前时区："
timedatectl | grep "Time zone"

# 设置新的时区
sudo timedatectl set-timezone "$new_timezone"

# 打印新的时间和时区
echo "修改后的时间和时区："
date

# 打印新的时区
echo "新的时区："
timedatectl | grep "Time zone"