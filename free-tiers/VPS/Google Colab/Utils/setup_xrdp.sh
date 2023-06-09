#!/usr/bin/env bash
#vars
export origin=$(pwd)
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
  sudo apt-get install --assume-yes debconf debconf-utils tzdata
fi
#KeyBoard Layout
  sudo DEBIAN_FRONTEND=noninteractive apt-get install keyboard-configuration
  sudo debconf-set-selections <<< 'keyboard-configuration keyboard-configuration/layout select us'
  sudo debconf-set-selections <<< 'keyboard-configuration keyboard-configuration/xkb-keymap select us'
  debconf-show keyboard-configuration
  sleep 5s
#TimeZones
  sudo debconf-set-selections <<< 'tzdata tzdata/Areas select Asia'
  sudo debconf-set-selections <<< 'tzdata tzdata/Zones/Asia select Kathmandu'
#xfce4 DE
  sudo DEBIAN_FRONTEND=noninteractive apt install xfce4 xfce4-terminal xrdp --assume-yes
#Some Misc Tools
  sudo DEBIAN_FRONTEND=noninteractive apt install codium libu2f-udev mousepad --assume-yes
  cd $(mktemp -d) && eget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && sudo dpkg -i google-chrome-stable_current_amd64.deb
#Session
  sudo sed -i.bak '/fi/a xfce4-session \n' /etc/xrdp/startwm.sh > /dev/null 2>&1
  sudo service xrdp start > /dev/null 2>&1
cd "$origin"  
#EOF
