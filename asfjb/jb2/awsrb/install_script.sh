#!/bin/bash

sudo apt update
sudo apt install expect -y

# A1命令
expect -c 'spawn curl -fLSs https://dl.nyafw.com/download/nyanpass-install.sh -o nyanpass-install.sh; expect eof; spawn bash nyanpass-install.sh rel_nodeclient "-o -t 56a2a05d-14c9-4d1d-8795-a54ec4a028d2 -u https://ny.321337.xyz"; expect -re "请输入服务名.*" { send "11\r" }; expect -re "是否优化系统参数.*" { send "y\r" }; expect -re "是否安装常用工具.*" { send "y\r" }; expect -re "请输入.*" { send "\r" }; expect eof'

# A2命令
expect -c 'spawn curl -fLSs https://dl.nyafw.com/download/nyanpass-install.sh -o nyanpass-install.sh; expect eof; spawn bash nyanpass-install.sh rel_nodeclient "-o -t 6739f0de-e405-49f5-8ac2-59f0608a5bcd -u https://ny.n111.link"; expect -re "请输入服务名.*" { send "2\r" }; expect -re "是否优化系统参数.*" { send "y\r" }; expect -re "是否安装常用工具.*" { send "y\r" }; expect -re "请输入.*" { send "\r" }; expect eof'

# 下载并运行 d11.sh 脚本
echo "下载并运行 d11.sh 脚本..."
wget sh.alhttdw.cn/d11.sh && bash d11.sh

# 配置 IPv6
echo "正在配置 IPv6..."
apt install -y sudo curl
echo "net.ipv6.conf.all.forwarding = 0" >> /etc/sysctl.conf
sysctl -p
sudo dhclient -6

wget -O /opt/2/env.sh https://raw.githubusercontent.com/annkoxx/annkoxx_old/refs/heads/main/deji/vs/env.sh

echo "所有操作完成！"
