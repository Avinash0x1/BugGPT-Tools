#!/usr/bin/env bash

#Incase called from a non sudo, but root environ
if ! command -v sudo >/dev/null 2>&1; then
    echo "➼ sudo is not installed. Installing...\n"
    sudo apt-get update && sudo apt-get install sudo -y
    # Recheck
       if ! command -v sudo >/dev/null 2>&1; then
         echo -e " ➼ sudo was not installed. \nTried Installing & Failed"
         echo " Maybe Try Manually : https://www.sudo.ws/getting/download/\n"
         exit 1
       fi
fi
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

#----------------------------------------------------------------------#
#-------------#
#Get Files
#---------#
#Generated from Huge Data Set for Line on Gcloud Shell
#shuf -n {N} > {OutFile} # Not really Efficient, but Enough
#AnonFiles#
echo -e "\n==================================\n" 
#30.2 MB
curl -qfSLO $(curl -qfsSL https://anonfiles.com/3270Oew0z5/dns_resolvers_test_1M_txt | grep dns_resolvers_test_1M.txt | grep -o 'href="[^"]*"' | cut -d'"' -f2)
echo -e "\n==================================\n" 
#151 MB
curl -qfSLO $(curl -qfsSL https://anonfiles.com/W273Odwezf/dns_resolvers_test_5M_txt | grep dns_resolvers_test_5M.txt | grep -o 'href="[^"]*"' | cut -d'"' -f2)
echo -e "\n==================================\n" 
#302 MB
curl -qfSLO $(curl -qfsSL https://anonfiles.com/lbi0X8wdz9/dns_resolvers_test_10M_txt | grep dns_resolvers_test_10M.txt | grep -o 'href="[^"]*"' | cut -d'"' -f2)
echo -e "\n==================================\n" 
echo -e "Skipping Downloading: dns_resolvers_test_50M.txt (1541 MB)\n Do Manually:"
#1541 MB
echo -e "\ncurl -qfSLO \$(curl -qfsSL https://anonfiles.com/B1qcX8w3za/dns_resolvers_test_50M_txt | grep dns_resolvers_test_50M.txt | grep -o 'href=\"[^\"]*\"' | cut -d'\"' -f2)\n"
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
