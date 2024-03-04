#!/bin/bash

# 获取系统已安装的软件列表
installed_packages=$(dpkg --get-selections | grep -v deinstall | cut -f1)

# 循环卸载每个软件包
for package in $installed_packages; do
    # 判断软件包是否来自第三方源（例如 PPA）
    if [[ $(apt-cache policy $package | grep 'http.*ppa') ]]; then
        # 如果是第三方源，则卸载软件包
        sudo apt purge -y $package
    fi
done

echo "所有第三方软件已被卸载！"
