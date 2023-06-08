#!/usr/bin/env bash
#Unattended
  export DEBIAN_FRONTEND=noninteractive
#xfce4 DE
  sudo apt install --assume-yes xfce4 xfce4-terminal xrdp
#Session
  sudo sed -i.bak '/fi/a xfce4-session \n' /etc/xrdp/startwm.sh > /dev/null 2>&1
  sudo service xrdp start > /dev/null 2>&1
#EOF
