#!/usr/bin/env bash

#----------------------------------------------------------------------#
#Deps
#-----#
export DEBIAN_FRONTEND=noninteractive 
echo -e "\n==================================\n"
sudo apt install curl -y
echo -e "\n==================================\n"
sudo apt install libpcap-dev -y
echo -e "\n==================================\n"
sudo apt install wget -y
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
#Install golang
#--------------#
echo -e "\n==================================\n"
curl -qfsSL "https://git.io/go-installer" | sudo bash
sudo rm $HOME/go*.gz >/dev/null 2>&1
export PATH=$HOME/go/bin:$PATH  
export PATH=$HOME/.go/bin:$PATH  
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
#Binaries
#--------#
#eget
echo -e "\n==================================\n"
curl -qfsSL "https://zyedidia.github.io/eget.sh" | sudo bash && sudo mv ./eget /usr/local/bin/eget
#ksubdomain
echo -e "\n==================================\n"
$HOME/.go/bin/go install -v github.com/boy-hack/ksubdomain/cmd/ksubdomain@latest
#massdns
echo -e "\n==================================\n"
sudo curl -qfsSL "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/free-tiers/VPS/.binaries/massdns_x86_64_ELF_LSB_Linux" -o /usr/local/bin/massdns
sudo chmod +x /usr/local/bin/massdns
#PureDNS
echo -e "\n==================================\n"
$HOME/.go/bin/go install -v github.com/d3mondev/puredns/v2@latest 2>/dev/null
#Speedtest-go
sudo /usr/local/bin/eget showwin/speedtest-go --to /usr/local/bin/speedtest-go && sudo chmod +x /usr/local/bin/speedtest-go
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
#Test
#-----#
clear && echo -e "\n==================================\n" && sudo /usr/local/bin/massdns -h
echo -e "\n==================================\n" && $HOME/go/bin/ksubdomain test
echo -e "\n==================================\n" && $HOME/go/bin/puredns -h
#THIS CAUSES MASSIVE SPIKES
#BLOCK IS VERY LIKELY
#Confirmed Blocks: https://help.goorm.io/en/goormide/18.faq/general/why-blocked
#                  Kaggle
#echo -e "\n==================================\n" && /usr/local/bin/speedtest-go
#----------------------------------------------------------------------#
#EOF
