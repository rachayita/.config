#!/bin/sh

# credits
# https://linuxconfig.org/polybar-a-better-wm-panel-for-your-linux-system

#IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
#private ip
IP=$( ip addr show wlp2s0 | grep 'inet ' | awk '{print $2}' | cut -f1 -d'/')

if pgrep -x openvpn > /dev/null; then
    echo VPN: $IP
else
    echo $IP
fi

#public ip
#IP=$(curl ifconfig.me)

#if pgrep -x openvpn > /dev/null; then
#    echo VPN: $IP
#else
#    echo $IP
#fi
