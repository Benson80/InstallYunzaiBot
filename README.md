# InstallYunzaiBot
云崽QQ机器人一键安装脚本
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
wget https://szrq2022.cf/startYunzai/init-termux.sh

bash init-termux.sh
### termux设置自动开启ssh
echo "sshd" >> ~/.bashrc
### 安装Linux
bash <(curl -sL https://szrq2022.cf/startYunzai/termux-install-linux.sh)
### 启动Ubuntu
bash <(curl -sL https://szrq2022.cf/startYunzai/start-ubuntu.sh)

cd Termux-Linux/Ubuntu

./start-ubuntu.sh

云崽QQ机器人一键安装脚本旨在优化安装流程，涵盖了安装依赖、启动和插件卸载等关键步骤。不论您是初学者还是经验丰富的用户，该脚本均旨在提供高效便捷的安装体验。它巧妙地集成了安装中文字体、安装ffmpeg等关键功能，为用户提供了更全面、专业的安装解决方案。通过简化繁琐的安装过程，这一脚本旨在确保用户能够轻松快速地部署和运行云崽QQ机器人，从而更专注于实际应用和使用体验。

apt-get update && apt-get install curl

curl -sS -o /root/installYunzai-Bot.sh https://raw.githubusercontent.com/Benson80/InstallYunzaiBot/main/installYunzai-Bot.sh && chmod +x /root/installYunzai-Bot.sh && /root/installYunzai-Bot.sh

官网版一键脚本

curl -sS -o /root/installYunzai-Bot.sh https://szrq2022.cf/startYunzai/installYunzai-Bot.sh && chmod +x /root/installYunzai-Bot.sh && /root/installYunzai-Bot.sh
