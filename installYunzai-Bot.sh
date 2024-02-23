#!/bin/bash
ln -sf ~/installYunzai-Bot.sh /usr/local/bin/s

# Script: 云崽机器人一键安装脚本 （支持Ubuntu系统）
# Author: Benson Sun
# Version: 1.0.9
# Date: 2024-1-31

SWAPFILE="/swapfile"
SWAPSIZE="2G"

function create_swap() {
    # Check if swapfile already exists
    if [ -e "$SWAPFILE" ]; then
        echo "交换文件已存在。退出。"
        exit 1
    fi

    # 为交换文件分配空间
    sudo fallocate -l $SWAPSIZE $SWAPFILE

    # 设置权限
    sudo chmod 600 $SWAPFILE

    # 格式化为交换区
    sudo mkswap $SWAPFILE

    # 激活交换文件
    sudo swapon $SWAPFILE

    # 在 /etc/fstab 中添加条目，以在启动时自动激活
    echo "$SWAPFILE none swap sw 0 0" | sudo tee -a /etc/fstab

    echo "交换文件创建并成功激活。"
}

function delete_swap() {
    # 检查交换文件是否存在
    if [ ! -e "$SWAPFILE" ]; then
        echo "交换文件不存在。退出。"
        exit 1
    fi

    # 停用并移除交换文件
    sudo swapoff $SWAPFILE
    sudo rm $SWAPFILE

    # 从 /etc/fstab 中删除相关条目
    sudo sed -i "\~$SWAPFILE~d" /etc/fstab

    echo "交换文件已成功删除。"
}

