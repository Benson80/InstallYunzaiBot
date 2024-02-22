#!/bin/bash

# cpolar卸载脚本

# 停止cpolar服务
sudo systemctl stop cpolar

# 禁用cpolar服务开机自启动
sudo systemctl disable cpolar

# 卸载cpolar
sudo rm -rf /etc/cpolar /usr/local/bin/cpolar /var/lib/cpolar /lib/systemd/system/cpolar.service

# 删除cpolar相关配置文件
sudo rm -rf /etc/systemd/system/cpolar.service.d

# 删除cpolar用户及其主目录
sudo userdel -r cpolar

echo "cpolar已成功卸载。"