#!/usr/bin/env bash

#A bit of Styling
RED='\033[31m'
GREEN='\033[32m'
DGREEN='\033[38;5;28m'
GREY='\033[37m'
BLUE='\033[34m'
YELLOW='\033[33m'
PURPLE='\033[35m'
PINK='\033[38;5;206m'
RESET='\033[0m'
NC='\033[0m'

#-------------------------------------------------------------------------------#
#Startup
# # fail if any commands fails
# set -e
# # debug log
# set -x
echo -e "➼ ${YELLOW}Machine :\n${BLUE}$(uname -a)${NC}\n"
echo -e "➼ ${YELLOW}UserName : ${BLUE}$(whoami)${NC}\n"
ssh_username=$(whoami) && export ssh_username="$ssh_username"
#-------------------------------------------------------------------------------#

#-------------------------------------------------------------------------------#
#Pricing: https://bitrise.io/pricing
#Right Click (Gear Setting Icon) >> OverView
#300 Credits/month [One Time +500 Survey Credits (New Acc only)]
# DashBoard >> WorkSpace >> Project >> WorkFlow Editor >> Stacks & Machines
#M1 Medium : 2 Credits/Min
#M1 Large  : 4 Credits/Min
#-------------------------------------------------------------------------------#

#-------------------------------------------------------------------------------#
#ENV VARS
#Change this only
export AuthKey=$tailscale_authkey
#For Reference Only (DO NOT UNCOMMENT)
#export USER=vagrant
#export PASSWORD=vagrant
#export HOME=/Users/vagrant
# export PATH=/Users/Vagrant/.asdf/shims:/Users/Vagrant/.asdf/bin:/Users/vagrant/.jenv/shims:/Users/vagrant/.pyenv/shims:/Users/vagrant/.rbenv/shims:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/local/sbin:~/bin:/Users/vagrant/.bitrise/tools:/opt/homebrew/opt/curl/bin:/Users/vagrant/.jenv/shims:/Users/vagrant/.pyenv/shims:/Users/vagrant/.rbenv/shims:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/local/sbin:~/bin:/Users/vagrant/.jenv/shims:/Users/vagrant/.pyenv/shims:/Users/vagrant/.rbenv/shims:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/vagrant/go/bin:/Users/vagrant/.pub-cache/bin:/Users/vagrant/fvm/default/bin:/Users/vagrant/bitrise/tools/cmd-bridge/bin/osx:/usr/local/share/android-sdk/ndk-bundle:/usr/local/share/android-sdk/platform-tools:/usr/local/share/android-sdk/cmdline-tools/cmdline-tools/bin:/Users/vagrant/.mint/bin:/Users/vagrant/.jenv/bin:/usr/sbin:/Users/vagrant/go/bin:/Users/vagrant/.pub-cache/bin:/Users/vagrant/fvm/default/bin:/Users/vagrant/bitrise/tools/cmd-bridge/bin/osx:/usr/local/share/android-sdk/ndk-bundle:/usr/local/share/android-sdk/platform-tools:/usr/local/share/android-sdk/cmdline-tools/cmdline-tools/bin:/Users/vagrant/.mint/bin:/Users/vagrant/.jenv/bin:/Users/vagrant/go/bin:/Users/vagrant/.pub-cache/bin:/Users/vagrant/fvm/default/bin:/Users/vagrant/bitrise/tools/cmd-bridge/bin/osx:/usr/local/share/android-sdk/ndk-bundle:/usr/local/share/android-sdk/platform-tools:/usr/local/share/android-sdk/cmdline-tools/cmdline-tools/bin:/Users/vagrant/.mint/bin:/Users/vagrant/.jenv/bin:/Users/Vagrant/.asdf/installs/golang/1.18.10/go/bin:/Users/vagrant/go/bin
#-------------------------------------------------------------------------------#

#-------------------------------------------------------------------------------#
#TunShell (Optional) [For Quick Diagnosis]
#Uncomment & Copy Paste (Target Host Scrpt)
# MUST INCLUDE `&` at end (so it runs in bg)
#curl -sSf https://lets.tunshell.com/init.sh | sh -s -- T jRBDuZI2ndguF7lTUotWkI BUw28rCgUYlKxXLLIgeqio eu.relay.tunshell.com &
#-------------------------------------------------------------------------------#

#-------------------------------------------------------------------------------#
#SysInfo
#Pure Mac neofetch
echo -e "➼ ${YELLOW}SysInfo :\n ${BLUE}$(system_profiler SPHardwareDataType)${NC}\n"
#Actual neofetch (archey better than neofetch, also MUST use pip3)
python3 -m pip install --upgrade pip >/dev/null 2>&1
pip3 install archey4 >/dev/null 2>&1 &&
echo -e "➼ ${YELLOW}Distro :\n ${BLUE}$(archey)${NC}\n"
#htop for MAC
# pip3 install bpytop && bpytop
#-------------------------------------------------------------------------------#

