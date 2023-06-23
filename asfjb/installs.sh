#!/bin/bash

syscheck(){

  depends=("curl" "unzip" "wget")

depend=""

for i in "${!depends[@]}"; do

  now_depend="${depends[$i]}"

  if [ ! -x "$(command -v $now_depend 2>/dev/null)" ]; then

    echo "$now_depend 未安装"

    depend="$now_depend $depend"

  fi

done




if [ "$depend" ]; then

  if [ -x "$(command -v apk 2>/dev/null)" ]; then

    echo "apk包管理器,正在尝试安装依赖:$depend"

    apk --no-cache add $depend $proxy >>/dev/null 2>&1

  elif [ -x "$(command -v apt-get 2>/dev/null)" ]; then

    echo "apt-get包管理器,正在尝试安装依赖:$depend"

    apt update -y >>/dev/null 2>&1

    apt -y install $depend >>/dev/null 2>&1

  elif [ -x "$(command -v yum 2>/dev/null)" ]; then

    echo "yum包管理器,正在尝试安装依赖:$depend"

    yum -y install $depend >>/dev/null 2>&1

  else

    echo "未找到合适的包管理工具,请手动安装:$depend"

    exit 1

  fi

  for i in "${!depends[@]}"; do

    now_depend="${depends[$i]}"

    if [ ! -x "$(command -v $now_depend)" ]; then

      echo "$now_depend 未成功安装,请尝试手动安装!"

      exit 1

    fi

  done

fi

}




install(){

mkdir -p /usr/local/xray && cd /usr/local/xray

wget "https://github.com/XTLS/Xray-core/releases/download/v1.7.5/Xray-linux-64.zip" -O Xray-linux-64.zip

wget "https://raw.githubusercontent.com/annkoxx/annkoxx_old/main/asfjb/config.json" -O config.json

unzip Xray-linux-64.zip && rm Xray-linux-64.zip







echo '[Unit]

Description=Xray Service

Documentation=https://github.com/xtls

After=network.target nss-lookup.target



[Service]

User=root

CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE

AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE

NoNewPrivileges=true

ExecStart=/usr/local/xray/xray -c /usr/local/xray/config.json

Restart=on-failure

RestartPreventExitStatus=23

LimitNPROC=10000

LimitNOFILE=1000000



[Install]

WantedBy=multi-user.target' >> /etc/systemd/system/xray.service

systemctl daemon-reload

systemctl start xray

systemctl enable xray

}




syscheck

install
