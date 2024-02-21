#!/bin/bash

# 获取用户输入的第一个云崽目录名，默认为"Miao-Yunzai"
read -p "请输入第一个云崽目录名（默认为Miao-Yunzai）: " dir1
dir1=${dir1:-"Miao-Yunzai"}

# 获取用户输入的第二个云崽目录名
read -p "请输入第二个云崽目录名: " dir2

# 检查目录是否存在
if [ ! -d "$dir1" ] || [ ! -d "$dir2" ]; then
  echo "错误: 输入的目录不存在，请重新输入有效的目录名。"
  exit 1
fi

# 获取目录大小并显示
size1=$(du -s "$dir1" | awk '{print $1}')
size2=$(du -s "$dir2" | awk '{print $1}')

echo "目录'$dir1'的大小为: $size1 KB"
echo "目录'$dir2'的大小为: $size2 KB"

# 比较目录大小
if [ "$size1" -eq "$size2" ]; then
  echo "两个目录的大小相同。"
elif [ "$size1" -gt "$size2" ]; then
  echo "目录'$dir1'的大小大于目录'$dir2'的大小。"
else
  echo "目录'$dir2'的大小大于目录'$dir1'的大小。"
fi