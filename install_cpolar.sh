#!/bin/bash

# cpolar安装脚本

# 下载并安装cpolar
curl -L https://www.cpolar.com/static/downloads/install-release-cpolar.sh | sudo bash

# 显示版本号
cpolar version

# 输入隧道 Authtoken
read -p "请输入隧道 Authtoken: " authtoken
cpolar authtoken $authtoken

# 配置为后台服务并开机自启动
sudo systemctl enable cpolar

# 启动服务
sudo systemctl start cpolar

# 查看服务状态
sudo systemctl status cpolar

# 提示登录cpolar Web UI管理界面
echo "请登录cpolar Web UI管理界面，访问 http://本地IP:9200，使用cpolar邮箱账号登录。"