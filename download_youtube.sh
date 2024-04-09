#!/bin/bash

# 下载 YouTube 视频
download_youtube_video() {
    video_url="$1"
    quality="$2"
    
    # 下载视频
    echo "Downloading YouTube video..."
    if [ -z "$quality" ]; then
        yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]" "$video_url"
    else
        yt-dlp -f "$quality" "$video_url"
    fi
}

# 主函数
main() {
    # 安装 yt-dlp
    if ! command -v yt-dlp &> /dev/null; then
        echo "Installing yt-dlp..."
        wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp
        chmod a+rx /usr/local/bin/yt-dlp
    fi
    
    # 提示用户输入视频链接
    read -p "Enter the YouTube video URL: " video_url
    
    # 检查视频链接
    if [ -z "$video_url" ]; then
        echo "Error: Please provide a YouTube video URL."
        exit 1
    fi
    
    # 下载视频
    download_youtube_video "$video_url" "$1"
}

# 执行主函数
main "$@"
