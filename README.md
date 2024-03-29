# InstallYunzaiBot
云崽QQ机器人一键安装脚本

Script: 云崽机器人一键安装脚本 （支持Ubuntu系统）

Author: Benson Sun

Version: 1.0.0

Date: 2023-12-26

Version: 1.0.1  2023-12-27

增加2个菜单项：1. 修改配置文件

2.备份或还原云崽

Version: 1.0.2  2023-12-30

增加2个功能：查看已安装的云崽插件和云崽多开

Version: 1.0.3 2024-1-3

增加一键签名服务和备份Miao-Yunzai到手机存储

Version: 1.0.4 2024-1-5

增加一键安装v2ray

Version: 1.0.5 2024-1-9

增加一键卸载v2ray

Version: 1.0.6 2024-1-24

增加创建或删除交换文件

添加DNS

Version: 1.0.7 2024-1-28

增加安装Ubuntu桌面、安装VNC和安装并启动v2rayA

Version: 1.0.8 2024-1-29

增加安装cpolar内网穿透

Version: 1.0.9 2024-1-31

增加一键重装系统

Version: 1.1.0 2024-2-29

增加安装必备软件（B站客户端、QQ Linux版、wine版微信、百度网盘、金山WPS和VLC视频播放器等）
![image](https://github.com/Benson80/InstallYunzaiBot/assets/81787444/99c360b8-d5d8-48ff-b1af-e24ff2f5a283)
## Termux安装并启动云崽机器人
### 保持设备唤醒状态
termux-wake-lock
### 更换镜像源为清华源
termux-change-repo
### 更新软件包
pkg update
### 安装wget
pkg install wget
### 初始化Termux
wget http://szrq.hkfree.work/startYunzai/init-termux.sh

wget https://github.com/Benson80/InstallYunzaiBot/raw/main/init-termux.sh

bash init-termux.sh
### termux设置自动开启ssh
echo "sshd" >> ~/.bashrc
### 安装Linux
bash <(curl -sL http://szrq.hkfree.work/startYunzai/termux-install-linux.sh)

bash <(curl -sL https://github.com/Benson80/InstallYunzaiBot/raw/main/termux-install-linux.sh)
### 启动Ubuntu
bash <(curl -sL http://szrq.hkfree.work/startYunzai/start-ubuntu.sh)

bash <(curl -sL https://github.com/Benson80/InstallYunzaiBot/raw/main/start-ubuntu.sh)

cd Termux-Linux/Ubuntu

./start-ubuntu.sh
### 一键安装并启动Ubuntu
bash <(curl -sL http://szrq.hkfree.work/startYunzai/init_script.sh)

bash <(curl -sL https://github.com/Benson80/InstallYunzaiBot/raw/main/init_script.sh)
### 备份Miao-Yunzai到手机存储
bash <(curl -sL http://szrq.hkfree.work/startYunzai/backup_termux.sh)

bash <(curl -sL https://github.com/Benson80/InstallYunzaiBot/raw/main/backup_termux.sh)
### 一键安装v2ray
bash <(curl -sL http://szrq.hkfree.work/startYunzai/install_v2ray_cn.sh)

bash <(curl -sL https://github.com/Benson80/InstallYunzaiBot/raw/main/install_v2ray.sh)
### 一键卸载v2ray
bash <(curl -sL http://szrq.hkfree.work/startYunzai/uninstall_v2ray.sh)

bash <(curl -sL https://github.com/Benson80/InstallYunzaiBot/raw/main/uninstall_v2ray.sh)

修改config.json配置文件，可以参考官方文档，或者参考配置模板https://github.com/v2fly/v2ray-examples ，或者从其他客户端导出一份配置文档。

![image](https://github.com/Benson80/InstallYunzaiBot/assets/81787444/8ed99010-73ea-44f1-a520-390a3d05d8e7)

后台运行用screen

#screen新建v2窗口，注意一下config.json路径。

screen -S v2

v2ray run -c ~/config.json

#恢复窗口，即可查看运行状态，按Ctrl+A+D即可后台运行。

screen -r v2

使用termux运行，当然也要保证termux正常后台运行，以免影响黑屏联网，除了要加入电池优化白名单，最好允许后台运行。

#后台运行

termux-wake-lock

#恢复

termux-wake-unlock

设置系统代理，如果是wifi，直接在已连接的wifi，修改，高级设置，手动代理，代理设置成127.0.0.1，端口就是config.json设置的端口。

如果是移动数据，就需要添加apn，代理设置成127.0.0.1，端口就是config.json设置的端口。

云崽QQ机器人一键安装脚本旨在优化安装流程，涵盖了安装依赖、启动和插件卸载等关键步骤。不论您是初学者还是经验丰富的用户，该脚本均旨在提供高效便捷的安装体验。它巧妙地集成了安装中文字体、安装ffmpeg等关键功能，为用户提供了更全面、专业的安装解决方案。通过简化繁琐的安装过程，这一脚本旨在确保用户能够轻松快速地部署和运行云崽QQ机器人，从而更专注于实际应用和使用体验。

apt-get update && apt-get install curl -y

curl -sS -o /root/installYunzai-Bot.sh https://raw.githubusercontent.com/Benson80/InstallYunzaiBot/main/installYunzai-Bot.sh && chmod +x /root/installYunzai-Bot.sh && /root/installYunzai-Bot.sh

官网版一键脚本

curl -sS -o /root/installYunzai-Bot_cn.sh http://szrq.hkfree.work/startYunzai/installYunzai-Bot_cn.sh && chmod +x /root/installYunzai-Bot_cn.sh && /root/installYunzai-Bot_cn.sh
### 一键配置 SSH
bash <(curl -sL http://szrq.hkfree.work/startYunzai/configure_system.sh)

bash <(curl -sL https://github.com/Benson80/InstallYunzaiBot/raw/main/configure_system.sh)
