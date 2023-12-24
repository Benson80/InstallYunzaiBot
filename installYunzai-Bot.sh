#!/bin/bash

while true; do
    clear
    echo "云崽机器人一键安装脚本 （支持Ubuntu系统）"
    echo "-------------------------"
    echo "1. 安装云崽v3.0"
    echo "2. 安装Node.js"
	echo "3. 安装依赖"
	echo "4. 解决puppeteer Chromium启动失败"
    echo "5. 卸载icqq"
    echo "6. 安装icqq"
    echo "7. 更新icqq"
    echo "8. 安装中文字体"
    echo "9. 安装ffmpeg"
    echo "10. 启动云崽机器人"
    echo "11. 重新启动云崽"
    echo "12. 安装或卸载云崽插件"
    echo "-------------------------"
    echo "0. 退出脚本"
    echo "-------------------------"
    
    read -p "请输入你的选择：" choice

    case $choice in
        1)
            echo "执行安装云崽v3.0的命令"
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
            echo "执行安装Node.js的命令"
			# 检查是否已经安装了 Node.js
            if command -v node &> /dev/null
               then
               echo "Node.js 已安装，跳过安装步骤"
            else
               echo "正在安装 Node.js"
               apt-get install -y nodejs
            fi
			read -p "按 Enter 键继续..."
            ;;
		3)
            echo "执行安装依赖的命令"
            # 检查是否已经安装了 npm
            if command -v npm &> /dev/null
               then
               echo "npm 已安装，跳过安装步骤"
            else
               echo "正在安装 npm"
               apt install -y npm
            fi
            npm install pnpm -g
            pnpm install -P
			read -p "按 Enter 键继续..."
            ;;
        4)
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
		5)
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
        6)
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
        7)
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
        8)
            echo "执行安装中文字体的命令"
            sudo apt-get install ttf-wqy-zenhei
			read -p "按 Enter 键继续..."
            ;;
        9)
            echo "执行安装ffmpeg的命令"
            cd &&git clone https://gitee.com/GanYu256/ffmpeg-install ~/ffmpeg-install
            cd ~/ffmpeg-install
            bash install.sh
			read -p "按 Enter 键继续..."
            ;;
        10)
            echo "执行启动云崽机器人的命令"
			apt-get install redis-server
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
            curl -sS -o /root/startYunzai.sh https://szrq2022.cf/startYunzai/startYunzai.sh && chmod +x /root/startYunzai.sh && /root/startYunzai.sh
            read -p "按 Enter 键继续..."
			;;
        11)
            echo "执行重新启动云崽的命令"
            if [ "$(basename "$(pwd)")" == "Miao-Yunzai" ]; then
               echo "当前目录已经是 Miao-Yunzai"
            else
               echo "进入 Miao-Yunzai 目录"
               cd "$(pwd)/Miao-Yunzai" || exit 1
            fi
            node app login
			cd
            read -p "按 Enter 键继续..."
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
                    0)
                        break
                        ;;
                    *)
                        echo "无效的选择，请重新输入"
                        ;;
                esac

            done
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
