#!/bin/bash

# 下载腾讯会议安装文件
wget https://updatecdn.meeting.qq.com/cos/bb4001c715553579a8b3e496233331d4/TencentMeeting_0300000000_3.19.0.401_x86_64_default.publish.deb -O tencent_meeting.deb

# 安装腾讯会议
sudo dpkg -i tencent_meeting.deb

# 如果安装过程中有依赖问题，可以尝试修复
sudo apt-get -f install

# 清理安装文件
rm tencent_meeting.deb

echo "腾讯会议安装完成！"
