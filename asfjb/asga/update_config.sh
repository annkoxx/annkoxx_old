#!/bin/bash

# 安装XrayR
bash <(curl -Ls https://raw.githubusercontent.com/XrayR-project/XrayR-release/master/install.sh)

# 下载配置文件
wget -O /etc/XrayR/config.yml https://raw.githubusercontent.com/annkoxx/annkoxx_old/main/asfjb/asga/config.yml

# 提示用户输入新的NodeID
echo "请输入新的NodeID："
read newNodeID

# 替换配置文件中的NodeID
sed -i "s/NodeID: .*/NodeID: $newNodeID/" /etc/XrayR/config.yml

# 重启XrayR服务
XrayR restart

echo "配置更新完成，NodeID已更新为$newNodeID。"
