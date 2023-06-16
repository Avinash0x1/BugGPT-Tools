#!/usr/bin/env bash

#----------------------------------------------------------------------#
#Sanity Checks
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root"
  echo -e " First: \n sudo su || su \n"
  echo -e 'Then: curl -qfsSl "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/free-tiers/VPS/.scripts/debian_dns_brute_sudo_root.sh" | sudo bash \n'
  exit 1
fi
#Incase called from a non sudo, but root environ
if ! command -v sudo >/dev/null 2>&1; then
    echo -e "➼ sudo is not installed. Installing...\n"
    apt-get update && apt-get install sudo -y
    # Recheck
       if ! command -v sudo >/dev/null 2>&1; then
         echo -e " ➼ sudo was not installed. \nTried Installing & Failed"
         echo " Maybe Try Manually : https://www.sudo.ws/getting/download/\n"
         exit 1
       fi
fi
#ctrl c
# Function to handle Ctrl + C
ctrl_c() {
  echo -e "\nCtrl + C pressed. Exiting...\n"
  echo -e "\n==================================\n"
  curl -qfsSl "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/free-tiers/VPS/.scripts/debian_dns_brute_sudo_root.sh" | cat
  echo -e "\n==================================\n"
  exit 1
}
# Set up the trap to catch the interrupt signal (SIGINT)
trap ctrl_c SIGINT
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
#Deps
#-----#
export DEBIAN_FRONTEND=noninteractive 
echo -e "\n==================================\n Installing Curl\n"
sudo apt install curl -y
echo -e "\n==================================\n Installing libpcap-dev\n"
sudo apt install libpcap-dev -y
echo -e "\n==================================\n Installing net-tools\n"
sudo apt install net-tools -y
echo -e "\n==================================\n Installing tcpdump\n"
sudo apt install tcpdump -y
sudo apt install libcap2-bin -y
echo -e "\n==================================\n Installing wget\n"
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
echo -e "\n==================================\n Installing eget\n"
curl -fSL "https://zyedidia.github.io/eget.sh" | sudo bash && sudo mv ./eget /usr/local/bin/eget
#ksubdomain
echo -e "\n==================================\n Installing Ksubdomain\n"
$HOME/.go/bin/go install -v github.com/boy-hack/ksubdomain/cmd/ksubdomain@latest
#massdns
echo -e "\n==================================\n Installing massdns\n"
sudo curl -fSL "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/free-tiers/VPS/.binaries/massdns_x86_64_ELF_LSB_Linux" -o /usr/local/bin/massdns
sudo chmod +x /usr/local/bin/massdns
#PureDNS
echo -e "\n==================================\n  Installing PureDNS\n"
$HOME/.go/bin/go install -v github.com/d3mondev/puredns/v2@latest 2>/dev/null
#Speedtest-go
sudo /usr/local/bin/eget showwin/speedtest-go --to /usr/local/bin/speedtest-go && sudo chmod +x /usr/local/bin/speedtest-go
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
#Test
#-----#
clear && echo -e "\n==================================\n" && sudo /usr/local/bin/massdns -h
echo -e "\n==================================\n"
# Perm Errors
if sudo tcpdump -i eth0 2>&1 | grep -q "Operation not permitted"; then
    echo -e "\ncap_net Privilege is Disabled by Default\n Trying a hot fix...."
     # https://askubuntu.com/questions/530920/tcpdump-permissions-problem
     sudo cp $(which tcpdump) /usr/sbin/tcpdump
     sudo chmod +xwr /usr/sbin/tcpdump
     sudo ln -s /usr/sbin/tcpdump /usr/local/bin/tcpdump
     sudo groupadd pcap
     sudo usermod -a -G pcap root
     sudo setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump
     sudo chown root:root /usr/sbin/tcpdump
     sudo chmod 755 /usr/sbin/tcpdump  
     sudo chgrp pcap /usr/sbin/tcpdump
     sudo chmod 750 /usr/sbin/tcpdump
     sudo setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump
     sudo chown root:root /usr/sbin/tcpdump
     sudo chmod 755 /usr/sbin/tcpdump  
     sudo chmod +xwr /usr/sbin/tcpdump  
     sudo chmod +xwr /usr/bin/tcpdump  
     ls -l /usr/sbin/tcpdump
     getcap /usr/sbin/tcpdump
    if sudo tcpdump -i eth0 2>&1 | grep -q "Operation not permitted"; then
         echo -e "\nFailed to change perms to capture raw packets\n"
    else
         echo -e "\nSuccessfully added cap_net Privilege\n"  
         sudo $HOME/go/bin/ksubdomain test
    fi  
