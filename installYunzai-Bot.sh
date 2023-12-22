#!/bin/bash

while true; do
    clear
    echo "云崽机器人一键安装脚本 （支持Ubuntu系统）"
    echo "-------------------------"
    echo "1. 安装云崽v3.0"
    echo "2. 安装依赖"
	echo "3. 解决puppeteer Chromium启动失败"
    echo "4. 卸载icqq"
    echo "5. 安装icqq"
    echo "6. 更新icqq"
    echo "7. 安装中文字体"
    echo "8. 安装ffmpeg"
    echo "9. 启动云崽机器人"
    echo "10. 重新启动云崽"
    echo "11. 安装或卸载云崽插件"
    echo "-------------------------"
    echo "0. 退出脚本"
    echo "-------------------------"
    
    read -p "请输入你的选择：" choice

    case $choice in
        1)
            echo "执行安装云崽v3.0的命令"
			apt-get install git
            git clone --depth=1 https://gitee.com/yoimiya-kokomi/Miao-Yunzai.git
            cd Miao-Yunzai 
            git clone --depth=1 https://gitee.com/yoimiya-kokomi/miao-plugin.git ./plugins/miao-plugin/
            ;;
        2)
            echo "执行安装依赖的命令"
            apt-get install -y nodejs
			apt install npm
            npm install pnpm -g
			pnpm install -P
            ;;
        3)
            echo "解决puppeteer Chromium启动失败"
            pnpm uninstall puppeteer
            pnpm install puppeteer
            apt-get install chromium-browser
            ;;
		4)
            echo "执行卸载icqq的命令"
            pnpm uninstall icqq
            ;;
        5)
            echo "执行安装icqq的命令"
            pnpm install icqq
            ;;
        6)
            echo "执行更新icqq的命令"
            pnpm update icqq
            ;;
        7)
            echo "执行安装中文字体的命令"
            sudo apt-get install ttf-wqy-zenhei
            ;;
        8)
            echo "执行安装ffmpeg的命令"
            cd &&git clone https://gitee.com/GanYu256/ffmpeg-install ~/ffmpeg-install
            cd ~/ffmpeg-install
            bash install.sh
            ;;
        9)
            echo "执行启动云崽机器人的命令"
            curl -sS -O https://szrq2022.cf/startYunzai/startYunzai.sh && chmod +x startYunzai.sh && ./startYunzai.sh
            ;;
       10)
            echo "执行重新启动云崽的命令"
            cd Miao-Yunzai
            node app login
            ;;
        11)
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
                        git clone --depth=1 https://gitee.com/guoba-yunzai/guoba-plugin.git ./plugins/Guoba-Plugin/
                        pnpm install --filter=guoba-plugin
                        ;;
                    2)
                        echo "执行安装ChatGPT插件的命令"
                        git clone --depth=1 https://gitee.com/ikechan/chatgpt-plugin.git ./plugins/chatgpt-plugin/
                        cd plugins/chatgpt-plugin
                        pnpm i
                        ;;
                    3)
                        echo "执行安装椰奶插件的命令"
                        git clone --depth=1 https://gitee.com/yeyang52/yenai-plugin.git ./plugins/yenai-plugin
                        pnpm install
                        ;;
                    4)
                        echo "执行安装枫叶插件的命令"
                        git clone https://gitee.com/kesally/hs-qiqi-cv-plugin.git  ./plugins/hs-qiqi-plugin
                        ;;
                    5)
                        echo "执行安装阴天插件的命令"
                        git clone --depth=1 https://gitee.com/wan13877501248/y-tian-plugin.git ./plugins/y-tian-plugin/
                        ;;
                    6)
                        echo "执行安装土块插件的命令"
                        git clone https://gitee.com/SmallK111407/earth-k-plugin.git ./plugins/earth-k-plugin/
                        pnpm add systeminformation -w
                        ;;
					7)
                        echo "执行卸载锅巴插件的命令"
                        cd plugins & rm -rf Guoba-Plugin
                        ;;
					8)
                        echo "执行卸载ChatGPT插件的命令"
                        cd plugins & rm -rf chatgpt-plugin
                        ;;
					9)
                        echo "执行卸载椰奶插件的命令"
                        cd plugins & rm -rf yenai-plugin
                        ;;
					10)
                        echo "执行卸载枫叶插件的命令"
                        cd plugins & rm -rf hs-qiqi-plugin
                        ;;
					11)
                        echo "执行卸载阴天插件的命令"
                        cd plugins & rm -rf y-tian-plugin
                        ;;
					12)
                        echo "执行卸载土块插件的命令"
                        cd plugins & rm -rf earth-k-plugin
                        ;;
                    0)
                        break
                        ;;
                    *)
                        echo "无效的选择，请重新输入"
                        ;;
                esac

                read -p "按Enter键继续..."
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

    read -p "按Enter键继续..."
done