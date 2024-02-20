#!/bin/bash

# 安装 OpenSSH
pkg install -y openssh

# 更改密码
passwd

# 启动 SSH 服务
sshd
