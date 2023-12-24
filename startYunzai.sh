#!/bin/bash

## 启动redis
redis-server --daemonize yes --save 900 1 --save 300 10

# 获取当前工作目录
current_directory=$(pwd)

# 云崽目录
cloud_directory="Miao-Yunzai"

# 检查是否在云崽目录下
if [ "$(basename $current_directory)" == "$cloud_directory" ]; then
  # 在云崽目录下启动云崽
  node app
else
  # 切换到云崽目录后启动云崽
  cd $cloud_directory && node app
fi
