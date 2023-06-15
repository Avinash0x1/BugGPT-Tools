#!/usr/bin/env bash

#----------------------------------------------------------------------#
#Deps
#-----#
export DEBIAN_FRONTEND=noninteractive 
sudo apt install curl -y
sudo apt install libpcap-dev -y
sudo apt install wget -y
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
#Install golang
#--------------#
curl -qfsSL "https://git.io/go-installer" | sudo bash
sudo rm $HOME/go*.gz >/dev/null 2>&1
export PATH=$HOME/go/bin:$PATH  
export PATH=$HOME/.go/bin:$PATH  
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
#Binaries
#--------#
#eget
curl -qfsSL "https://zyedidia.github.io/eget.sh" | sudo bash && sudo mv ./eget /usr/local/bin/eget
#ksubdomain
$HOME/.go/bin/go install -v github.com/boy-hack/ksubdomain/cmd/ksubdomain@latest
#massdns
sudo curl -qfsSL "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/free-tiers/VPS/.binaries/massdns_x86_64_ELF_LSB_Linux" -o /usr/local/bin/massdns
sudo chmod +x /usr/local/bin/massdns
#PureDNS
$HOME/.go/bin/go install -v github.com/d3mondev/puredns/v2@latest 2>/dev/null
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
#Test
#-----#
clear && echo -e "==================================\n" && sudo /usr/local/bin massdns -h
echo -e "==================================\n" && $HOME/go/bin/goksubdomain test
echo -e "==================================\n" && && $HOME/go/bin/puredns -h
#----------------------------------------------------------------------#
#EOF
