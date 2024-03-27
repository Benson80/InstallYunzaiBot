#!/bin/bash

# 停止服务
sudo systemctl stop qsign.service

# 禁用服务
sudo systemctl disable qsign.service

# 删除服务文件
sudo rm /etc/systemd/system/qsign.service

# 重新加载 systemd 配置
sudo systemctl daemon-reload

echo "qsign 服务已成功卸载。"
