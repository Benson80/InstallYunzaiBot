#!/bin/bash

# 重启 PulseAudio 服务
pulseaudio -k

# 终止所有 pulseaudio 进程
killall pulseaudio

# 启动 PulseAudio 服务
pulseaudio &

echo "PulseAudio service has been restarted."
