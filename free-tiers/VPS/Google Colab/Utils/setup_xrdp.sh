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
# Check if debconf is installed
if ! dpkg -s debconf >/dev/null 2>&1; then
  echo "debconf is not installed. Installing debconf..."
  sudo apt-get update
  sudo apt-get install --assume-yes debconf
fi  
#KeyBoard Layout
  sudo debconf-set-selections <<< 'keyboard-configuration keyboard-configuration/layout select us'
#xfce4 DE
  sudo apt install --assume-yes xfce4 xfce4-terminal xrdp
#Session
  sudo sed -i.bak '/fi/a xfce4-session \n' /etc/xrdp/startwm.sh > /dev/null 2>&1
  sudo service xrdp start > /dev/null 2>&1
#EOF
