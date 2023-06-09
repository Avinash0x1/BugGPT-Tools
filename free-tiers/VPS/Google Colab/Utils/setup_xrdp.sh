#!/usr/bin/env bash
#tailscale
#This is now natively checked
# if ! command -v tailscale &> /dev/null; then
#    echo -e "\n X Fatal: No TailScale Sessions Found\n"
#    echo -e "Did you run Step 2 : 'SSH' || 'Remote Access' ?\n"
#   exit 1
# fi  
#Unattended
  export DEBIAN_FRONTEND=noninteractive
#xfce4 DE
  sudo apt install --assume-yes xfce4 xfce4-terminal xrdp
#Session
  sudo sed -i.bak '/fi/a xfce4-session \n' /etc/xrdp/startwm.sh > /dev/null 2>&1
  sudo service xrdp start > /dev/null 2>&1
#EOF
