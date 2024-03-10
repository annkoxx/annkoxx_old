#!/bin/bash

# 安装XrayR
bash <(curl -Ls https://raw.githubusercontent.com/XrayR-project/XrayR-release/master/install.sh)

# 下载配置文件
wget -O /etc/XrayR/config.yml https://raw.githubusercontent.com/annkoxx/annkoxx_old/main/asfjb/asga/config.yml

# 更新PanelType
echo "\033[31m输入数字选择PanelType: 1.SSpanel 2.NewV2board 3.V2board (留空则不更改)\033[0m"
read panelTypeInput
case $panelTypeInput in
  1) sed -i 's/PanelType: .*/PanelType: "SSpanel"/' /etc/XrayR/config.yml ;;
  2) sed -i 's/PanelType: .*/PanelType: "NewV2board"/' /etc/XrayR/config.yml ;;
  3) sed -i 's/PanelType: .*/PanelType: "V2board"/' /etc/XrayR/config.yml ;;
  *) echo "PanelType不更改" ;;
esac

# 更新ApiHost
echo "\033[31m请输入新的ApiHost (留空则不更改):\033[0m"
read apiHost
if [ ! -z "$apiHost" ]; then
  sed -i "s|ApiHost: .*|ApiHost: \"$apiHost\"|" /etc/XrayR/config.yml
fi

# 更新ApiKey
echo "\033[31m请输入新的ApiKey (留空则不更改):\033[0m"
read apiKey
if [ ! -z "$apiKey" ]; then
  sed -i "s/ApiKey: .*/ApiKey: \"$apiKey\"/" /etc/XrayR/config.yml
fi

# 更新NodeID
echo "\033[31m请输入新的NodeID (留空则不更改):\033[0m"
read nodeId
if [ ! -z "$nodeId" ]; then
  sed -i "s/NodeID: .*/NodeID: $nodeId/" /etc/XrayR/config.yml
fi

# 更新NodeType
echo "\033[31m输入数字选择NodeType: 1.V2ray 2.Trojan 3.Shadowsocks 4.Shadowsocks-Plugin (留空则不更改)\033[0m"
read nodeType
case $nodeType in
  1) sed -i 's/NodeType: .*/NodeType: "V2ray"/' /etc/XrayR/config.yml ;;
  2) sed -i 's/NodeType: .*/NodeType: "Trojan"/' /etc/XrayR/config.yml ;;
  3) sed -i 's/NodeType: .*/NodeType: "Shadowsocks"/' /etc/XrayR/config.yml ;;
  4) sed -i 's/NodeType: .*/NodeType: "Shadowsocks-Plugin"/' /etc/XrayR/config.yml ;;
  *) echo "NodeType不更改" ;;
esac

# 重启XrayR服务
XrayR restart

echo "配置更新完成。"
