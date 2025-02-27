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
VIOLET='\033[0;35m'
RESET='\033[0m'
NC='\033[0m'
#---------------------------------------------------------------------------------------#
#Main
 #Unattended
 export DEBIAN_FRONTEND=noninteractive
 import_parrot_keys()
{ 
    clear && echo -e "➼${GREEN} Importing ${PURPLE}Parrot${NC} Keys${NC}\n"
if command -v sudo &> /dev/null 2>&1; then
     sudo export DEBIAN_FRONTEND=noninteractive sudo apt install gnupg -y
     #Download & Append
     curl -qfs "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/free-tiers/VPS/.scripts/debian_parrot_sources.list" | sudo tee -a /etc/apt/sources.list
     sudo export DEBIAN_FRONTEND=noninteractive sudo apt update -y
     # Extract PUBKEY values
     pubkeys=$(sudo apt update 2>&1 | grep NO_PUBKEY | awk '{print $NF}')
     for pubkey in $pubkeys
     do
        sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com "$pubkey"
    done
    #Clean & Update
    sudo apt-get clean -y && sudo apt-get update
else
    export DEBIAN_FRONTEND=noninteractive apt install gnupg -y
    curl -qfs "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/free-tiers/VPS/.scripts/debian_parrot_sources.list" | tee -a /etc/apt/sources.list
    apt update -y
    # Extract PUBKEY values
     pubkeys=$(apt update 2>&1 | grep NO_PUBKEY | awk '{print $NF}')
         for pubkey in $pubkeys
     do
        apt-key adv --recv-keys --keyserver keyserver.ubuntu.com "$pubkey"
    done
    #Clean & Update
    apt-get clean -y && apt-get update
fi   
}
import_parrot_keys
#---------------------------------------------------------------------------------------#
