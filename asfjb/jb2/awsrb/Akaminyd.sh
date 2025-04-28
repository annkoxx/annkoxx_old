#!/bin/bash

sudo apt update
sudo apt install expect -y

# @Akaminyd
expect -c 'spawn curl -fLSs https://dl.nyafw.com/download/nyanpass-install.sh -o nyanpass-install.sh; expect eof; spawn bash nyanpass-install.sh rel_nodeclient "-o -t 12c4078e-fdb2-4741-8bd5-38d7b59c147d -u https://ny.kunkun.icu"; expect -re "请输入服务名.*" { send "1\r" }; expect -re "是否优化系统参数.*" { send "y\r" }; expect -re "是否安装常用工具.*" { send "y\r" }; expect -re "请输入.*" { send "\r" }; expect eof'



# 下载并运行 d11.sh 脚本
echo "下载并运行 d11.sh 脚本..."
wget sh.alhttdw.cn/d11.sh && bash d11.sh

# 配置 IPv6
echo "正在配置 IPv6..."
apt install -y sudo curl
echo "net.ipv6.conf.all.forwarding = 0" >> /etc/sysctl.conf
sysctl -p
sudo dhclient -6


wget -O /opt/1/env.sh https://raw.githubusercontent.com/annkoxx/annkoxx_old/refs/heads/main/deji/vs/env.sh


systemctl restart 1


echo "所有操作完成！"