#-------------------------------------------------------------------------------#
#Binaries
# bash -c "$(curl -qfsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# brew install eget
#-------------------------------------------------------------------------------#

#-------------------------------------------------------------------------------#
#Enable SSH
echo -e "➼ ${YELLOW}SSH :\n"
sudo systemsetup -setremotelogin on
sudo systemsetup -getremotelogin
#Allow Password Auth
sudo sed -i '' 's/^#*\(PasswordAuthentication\).*$/\1 Yes/' /etc/ssh/sshd_config
#Reload sshd_config
sudo launchctl unload /System/Library/LaunchDaemons/ssh.plist
sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist
#Restart SSHD
sudo launchctl kickstart -k system/com.openssh.sshd
sudo launchctl stop com.openssh.sshd ; sudo launchctl start com.openssh.sshd
echo -e ""
#-------------------------------------------------------------------------------#

#-------------------------------------------------------------------------------#
#Install/Update Golang
echo -e "➼ ${BLUE}Updating ${PURPLE}Golang${DGREEN}.....${NC}\n"
bash <(curl -qfsSL https://git.io/go-installer) 
export PATH=$HOME/go/bin:$PATH
#Install TailScale
# https://github.com/tailscale/tailscale/wiki/Tailscaled-on-macOS
echo -e "\n➼ ${BLUE}Installling ${PURPLE}TailScale${DGREEN}.....${NC}\n"
echo -e "${DGREEN}$(go install tailscale.com/cmd/tailscale{,d}@main)${NC}\n"
#Enable TailScale
echo -e "➼ ${BLUE}Setting Up ${PURPLE}TailScale${DGREEN}.....${NC}\n"
sudo "$HOME/go/bin/tailscaled" install-system-daemon &
sudo "$HOME/go/bin/tailscaled" &
#Auth TailScale
echo -e "\n ➼${BLUE} Authenticating ${PURPLE}TailScale${DGREEN}...${NC}"
sudo "$HOME/go/bin/tailscale" up --ssh --authkey="$AuthKey" --hostname="Bitrise-Mac-OSX-Ventura" 
echo -e "${DGREEN}$(sudo $HOME/go/bin/tailscale status --peers=false)${NC}\n"
tailscale_ip=$(tailscale ip -4)
echo -e "\n${PINK}SSH${NC}: ${YELLOW} ssh ${BLUE}$ssh_username${YELLOW}@${PURPLE}$tailscale_ip${NC}"
echo -e "${YELLOW} PASSWORD ${NC} : ${RED}vagrant${NC}\n"
#-------------------------------------------------------------------------------#

#-------------------------------------------------------------------------------#
#Utils
# #Pure MAC netstat
# sudo lsof -iTCP -sTCP:LISTEN -n -P
# #List all connected users
# who -a
# #List all SSH Connections
# sudo lsof -i :22 | grep LISTEN
#-------------------------------------------------------------------------------#

#-------------------------------------------------------------------------------#
#VNC
echo -e "➼ ${BLUE} Setting up ${PURPLE}VNC${DGREEN}.....${NC}\n"
## Slow: https://www.scaleway.com/en/blog/m1-how-a-design-flaw-slowed-down-apples-vnc/
#1. https://apple.stackexchange.com/questions/437555/macos-networking-brutally-slow-using-vnc-or-apple-remote-desktop
echo "net.inet.tcp.delayed_ack=0" | sudo tee -a /etc/sysctl.conf
sudo sysctl -w net.inet.tcp.delayed_ack=0
#2. 
#Disable Spotlight Indexing
sudo mdutil -i off -a
#Enable VNC
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -allUsers -privs -all
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -clientopts -setvnclegacy -vnclegacy yes 
#VNC password
echo "vagrant" | perl -we 'BEGIN { @k = unpack "C*", pack "H*", "1734516E8BA8C5E2FF1C39567390ADCA"}; $_ = <>; chomp; s/^(.{8}).*/$1/; @p = unpack "C*", $_; foreach (@k) { printf "%02X", $_ ^ (shift @p || 0) }; print "\n"' | sudo tee /Library/Preferences/com.apple.VNCSettings.txt
#Start VNC
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent -console
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate
echo -e "\n${YELLOW}VNC${NC}: ${PURPLE}$tailscale_ip:5900${NC}"
echo -e "${YELLOW} PASSWORD ${NC} : ${RED}vagrant${NC}"

#-------------------------------------------------------------------------------#

#-------------------------------------------------------------------------------#
#Sleep 
sleep 69420
#-------------------------------------------------------------------------------#
