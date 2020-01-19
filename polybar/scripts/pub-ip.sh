#!/bin/sh

# credits
# https://linuxconfig.org/polybar-a-better-wm-panel-for-your-linux-system

#IP=$(dig +short myip.opendns.com @resolver1.opendns.com)

#public ip
IP=$(wget -qO- ifconfig.me)
if pgrep -x openvpn > /dev/null; then
    echo VPN: $IP
else
    echo $IP
fi