else
     sudo $HOME/go/bin/ksubdomain test
fi    
echo -e "\n==================================\n" && sudo $HOME/go/bin/puredns -h
#THIS CAUSES MASSIVE SPIKES
#BLOCK IS VERY LIKELY
#Confirmed Blocks: https://help.goorm.io/en/goormide/18.faq/general/why-blocked
#                  Kaggle
#echo -e "\n==================================\n" && /usr/local/bin/speedtest-go
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
#-------------#
#Get Files
#---------#
#Generated from Huge Data Set for Line on Gcloud Shell
#shuf -n {N} > {OutFile} # Not really Efficient, but Enough
#AnonFiles#
#dns_resolvers_test_1M.txt 302 MB
echo -e "\n==================================\n Downloading dns_resolvers_test_1M.txt (30.2 MB)\n" 
curl -fLO $(curl -qfsSL https://anonfiles.com/3270Oew0z5/dns_resolvers_test_1M_txt | grep dns_resolvers_test_1M.txt | grep -o 'href="[^"]*"' | cut -d'"' -f2)
#dns_resolvers_test_5M.txt 302 MB
echo -e "\n==================================\n Downloading dns_resolvers_test_5M.txt (151 MB)\n" 
curl -fLO $(curl -qfsSL https://anonfiles.com/W273Odwezf/dns_resolvers_test_5M_txt | grep dns_resolvers_test_5M.txt | grep -o 'href="[^"]*"' | cut -d'"' -f2)
#dns_resolvers_test_10M.txt 302 MB
echo -e "\n==================================\n Downloading dns_resolvers_test_10M.txt (302 MB)\n" 
curl -fLO $(curl -qfsSL https://anonfiles.com/lbi0X8wdz9/dns_resolvers_test_10M_txt | grep dns_resolvers_test_10M.txt | grep -o 'href="[^"]*"' | cut -d'"' -f2)
#dns_resolvers_test_50M.txt 1541 MB
echo -e "\n==================================\n" 
echo -e "Skipping Downloading: dns_resolvers_test_50M.txt (1541 MB)\n Do Manually:"
echo -e "\ncurl -fLO \$(curl -qfsSL https://anonfiles.com/B1qcX8w3za/dns_resolvers_test_50M_txt | grep dns_resolvers_test_50M.txt | grep -o 'href=\"[^\"]*\"' | cut -d'\"' -f2)\n"
#Alts: 
# https://files.fm/
# https://racaty.io/
# https://www.prontoshare.com
# https://uploady.io
# https://gofile.io/faq
#-------------#
#Get Resolvers
#------------#
curl -qfsSL "https://raw.githubusercontent.com/proabiral/Fresh-Resolvers/master/resolvers.txt" -o ./resolvers_proabiral.txt
curl -qfsSL "https://raw.githubusercontent.com/trickest/resolvers/main/resolvers.txt" -o ./resolvers_trickest.txt
#-------------#
#Generate cmds
#-------------#
echo -e "\n==================================\n" 
#No Limiters 
#-----------#
echo -e "$HOME/go/bin/puredns resolve ./dns_resolvers_test_1M.txt --resolvers ./resolvers_proabiral.txt --write ./dns_resolvers_test_1M_RESOLVED.txt\n"
echo -e "$HOME/go/bin/puredns resolve ./dns_resolvers_test_10M.txt --resolvers ./resolvers_proabiral.txt --write ./dns_resolvers_test_10M_RESOLVED.txt\n"
echo -e "$HOME/go/bin/puredns resolve ./dns_resolvers_test_50M.txt --resolvers ./resolvers_proabiral.txt --write ./dns_resolvers_test_50M_RESOLVED.txt\n"
#RateLimits 
#----------#
#Anything below 5K/S is USELESS
echo -e "$HOME/go/bin/puredns resolve ./dns_resolvers_test_1M.txt --resolvers ./resolvers_proabiral.txt --rate-limit 10000 --write ./dns_resolvers_test_1M_RESOLVED.txt\n"
echo -e "$HOME/go/bin/puredns resolve ./dns_resolvers_test_10M.txt --resolvers ./resolvers_proabiral.txt --rate-limit 10000 --write ./dns_resolvers_test_10M_RESOLVED.txt\n"
#EOF
