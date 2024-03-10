#!/bin/bash

# 定义颜色
green='\033[0;32m'
red='\033[31m'
plain='\033[0m'

# 安装XrayR
bash <(curl -Ls https://raw.githubusercontent.com/XrayR-project/XrayR-release/master/install.sh)

# 下载配置文件
wget -O /etc/XrayR/config.yml https://raw.githubusercontent.com/annkoxx/annkoxx_old/main/asfjb/asga/config.yml

# 更新PanelType
echo -e "${red}输入数字选择PanelType: 1.SSpanel 2.NewV2board 3.V2board (留空则不更改)${plain}"
read panelTypeInput
case $panelTypeInput in
  1) sed -i 's/PanelType: .*/PanelType: "SSpanel"/' /etc/XrayR/config.yml ;;
  2) sed -i 's/PanelType: .*/PanelType: "NewV2board"/' /etc/XrayR/config.yml ;;
  3) sed -i 's/PanelType: .*/PanelType: "V2board"/' /etc/XrayR/config.yml ;;
  *) echo "PanelType不更改" ;;
esac

# 更新ApiHost
echo -e "${red}请输入新的ApiHost (留空则不更改):${plain}"
read apiHost
if [ ! -z "$apiHost" ]; then
  sed -i "s|ApiHost: .*|ApiHost: \"$apiHost\"|" /etc/XrayR/config.yml
fi

# 更新ApiKey
echo -e "${red}请输入新的ApiKey (留空则不更改):${plain}"
read apiKey
if [ ! -z "$apiKey" ]; then
  sed -i "s/ApiKey: .*/ApiKey: \"$apiKey\"/" /etc/XrayR/config.yml
fi

# 更新NodeID
echo -e "${red}请输入新的NodeID (留空则不更改):${plain}"
read nodeId
if [ ! -z "$nodeId" ]; then
  sed -i "s/NodeID: .*/NodeID: $nodeId/" /etc/XrayR/config.yml
fi

# 更新NodeType
echo -e "${red}输入数字选择NodeType: 1.V2ray 2.Trojan 3.Shadowsocks 4.Shadowsocks-Plugin (留空则不更改)${plain}"
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

echo -e "${green}配置更新完成，本次服务到此结束！作者TG:棍勇${plain}"
