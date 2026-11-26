#!/bin/bash

# Dừng script ngay lập tức nếu có bất kỳ lệnh nào bị lỗi
set -e

echo "============================================="
echo " 1. Cập nhật hệ thống (apt update & upgrade) "
echo "============================================="
sudo apt-get update && sudo apt-get upgrade -y

echo "============================================="
echo " 2. Cài đặt các gói: openjdk-17-jdk, git, curl"
echo "============================================="
sudo apt-get install -y openjdk-17-jdk git curl

echo "============================================="
echo " 3. Kiểm tra và tạo group quickbite           "
echo "============================================="
if getent group quickbite > /dev/null 2>&1; then
    echo "-> Nhóm 'quickbite' đã tồn tại."
else
    sudo groupadd quickbite
    echo "-> Đã tạo nhóm 'quickbite' thành công."
fi

echo "============================================="
echo " 4. Kiểm tra và tạo system user quickbite     "
echo "============================================="
if id -u quickbite > /dev/null 2>&1; then
    echo "-> User 'quickbite' đã tồn tại."
else
    # -r: Tạo system user (không tạo thư mục home mặc định)
    # -g: Gán vào primary group quickbite
    # -s /bin/false: Khóa shell, không cho phép đăng nhập trực tiếp
    sudo useradd -r -g quickbite -s /bin/false quickbite
    echo "-> Đã tạo system user 'quickbite' thành công."
fi

echo "============================================="
echo " Cài đặt và cấu hình hoàn tất thành công!    "
echo "============================================="