while true; do
    clear
    echo " __   ___       __   __           __            "
	echo "|__) |__  |\ | /__\` /  \\ |\ |    /__\` |  | |\ | "
	echo "|__) |___ | \| .__/ \\__/ | \|    .__/ \\__/ | \| "
	echo
    echo "云崽机器人一键安装脚本 （支持Ubuntu系统）"
	echo -e "-输入s可快速启动此脚本-"
    echo "-------------------------------------------"
    echo "1. 安装云崽v3.0"
    echo "2. 卸载云崽"
    echo "3. 安装Node.js"
	echo "4. 安装依赖"
	echo "5. 解决puppeteer Chromium启动失败"
    echo "6. 安装、卸载或更新icqq"
    echo "7. 安装中文字体"
    echo "8. 安装ffmpeg"
    echo "9. 修改配置文件"
    echo "10. 启动云崽机器人"
    echo "11. 重新启动云崽"
    echo "12. 安装或卸载云崽插件"
    echo "13. 备份或还原云崽"
    echo "14. 云崽多开"
    echo "15. 一键快速配置Qsign服务"
    echo "16. 一键安装或卸载v2ray"
    echo "17. 创建或删除交换文件"
    echo "18. 添加DNS"
    echo "19. 修改时区"
    echo "20. 安装Ubuntu桌面"
	echo "21. VNC 功能菜单"
	echo "22. 安装Google Chrome浏览器"
    echo "23. 安装cpolar内网穿透"
    echo "24. 安装并启动v2rayA"
    echo "25. 查看系统信息"
	echo "26. 一键重装系统"
    echo "-------------------------------------------"
    echo "0. 退出脚本"
    echo "-------------------------------------------"
    
    read -p "请输入你的选择：" choice

    case $choice in
        1)
            echo "执行安装云崽v3.0的命令"
			# 切换到 root 目录
            cd /root
			if command -v git &> /dev/null
               then
               echo "Git 已安装，跳过安装步骤"
            else
               echo "正在安装 Git"
               apt-get install -y git
            fi
			# 删除已存在的 Miao-Yunzai 目录
            if [ -d "Miao-Yunzai" ]
               then
               echo "删除已存在的 Miao-Yunzai 目录"
               rm -rf Miao-Yunzai
            fi
            git clone --depth=1 https://gitee.com/yoimiya-kokomi/Miao-Yunzai.git
            cd Miao-Yunzai 
            git clone --depth=1 https://gitee.com/yoimiya-kokomi/miao-plugin.git ./plugins/miao-plugin/
            ;;
        2)
            echo "执行卸载云崽的命令"
            # 切换到 root 目录
            cd /root
			# 删除已存在的 Miao-Yunzai 目录
            if [ -d "Miao-Yunzai" ]
               then
               echo "删除已存在的 Miao-Yunzai 目录"
               rm -rf Miao-Yunzai
            fi
            read -p "按 Enter 键继续..."
            ;;
        3)
            echo "执行安装Node.js的命令"
			# 安装 NVM
            export NVM_SOURCE=https://gitlab.com/mirrorx/nvm.git
            curl -o- https://gitlab.com/mirrorx/nvm/-/raw/master/install.sh | bash

            # 加载 NVM
            export NVM_DIR="$HOME/.nvm"
            [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

            # 指定要安装的 Node.js 版本
            NODE_VERSION="17"

            # 检查是否已经安装了 Node.js
            if command -v node &> /dev/null; then
               INSTALLED_VERSION=$(node -v)
               if [[ $INSTALLED_VERSION == "v$NODE_VERSION"* ]]; then
                  echo "Node.js $NODE_VERSION 已安装，跳过安装步骤"
               else
                  echo "Node.js 已安装，但版本不是 $NODE_VERSION"
                  echo "正在卸载现有 Node.js 版本..."
                  nvm uninstall $INSTALLED_VERSION  # 使用 nvm 卸载已安装的版本
                  echo "正在安装 Node.js $NODE_VERSION 使用 NVM"
                  nvm install $NODE_VERSION
                  nvm use 17.9.1
               fi
            else
                  echo "Node.js 未安装，正在安装 Node.js $NODE_VERSION 使用 NVM"
                  nvm install $NODE_VERSION
                  nvm use 17.9.1
            fi

            # 验证安装
            echo "Node.js 版本：$(node -v)"
            echo "npm 版本：$(npm -v)"

            read -p "按 Enter 键继续..."
            ;;
		4)
            echo "执行安装依赖的命令"
            # 检查是否已经安装了 npm
            if command -v npm &> /dev/null
               then
               echo "npm 已安装，跳过安装步骤"
            else
               echo "正在安装 npm"
               apt install -y npm
            fi
            npm config set registry https://registry.npmjs.org/
            npm install pnpm -g
            pnpm install -P
			read -p "按 Enter 键继续..."
            ;;
        5)
            echo "解决puppeteer Chromium启动失败"
			if [ "$(basename "$(pwd)")" == "Miao-Yunzai" ]; then
               echo "当前目录已经是 Miao-Yunzai"
            else
               echo "进入 Miao-Yunzai 目录"
               cd "$(pwd)/Miao-Yunzai" || exit 1
            fi
            # 检查是否已安装 chromium-browser
            if ! command -v chromium-browser &> /dev/null
               then
               echo "安装 chromium-browser"
               apt-get install chromium-browser
            else
               echo "chromium-browser 已经安装，跳过安装步骤"
            fi
            pnpm uninstall puppeteer
            pnpm install puppeteer -w
			read -p "按 Enter 键继续..."
            ;;
		6)
		    while true; do
                clear
                echo "安装、卸载或更新icqq"
                echo "-------------------------"
                echo "1. 安装icqq"
                echo "2. 卸载icqq"
                echo "3. 更新icqq"
                echo "-------------------------"
                echo "0. 返回上级菜单"
                echo "-------------------------"
                read -p "请输入你的选择：" plugin_choice

                case $plugin_choice in
                     1)
                        echo "执行安装icqq的命令"
			            if [ "$(basename "$(pwd)")" == "Miao-Yunzai" ]; then
                           echo "当前目录已经是 Miao-Yunzai"
                        else
                           echo "进入 Miao-Yunzai 目录"
                           cd "$(pwd)/Miao-Yunzai" || exit 1
                        fi
                        pnpm install icqq -w
			            read -p "按 Enter 键继续..."
                        ;;
                    2)
                       echo "执行卸载icqq的命令"
			            if [ "$(basename "$(pwd)")" == "Miao-Yunzai" ]; then
                           echo "当前目录已经是 Miao-Yunzai"
                        else
                           echo "进入 Miao-Yunzai 目录"
                           cd "$(pwd)/Miao-Yunzai" || exit 1
                        fi
                        pnpm uninstall icqq
			            read -p "按 Enter 键继续..."
                       ;;
                    3)
                       echo "执行更新icqq的命令"
			           if [ "$(basename "$(pwd)")" == "Miao-Yunzai" ]; then
                          echo "当前目录已经是 Miao-Yunzai"
                       else
                          echo "进入 Miao-Yunzai 目录"
                          cd "$(pwd)/Miao-Yunzai" || exit 1
                       fi
                       pnpm update icqq
			           read -p "按 Enter 键继续..."
                       ;;
                    0)
                        break
                        ;;
                    *)
                        echo "无效的选择，请重新输入"
                        ;;
                esac

            done
            ;;
        7)
            echo "执行安装中文字体的命令"
            sudo apt-get install ttf-wqy-zenhei
			read -p "按 Enter 键继续..."
            ;;
        8)
            echo "执行安装ffmpeg的命令"
            cd &&git clone https://gitee.com/GanYu256/ffmpeg-install ~/ffmpeg-install
            cd ~/ffmpeg-install
            bash install.sh
			read -p "按 Enter 键继续..."
            ;;
        9)
            while true; do
                clear
                echo "修改配置文件"
                echo "-------------------------"
                echo "1. 修改bot.yaml文件"
                echo "2. 修改qq.yaml文件"
                echo "3. 修改redis.yaml文件"
                echo "-------------------------"
                echo "0. 返回上级菜单"
                echo "-------------------------"
                read -p "请输入你的选择：" plugin_choice
                
                case $plugin_choice in
                     1)
                        echo "执行修改bot.yaml文件的命令"
			            # 检查 Vim 是否已安装
                        if command -v vim &> /dev/null
                           then
                           echo "Vim 已安装"
                        else
                           apt-get install vim
                        fi
                        config_file="/root/Miao-Yunzai/config/config/bot.yaml"
                        # 检查文件是否存在
                        if [ -e "$config_file" ]; then
                           echo "找到配置文件 $config_file"
                           # 打开 Vim 编辑文件
                           vim "$config_file"
                        else
                           echo "配置文件 $config_file 不存在，请检查路径是否正确。"
                        fi
                        read -p "按 Enter 键继续..."
                        ;;
                    2)
                        echo "执行修改qq.yaml文件的命令"
			            # 检查 Vim 是否已安装
                        if command -v vim &> /dev/null
                           then
                           echo "Vim 已安装"
                        else
                           apt-get install vim
                        fi
                        config_file="/root/Miao-Yunzai/config/config/qq.yaml"
                        # 检查文件是否存在
                        if [ -e "$config_file" ]; then
                           echo "找到配置文件 $config_file"
                           # 打开 Vim 编辑文件
                           vim "$config_file"
                        else
                           echo "配置文件 $config_file 不存在，请检查路径是否正确。"
                        fi
                        read -p "按 Enter 键继续..."
                        ;;
                    3)
                        echo "执行修改redis.yaml文件的命令"
			            # 检查 Vim 是否已安装
                        if command -v vim &> /dev/null
                           then
                           echo "Vim 已安装"
                        else
                           apt-get install vim
                        fi
                        config_file="/root/Miao-Yunzai/config/config/redis.yaml"
                        # 检查文件是否存在
                        if [ -e "$config_file" ]; then
                           echo "找到配置文件 $config_file"
                           # 打开 Vim 编辑文件
                           vim "$config_file"
                        else
                           echo "配置文件 $config_file 不存在，请检查路径是否正确。"
                        fi
                        read -p "按 Enter 键继续..."
                        ;;
                    0)
                        break
                        ;;
                    *)
                        echo "无效的选择，请重新输入"
                        ;;
                esac

            done
            ;;
            
        10)
            echo "执行启动云崽机器人的命令"
			apt-get install redis-server -y
			# 获取当前目录
            current_directory="$(pwd)"
            target_directory="Miao-Yunzai"
            # 检查当前目录是否是目标目录
            if [ "$(basename "$current_directory")" == "$target_directory" ]; then
               echo "当前目录已经是 $target_directory"
               cd /root || exit 1  # 切换到 root 目录
            else
               echo "当前目录不是 $target_directory"
            fi
            bash <(curl -sL https://github.com/Benson80/InstallYunzaiBot/raw/main/setup_node_and_icqq.sh)
            curl -sS -o /root/startYunzai.sh https://github.com/Benson80/InstallYunzaiBot/raw/main/startYunzai.sh && chmod +x /root/startYunzai.sh && /root/startYunzai.sh
            read -p "按 Enter 键继续..."
            ;;
        11)
            echo "执行重新启动云崽的命令"
            if [ "$(basename "$(pwd)")" == "Miao-Yunzai" ]; then
               echo "当前目录已经是 Miao-Yunzai"
            else
               echo "进入 Miao-Yunzai 目录"
               cd /root/Miao-Yunzai
            fi
            node app login
            cd
            ;;
        12)
            while true; do
                clear
                echo "云崽QQ机器人插件"
                echo "-------------------------"
                echo "1. 安装锅巴插件"
                echo "2. 安装ChatGPT插件"
                echo "3. 安装椰奶插件"
                echo "4. 安装枫叶插件"
                echo "5. 安装阴天插件"
                echo "6. 安装土块插件"
				echo "7. 卸载锅巴插件"
				echo "8. 卸载ChatGPT插件"
				echo "9. 卸载椰奶插件"
				echo "10. 卸载枫叶插件"
				echo "11. 卸载阴天插件"
				echo "12. 卸载土块插件"
				echo "13. 查看已安装的云崽插件"
                echo "-------------------------"
                echo "0. 返回上级菜单"
                echo "-------------------------"
                
                read -p "请输入你的选择：" plugin_choice

                case $plugin_choice in
                    1)
                        echo "执行安装锅巴插件的命令"
						# 判断是否存在 Miao-Yunzai 目录
                        if [ -d "/root/Miao-Yunzai" ]; then
                           # 如果 Guoba-Plugin 目录存在，则删除它
                           if [ -d "/root/Miao-Yunzai/plugins/Guoba-Plugin" ]; then
                              rm -rf /root/Miao-Yunzai/plugins/Guoba-Plugin
                              echo "已删除 Guoba-Plugin 目录"
                           else
                              echo "Guoba-Plugin 目录不存在"
                           fi
                        fi
						cd /root/Miao-Yunzai
                        git clone --depth=1 https://gitee.com/guoba-yunzai/guoba-plugin.git ./plugins/Guoba-Plugin/
                        pnpm install --filter=guoba-plugin
						read -n 1 -s -r -p "按任意键继续..."
                        ;;
                    2)
                        echo "执行安装ChatGPT插件的命令"
						# 判断是否存在Miao-Yunzai目录
                        if [ -d "/root/Miao-Yunzai" ]; then
						   # 如果 chatgpt-plugin 目录存在，则删除它
						   if [ -d "/root/Miao-Yunzai/plugins/chatgpt-plugin" ]; then
                              rm -rf /root/Miao-Yunzai/plugins/chatgpt-plugin
							  echo "已删除 chatgpt-plugin 目录"
						   else
                              echo "chatgpt-plugin 目录不存在"
                           fi
                        fi
						cd /root/Miao-Yunzai
						git clone --depth=1 https://gitee.com/ikechan/chatgpt-plugin.git ./plugins/chatgpt-plugin/
                        cd plugins/chatgpt-plugin
						pnpm i
						read -n 1 -s -r -p "按任意键继续..."
                        ;;
                    3)
                        echo "执行安装椰奶插件的命令"
						# 判断是否存在Miao-Yunzai目录
                        if [ -d "/root/Miao-Yunzai" ]; then
						   # 如果 yenai-plugin 目录存在，则删除它
						   if [ -d "/root/Miao-Yunzai/plugins/yenai-plugin" ]; then
                              rm -rf /root/Miao-Yunzai/plugins/yenai-plugin
							  echo "已删除 yenai-plugin 目录"
						   else
                              echo "yenai-plugin 目录不存在"
                           fi
                        fi
						cd /root/Miao-Yunzai
						git clone --depth=1 https://gitee.com/yeyang52/yenai-plugin.git ./plugins/yenai-plugin
                        pnpm install
						read -n 1 -s -r -p "按任意键继续..."
                        ;;
                    4)
                        echo "执行安装枫叶插件的命令"
						# 判断是否存在Miao-Yunzai目录
                        if [ -d "/root/Miao-Yunzai" ]; then
						   # 如果 hs-qiqi-plugin 目录存在，则删除它
						   if [ -d "/root/Miao-Yunzai/plugins/hs-qiqi-plugin" ]; then
                              rm -rf /root/Miao-Yunzai/plugins/hs-qiqi-plugin
							  echo "已删除 hs-qiqi-plugin 目录"
						   else
                              echo "hs-qiqi-plugin 目录不存在"
                           fi
                        fi
						cd /root/Miao-Yunzai
						git clone https://gitee.com/kesally/hs-qiqi-cv-plugin.git  ./plugins/hs-qiqi-plugin
						read -n 1 -s -r -p "按任意键继续..."
                        ;;
                    5)
                        echo "执行安装阴天插件的命令"
						# 判断是否存在Miao-Yunzai目录
                        if [ -d "/root/Miao-Yunzai" ]; then
						   # 如果 y-tian-plugin 目录存在，则删除它
						   if [ -d "/root/Miao-Yunzai/plugins/y-tian-plugin" ]; then
                              rm -rf /root/Miao-Yunzai/plugins/y-tian-plugin
							  echo "已删除 y-tian-plugin 目录"
						   else
                              echo "y-tian-plugin 目录不存在"
                           fi
                        fi
						cd /root/Miao-Yunzai
						git clone --depth=1 https://gitee.com/wan13877501248/y-tian-plugin.git ./plugins/y-tian-plugin/
						read -n 1 -s -r -p "按任意键继续..."
                        ;;
                    6)
                        echo "执行安装土块插件的命令"
						# 判断是否存在Miao-Yunzai目录
                        if [ -d "/root/Miao-Yunzai" ]; then
						   # 如果 earth-k-plugin 目录存在，则删除它
						   if [ -d "/root/Miao-Yunzai/plugins/earth-k-plugin" ]; then
                              rm -rf /root/Miao-Yunzai/plugins/earth-k-plugin
							  echo "已删除 earth-k-plugin 目录"
						   else
                              echo "earth-k-plugin 目录不存在"
                           fi
                        fi
						cd /root/Miao-Yunzai
						git clone https://gitee.com/SmallK111407/earth-k-plugin.git ./plugins/earth-k-plugin/
                        pnpm add systeminformation -w
						read -n 1 -s -r -p "按任意键继续..."
                        ;;
					7)
                        echo "执行卸载锅巴插件的命令"
						# 判断当前目录是否存在 Miao-Yunzai/plugins 目录
                        if [ -d "/root/Miao-Yunzai/plugins" ]; then
                           # 判断目录下是否存在 Guoba-Plugin 目录
                           if [ -d "/root/Miao-Yunzai/plugins/Guoba-Plugin" ]; then
                              # 存在则删除目录
                              rm -rf "/root/Miao-Yunzai/plugins/Guoba-Plugin"
                              echo "锅巴插件已成功删除"
                           else
                              # 不存在则提示没有锅巴插件
                              echo "没有找到锅巴插件"
                           fi
                        else
                           # 如果目录不存在，则提示目录不存在
                           echo "目录 /root/Miao-Yunzai/plugins 不存在"
                        fi
						read -n 1 -s -r -p "按任意键继续..."
                        ;;
					8)
                        echo "执行卸载ChatGPT插件的命令"
						# 判断当前目录是否存在 Miao-Yunzai/plugins 目录
                        if [ -d "/root/Miao-Yunzai/plugins" ]; then
                           # 判断目录下是否存在 chatgpt-plugin 目录
                           if [ -d "/root/Miao-Yunzai/plugins/chatgpt-plugin" ]; then
                              # 存在则删除目录
                              rm -rf "/root/Miao-Yunzai/plugins/chatgpt-plugin"
                              echo "ChatGPT插件已成功删除"
                           else
                              # 不存在则提示没有ChatGPT插件
                              echo "没有找到ChatGPT插件"
                           fi
						else
                           # 如果目录不存在，则提示目录不存在
                           echo "目录 /root/Miao-Yunzai/plugins 不存在"
                        fi
						read -n 1 -s -r -p "按任意键继续..."
                        ;;
					9)
                        echo "执行卸载椰奶插件的命令"
						# 判断当前目录是否存在 Miao-Yunzai/plugins 目录
                        if [ -d "/root/Miao-Yunzai/plugins" ]; then
                           # 判断目录下是否存在 yenai-plugin 目录
                           if [ -d "/root/Miao-Yunzai/plugins/yenai-plugin" ]; then
                              # 存在则删除目录
                              rm -rf "/root/Miao-Yunzai/plugins/yenai-plugin"
                              echo "椰奶插件已成功删除"
                           else
                              # 不存在则提示没有椰奶插件
                              echo "没有找到椰奶插件"
                           fi
                        else
                           # 如果目录不存在，则提示目录不存在
                           echo "目录 /root/Miao-Yunzai/plugins 不存在"
                        fi
						read -n 1 -s -r -p "按任意键继续..."
                        ;;
					10)
                        echo "执行卸载枫叶插件的命令"
						# 判断当前目录是否存在 Miao-Yunzai/plugins 目录
                        if [ -d "/root/Miao-Yunzai/plugins" ]; then
                           # 判断目录下是否存在 hs-qiqi-plugin 目录
                           if [ -d "/root/Miao-Yunzai/plugins/hs-qiqi-plugin" ]; then
                              # 存在则删除目录
                              rm -rf "/root/Miao-Yunzai/plugins/hs-qiqi-plugin"
                              echo "枫叶插件已成功删除"
                           else
                              # 不存在则提示没有枫叶插件
                              echo "没有找到枫叶插件"
                           fi
                        else
                           # 如果目录不存在，则提示目录不存在
                           echo "目录 /root/Miao-Yunzai/plugins 不存在"
                        fi
						read -n 1 -s -r -p "按任意键继续..."
                        ;;
					11)
                        echo "执行卸载阴天插件的命令"
						# 判断当前目录是否存在 Miao-Yunzai/plugins 目录
                        if [ -d "/root/Miao-Yunzai/plugins" ]; then
                           # 判断目录下是否存在 y-tian-plugin 目录
                           if [ -d "/root/Miao-Yunzai/plugins/y-tian-plugin" ]; then
                              # 存在则删除目录
                              rm -rf "/root/Miao-Yunzai/plugins/y-tian-plugin"
                              echo "阴天插件已成功删除"
                           else
                              # 不存在则提示没有阴天插件
                              echo "没有找到阴天插件"
                           fi
                        else
                           # 如果目录不存在，则提示目录不存在
                           echo "目录 /root/Miao-Yunzai/plugins 不存在"
                        fi
						read -n 1 -s -r -p "按任意键继续..."
                        ;;
					12)
                        echo "执行卸载土块插件的命令"
						# 判断当前目录是否存在 Miao-Yunzai/plugins 目录
                        if [ -d "/root/Miao-Yunzai/plugins" ]; then
                           # 判断目录下是否存在 earth-k-plugin 目录
                           if [ -d "/root/Miao-Yunzai/plugins/earth-k-plugin" ]; then
                              # 存在则删除目录
                              rm -rf "/root/Miao-Yunzai/plugins/earth-k-plugin"
                              echo "土块插件已成功删除"
                           else
                              # 不存在则提示没有土块插件
                              echo "没有找到土块插件"
                           fi
                        else
                           # 如果目录不存在，则提示目录不存在
                           echo "目录 /root/Miao-Yunzai/plugins 不存在"
                        fi
						read -n 1 -s -r -p "按任意键继续..."
                        ;;
                    13)
                        echo "查看已安装的云崽插件"
                        echo "-------------------------"

                        # 检查是否安装了锅巴插件
                        if [ -d "/root/Miao-Yunzai/plugins/Guoba-Plugin" ]; then
                           echo "锅巴插件已安装"
                        fi

                        # 检查是否安装了ChatGPT插件
                        if [ -d "/root/Miao-Yunzai/plugins/chatgpt-plugin" ]; then
                           echo "ChatGPT插件已安装"
                        fi

                        # 检查是否安装了椰奶插件
                        if [ -d "/root/Miao-Yunzai/plugins/yenai-plugin" ]; then
                           echo "椰奶插件已安装"
                        fi

                        # 检查是否安装了枫叶插件
                        if [ -d "/root/Miao-Yunzai/plugins/hs-qiqi-plugin" ]; then
                           echo "枫叶插件已安装"
                        fi

                        # 检查是否安装了阴天插件
                        if [ -d "/root/Miao-Yunzai/plugins/y-tian-plugin" ]; then
                           echo "阴天插件已安装"
                        fi

                        # 检查是否安装了土块插件
                        if [ -d "/root/Miao-Yunzai/plugins/earth-k-plugin" ]; then
                           echo "土块插件已安装"
                        fi

                        read -n 1 -s -r -p "按任意键继续..."
                        ;;
                    0)
                        break
                        ;;
                    *)
                        echo "无效的选择，请重新输入"
                        ;;
                esac

            done
            ;;
        13)
            while true; do
                clear
                echo "备份或还原云崽"
                echo "-------------------"
                echo "1. 备份云崽"
                echo "2. 还原云崽"
                echo "3. 查看云崽安装目录大小"
                echo "4. 比较云崽目录大小"
                echo "-------------------"
                echo "0. 返回上级菜单"
                echo "-------------------"
                read -p "请输入你的选择：" plugin_choice
                
                case $plugin_choice in
                     1)
                       echo "执行备份云崽的命令"
                       curl -sS -o /root/Backup_Yunzai_new.sh https://github.com/Benson80/InstallYunzaiBot/raw/main/Backup_Yunzai_new.sh && chmod +x /root/Backup_Yunzai_new.sh && /root/Backup_Yunzai_new.sh
                       read -p "按 Enter 键继续..."
                       ;;
                     2)
                       echo "执行还原云崽的命令"
                       curl -sS -o /root/Restore_Yunzai.sh https://github.com/Benson80/InstallYunzaiBot/raw/main/Restore_Yunzai.sh && chmod +x /root/Restore_Yunzai.sh && /root/Restore_Yunzai.sh
                       read -p "按 Enter 键继续..."
                       ;;
                     3)
                       echo "执行查看云崽安装目录大小的命令"
                       # 查找包含Yunzai的目录，并计算它们的总大小
                       # 搜索包含Yunzai的目录，并将结果保存到数组中
                       directories=($(find /root -type d -name "*Yunzai*"))

                       # 初始化总大小为0
                       total_size=0

                       # 循环遍历每个目录并计算大小
                       for dir in "${directories[@]}"; do
                           # 使用du命令计算目录大小，并将结果添加到总大小中
                           dir_size_kb=$(du -s "$dir" | awk '{print $1}')
                           dir_size_mb=$((dir_size_kb / 1024))  # 转换为MB
                           total_size=$((total_size + dir_size_mb))

                           # 打印目录名称和大小
                           echo "目录: $dir, 大小: ${dir_size_mb} MB"
                       done

                       # 打印总大小
                       echo "总大小: ${total_size} MB"
                       read -p "按 Enter 键继续..."
                       ;;
                    4)
                       echo "执行比较云崽目录大小的命令"
                       curl -sS -o /root/compare_Yunzai.sh https://github.com/Benson80/InstallYunzaiBot/raw/main/compare_Yunzai.sh && chmod +x /root/compare_Yunzai.sh && /root/compare_Yunzai.sh
                       read -p "按 Enter 键继续..."
                       ;;
                     0)
                        break
                        ;;
                    *)
                        echo "无效的选择，请重新输入"
                        ;;
                esac

            done
            ;;
        14)
            while true; do
                clear
                echo "云崽多开"
                echo "-------------------"
                echo "1. 开第2个云崽"
                echo "2. 开第3个云崽"
                echo "3. 开第4个云崽"
                echo "4. 开第5个云崽"
                echo "-------------------"
                echo "0. 返回上级菜单"
                echo "-------------------"
                read -p "请输入你的选择：" plugin_choice
                
                case $plugin_choice in
                     1)
                       echo "执行开第2个云崽的命令"
                       mkdir /root/Yunzai-bot2 && cd /root/Yunzai-bot2
                       git clone --depth=1 https://gitee.com/yoimiya-kokomi/Miao-Yunzai.git
                       cd /root/Yunzai-bot2/Miao-Yunzai 
                       git clone --depth=1 https://gitee.com/yoimiya-kokomi/miao-plugin.git ./plugins/miao-plugin/
                       bash <(curl -sL https://szrq2022.cf/startYunzai/setup_node_and_icqq.sh)
                       cd config/default_config && cp * ../config
                       sed -i 's/db: 0/db: 1/' /root/Yunzai-bot2/Miao-Yunzai/config/config/redis.yaml
                       # 检查是否已安装 screen
                       #if command -v screen &> /dev/null
                       #then
                       #   echo "screen 已安装，正在执行 screen -S yz2"
                       #   screen -S yz2
                       #else
                       #   echo "screen 未安装，正在安装..."
                       #   apt-get install screen
                       #   screen -S yz2
                       #fi
                       cd /root/Yunzai-bot2/Miao-Yunzai && node app
                       read -p "按 Enter 键继续..."
                       ;;
                     2)
                       echo "执行开第3个云崽的命令"
                       mkdir /root/Yunzai-bot3 && cd /root/Yunzai-bot3
                       git clone --depth=1 https://gitee.com/yoimiya-kokomi/Miao-Yunzai.git
                       cd /root/Yunzai-bot3/Miao-Yunzai 
                       git clone --depth=1 https://gitee.com/yoimiya-kokomi/miao-plugin.git ./plugins/miao-plugin/
                       bash <(curl -sL https://szrq2022.cf/startYunzai/setup_node_and_icqq.sh)
                       cd config/default_config && cp * ../config
                       sed -i 's/db: 0/db: 2/' /root/Yunzai-bot3/Miao-Yunzai/config/config/redis.yaml
                       cd /root/Yunzai-bot3/Miao-Yunzai && node app
                       read -p "按 Enter 键继续..."
                       ;;
                     3)
                       echo "执行开第4个云崽的命令"
                       mkdir /root/Yunzai-bot4 && cd /root/Yunzai-bot4
                       git clone --depth=1 https://gitee.com/yoimiya-kokomi/Miao-Yunzai.git
                       cd /root/Yunzai-bot4/Miao-Yunzai 
                       git clone --depth=1 https://gitee.com/yoimiya-kokomi/miao-plugin.git ./plugins/miao-plugin/
                       bash <(curl -sL https://szrq2022.cf/startYunzai/setup_node_and_icqq.sh)
                       cd config/default_config && cp * ../config
                       sed -i 's/db: 0/db: 3/' /root/Yunzai-bot4/Miao-Yunzai/config/config/redis.yaml
                       cd /root/Yunzai-bot4/Miao-Yunzai && node app
                       read -p "按 Enter 键继续..."
                       ;;
                     4)
                       echo "执行开第5个云崽的命令"
                       mkdir /root/Yunzai-bot5 && cd /root/Yunzai-bot5
                       git clone --depth=1 https://gitee.com/yoimiya-kokomi/Miao-Yunzai.git
                       cd /root/Yunzai-bot5/Miao-Yunzai 
                       git clone --depth=1 https://gitee.com/yoimiya-kokomi/miao-plugin.git ./plugins/miao-plugin/
                       bash <(curl -sL https://szrq2022.cf/startYunzai/setup_node_and_icqq.sh)
                       cd config/default_config && cp * ../config
                       sed -i 's/db: 0/db: 4/' /root/Yunzai-bot5/Miao-Yunzai/config/config/redis.yaml
                       cd /root/Yunzai-bot5/Miao-Yunzai && node app
                       read -p "按 Enter 键继续..."
                       ;;
                     0)
                        break
                        ;;
                    *)
                        echo "无效的选择，请重新输入"
                        ;;
                esac

            done
            ;;
        15)
            echo "执行一键快速配置Qsign服务的命令"
            bash -c "$(curl -fsSL https://github.com/Benson80/InstallYunzaiBot/raw/main/qsign.sh)"
            read -p "按 Enter 键继续..."
            ;;
        16)
            while true; do
                clear
                echo "一键安装或卸载v2ray"
                echo "-------------------------"
                echo "1. 一键安装v2ray"
                echo "2. 一键卸载v2ray"
                echo "-------------------------"
                echo "0. 返回上级菜单"
                echo "-------------------------"
                read -p "请输入你的选择：" plugin_choice

                case $plugin_choice in
                     1)
                        echo "执行一键安装v2ray的命令"
                        bash -c "$(curl -fsSL https://github.com/Benson80/InstallYunzaiBot/raw/main/install_v2ray.sh)"
                        read -p "按 Enter 键继续..."
                        ;;
                     2)
                        echo "执行一键卸载v2ray的命令"
                        bash -c "$(curl -fsSL https://github.com/Benson80/InstallYunzaiBot/raw/main/uninstall_v2ray.sh)"
                        read -p "按 Enter 键继续..."
                        ;;
                     0)
                        break
                        ;;
                     *)
                        echo "无效的选择，请重新输入"
                        ;;
                esac

            done
            ;;
        17)
            while true; do
                clear
                echo "创建或删除交换文件"
                echo "-------------------------"
                echo "1. 创建交换文件"
                echo "2. 删除交换文件"
                echo "-------------------------"
                echo "0. 返回上级菜单"
                echo "-------------------------"
                read -p "请输入你的选择：" plugin_choice

                case $plugin_choice in
                     1)
                        create_swap
                        read -p "按 Enter 键继续..."
                        ;;
                     2)
                        delete_swap
                        read -p "按 Enter 键继续..."
                        ;;
                     0)
                        break
                        ;;
                     *)
                        echo "无效的选择，请重新输入"
                        ;;
                esac

            done
            ;;
        18)
            echo "执行添加DNS的命令"
            echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
            read -p "按 Enter 键继续..."
            ;;
        19)
            echo "执行修改时区的命令"
            curl -sS -o /root/change_timezone.sh https://github.com/Benson80/InstallYunzaiBot/raw/main/change_timezone.sh && chmod +x /root/change_timezone.sh && /root/change_timezone.sh
            read -p "按 Enter 键继续..."
            ;;
        20)
            echo "执行安装Ubuntu桌面的命令"
            apt update && apt install ubuntu-desktop
            read -p "按 Enter 键继续..."
            ;;
		21)
            while true; do
                clear
                echo "VNC 功能菜单"
                echo "-------------------------"
                echo "1. 安装VNC"
                echo "2. 查看VNC端口号"
				echo "3. 停止所有VNC服务"
				echo "4. 解决VNC连接后灰屏"
                echo "-------------------------"
                echo "0. 返回上级菜单"
                echo "-------------------------"
                read -p "请输入你的选择：" plugin_choice

                case $plugin_choice in
                     1)
                        echo "执行安装VNC的命令"
                        #安装 TightVNC 服务器
                        apt install tightvncserver

                        #创建初始配置文件
                        vncserver

                        #备份VNC的xstartup配置文件
                        cp ~/.vnc/xstartup ~/.vnc/xstartup.bak

                        #修改VNC的xstartup配置文件
                        echo -e "#!/bin/sh\nautocutsel -fork\nxrdb \$HOME/.Xresources\nxsetroot -solid grey\nexport XKL_XMODMAP_DISABLE=1\nexport XDG_CURRENT_DESKTOP=\"GNOME-Flashback:Unity\"\nexport XDG_MENU_PREFIX=\"gnome-flashback-\"\nunset DBUS_SESSION_BUS_ADDRESS\ngnome-session --session=gnome-flashback-metacity --disable-acceleration-check --debug &" > ~/.vnc/xstartup
                        read -p "按 Enter 键继续..."
                        ;;
                     2)
                        echo "执行查看VNC端口号的命令"
                        sudo ss -tunlp | grep 590
                        read -p "按 Enter 键继续..."
                        ;;
					 3)
                        echo "执行停止所有VNC服务的命令"
                        sudo killall Xtightvnc
                        read -p "按 Enter 键继续..."
                        ;;
					 4)
                        echo "执行解决VNC连接后灰屏的命令"
                        # 安装gnome-panel
						sudo apt-get install -y gnome-panel
						
						# 备份原有的xstartup文件
                        sudo cp /root/.vnc/xstartup /root/.vnc/xstartup.bak

                        # 要替换的代码
                        new_code="#!/bin/sh\n\nunset SESSION_MANAGER\nunset DBUS_SESSION_BUS_ADDRESS\nexport XKL_XMODMAP_DISABLE=1\nexport XDG_CURRENT_DESKTOP=\"GNOME-Flashback:GNOME\"\nexport XDG_MENU_PREFIX=\"gnome-flashback-\"\n[ -x /root/.vnc/xstartup ] && exec /root/.vnc/xstartup\n[ -r \$HOME/.Xresources ] && xrdb \$HOME/.Xresources\nxsetroot -solid grey\nvncconfig -iconic &\n#gnome-terminal &\n#nautilus &\ngnome-session --session=gnome-flashback-metacity --disable-acceleration-check &"

                        # 将新代码写入xstartup文件中
                        echo -e "$new_code" | sudo tee /root/.vnc/xstartup > /dev/null

                        echo "xstartup文件已更新，并备份为xstartup.bak"
						
						# 重启VNC服务
                        echo "重启VNC服务"
                        vncserver -kill :1
                        vncserver :1 -geometry 1920x1000 -depth 24

                        echo "VNC服务已重启"
                        read -p "按 Enter 键继续..."
                        ;;
                     0)
                        break
                        ;;
                     *)
                        echo "无效的选择，请重新输入"
                        ;;
                esac

            done
            ;;
		22)
            echo "执行安装Google Chrome浏览器的命令"
            # 下载 Google Chrome 安装包
            echo "正在下载 Google Chrome 安装包..."
            wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

            # 安装 Google Chrome
            echo "正在安装 Google Chrome..."
            sudo dpkg -i google-chrome-stable_current_amd64.deb

            # 完成
            echo "Google Chrome 安装完成"
            read -p "按 Enter 键继续..."
            ;;
        23)
            echo "执行安装cpolar内网穿透的命令"
            bash -c "$(curl -fsSL https://github.com/Benson80/InstallYunzaiBot/raw/main/install_cpolar.sh)"
            read -p "按 Enter 键继续..."
            ;;
        24)
            echo "执行安装并启动v2rayA的命令"
            #添加公钥
            wget -qO - https://apt.v2raya.org/key/public-key.asc | sudo tee /etc/apt/keyrings/v2raya.asc
            
            #添加 V2RayA 软件源
            echo "deb [signed-by=/etc/apt/keyrings/v2raya.asc] https://apt.v2raya.org/ v2raya main" | sudo tee /etc/apt/sources.list.d/v2raya.list
            sudo apt update
            
            #安装 V2RayA
            sudo apt install v2raya v2ray
            
            #启动 v2rayA
            sudo systemctl start v2raya.service
            
            #设置开机自动启动
            sudo systemctl enable v2raya.service
            
            read -p "按 Enter 键继续..."
            ;;
        25)
            echo "执行查看系统信息的命令"
            #显示操作系统的图标、主机名、内核版本、CPU 信息、内存使用、分辨率、桌面环境等信息。
            # 检查 neofetch 是否已安装
            if command -v neofetch &> /dev/null; then
               echo "neofetch 已安装，跳过安装步骤。"
            else
               # 如果未安装，执行安装命令
               echo "neofetch 未安装，正在安装..."
               sudo apt update
               sudo apt install -y neofetch
            fi

            # 执行 neofetch 命令
            neofetch
            read -p "按 Enter 键继续..."
            ;;
		26)
            echo "执行一键重装系统的命令"
            dd_xitong_1() {
            read -p "请输入你重装后的密码: " vpspasswd
            install wget
            bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/MoeClub/Note/master/InstallNET.sh') $xitong -v 64 -p $vpspasswd -port 22
          }

          dd_xitong_2() {
            install wget
            wget --no-check-certificate -qO InstallNET.sh 'https://raw.githubusercontent.com/leitbogioro/Tools/master/Linux_reinstall/InstallNET.sh' && chmod a+x InstallNET.sh
          }

          clear
          echo "请备份数据，将为你重装系统，预计花费15分钟。"
          echo -e "\e[37m感谢MollyLau和MoeClub的脚本支持！\e[0m "
          read -p "确定继续吗？(Y/N): " choice

          case "$choice" in
            [Yy])
              while true; do

                echo "1. Debian 12"
                echo "2. Debian 11"
                echo "3. Debian 10"
                echo "4. Ubuntu 22.04"
                echo "5. Ubuntu 20.04"
                echo "6. CentOS 7.9"
                echo "7. Alpine 3.19"
                echo -e "8. Windows 11 \033[36mBeta\033[0m"
                echo "------------------------"
                read -p "请选择要重装的系统: " sys_choice

                case "$sys_choice" in
                  1)
                    xitong="-d 12"
                    dd_xitong_1
                    exit
                    reboot
                    ;;

                  2)
                    xitong="-d 11"
                    dd_xitong_1
                    reboot
                    exit
                    ;;

                  3)
                    xitong="-d 10"
                    dd_xitong_1
                    reboot
                    exit
                    ;;

                  4)
                    dd_xitong_2
                    bash InstallNET.sh -ubuntu
                    reboot
                    exit
                    ;;

                  5)
                    xitong="-u 20.04"
                    dd_xitong_1
                    reboot
                    exit
                    ;;

                  6)
                    dd_xitong_2
                    bash InstallNET.sh -centos 7
                    reboot
                    exit
                    ;;
                  7)
                    dd_xitong_2
                    bash InstallNET.sh -alpine
                    reboot
                    exit
                    ;;

                  8)
                    dd_xitong_2
                    bash InstallNET.sh -windows
                    reboot
                    exit
                    ;;

                  *)
                    echo "无效的选择，请重新输入。"
                    ;;
                esac
              done
              ;;
            [Nn])
              echo "已取消"
              ;;
            *)
              echo "无效的选择，请输入 Y 或 N。"
              ;;
          esac
              ;;
        0)
            echo "退出脚本，再见！"
            exit 0
            ;;
        *)
            echo "无效的选择，请重新输入"
            ;;
    esac

done
