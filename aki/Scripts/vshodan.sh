#!/usr/bin/bash

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

#Help / Usage
if [[ "$*" == *"-h"* ]] || [[ "$*" == *"--help"* ]] || [[ "$*" == *"help"* ]] ; then
  echo -e "${YELLOW}➼ Usage${NC}:"
  echo -e "${BLUE}-s${NC},  ${BLUE}--shodan${NC}           ${BLUE}File containing ${PURPLE}Shodan API Keys${NC} [${YELLOW}1 per line${NC}]"
  echo -e "${BLUE}-q${NC},  ${BLUE}--quota${NC}            ${BLUE}Check ${YELLOW}Quota${NC} || ${YELLOW}Usage${NC}\n"
  exit 0
fi

#Default
quota=
# Parse command line arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -s|--shodan)
        shodan_keys="$2"
        shift 
        shift 
        ;;
        -q|--quota)
        quota=1
        shift 
        ;;
        *)    
        echo -e "${RED}Error: Invalid option ${YELLOW}'$key'${NC}, use ${BLUE}-s${NC} | ${BLUE}-q${NC}"
        exit 1
        ;;
    esac
done

#Exp Values
export shodan_keys=$shodan_keys
export quota=$quota
#Dependency checks
#ansi2txt
if ! command -v ansi2txt >/dev/null 2>&1; then
    echo "➼ ansi2txt is not installed. Installing..."
    pip3 install ansi2txt
fi    
#dos2unix, for updates
if ! command -v dos2unix >/dev/null 2>&1; then
    echo "➼ dos2unix is not installed. Installing..."
    sudo apt-get update && sudo apt-get install dos2unix -y
fi
#jq, for parsing curl json
if ! command -v jq >/dev/null 2>&1; then
    echo "➼ jq is not installed. Installing..."
    sudo apt-get update && sudo apt-get install jq -y
fi
#yq, for parsing yaml
if ! command -v yq >/dev/null 2>&1; then
    echo "➼ yq is not installed. Installing..."
    sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq && sudo chmod +xwr /usr/local/bin/yq
fi
#Health Check for Tools
paths=("$HOME/Tools/AKI/Deps/APIKEYBEAST-forked.py" "$HOME/Tools/AKI/Deps/APIKEYBEAST-requirements.txt")
for path in "${paths[@]}"; do
    if [ ! -f "$path" ]; then
        echo -e "➼ ${RED}Error${NC}: ${PINK}$path${NC} not found"
        echo "➼ Attempting to Install missing tools under $HOME/Tools $(mkdir -p $HOME/Tools)"    
        #APIKEYBEAST
        mkdir -p $HOME/Tools/AKI/Deps/ && cd $HOME/Tools/AKI/Deps/ && wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/aki/Deps/APIKEYBEAST-forked.py -O $HOME/Tools/AKI/Deps/APIKEYBEAST-forked.py
        wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/aki/Deps/APIKEYBEAST-requirements.txt -O $HOME/Tools/AKI/Deps/APIKEYBEAST-requirements.txt
        dos2unix $HOME/Tools/AKI/Deps/APIKEYBEAST-forked.py && dos2unix $HOME/Tools/AKI/Deps/APIKEYBEAST-requirements.txt
        pip3 install -r $HOME/Tools/AKI/Deps/APIKEYBEAST-requirements.txt
        clear && cd -
    fi
done

#Check Internet
if ! ping -c 2 github.com > /dev/null; then
   echo -e "${RED}\u2717 Fatal${NC}: ${YELLOW}No Internet${NC}"
 exit 1
fi

##Github -gh
if [ -n "$shodan_keys" ] && [ -e "$shodan_keys" ]; then
echo -e "${YELLOW}\n"
cat << "EOF"       
┏━━━┳┓      ┏┓
┃┏━┓┃┃      ┃┃
┃┗━━┫┗━┳━━┳━┛┣━━┳━┓
┗━━┓┃┏┓┃┏┓┃┏┓┃┏┓┃┏┓┓
┃┗━┛┃┃┃┃┗┛┃┗┛┃┏┓┃┃┃┃
┗━━━┻┛┗┻━━┻━━┻┛┗┻┛┗┛
EOF
echo -e "${NC}"                                  
        Shodan_api_keys=$(cat $shodan_keys | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//' | sed '/^$/d' | grep -oE '\b[a-zA-Z0-9]{32}\b')
        invalid_key_found=false
          if [ -n "$Shodan_api_keys" ]; then
              #echo -e "ⓘ ${VIOLET} Shodan${NC} has ${YELLOW}Rate Limits${NC} so have ${GREEN}Patience${NC}"           
                  i=1
                  while read -r api_key; do
                  var_name="Shodan_api_key_$i"
                  eval "$var_name=\"$api_key\""
                  i=$((i+1))
                  done <<< "$Shodan_api_keys"
                     #curl
                    for ((j=1; ; j++)); do
                          var_name="Shodan_api_key_$j"
                          api_key=${!var_name}
                     if [ -z "$api_key" ]; then
                       break
                     fi
                          response=$(curl -qski "https://api.shodan.io/api-info?key=$api_key" -H "Accept: application/json")
                          status_code=$(echo "$response" | awk '/HTTP/{print $2}')
                     if [ "$status_code" = "401" ] || [ "$status_code" = "403" ]; then
                       echo -e "ⓘ ${VIOLET} Shodan${NC} ${YELLOW}API key${NC} = ${BLUE}$api_key${NC} ${RED}\u2717 Invalid${NC}"
                       invalid_key_found=true
                     elif [ "$status_code" = "429" ]; then
                       echo -e "ⓘ ${VIOLET} Shodan${NC} ${YELLOW}API key${NC} = ${BLUE}$api_key${NC} ${RED}\u2717 Failed Checks${NC} [${YELLOW}429: Too many requests${NC}]"
                       invalid_key_found=true   
                     elif [[ "$status_code" = "200" && -n "$quota" ]]; then
                          echo -e "ⓘ ${VIOLET} Shodan${NC}"
                           export SHODAN_API_KEY="$api_key" 
                           export SHODAN_USERNAME=$(curl -qsk "https://api.shodan.io/account/profile?key=$api_key" -H "Accept: application/json" | jq -r '.display_name')
                           echo -e "${YELLOW}API key${NC} : ${PURPLE}$api_key${NC}"                            
                           python3 $HOME/Tools/AKI/Deps/APIKEYBEAST-forked.py -s shodan      
                           echo -e "\n"                           
                     fi                   
              done
              if ! $invalid_key_found; then
                  echo -e "ⓘ ${VIOLET} Shodan${NC} : ${GREEN}\u2713${NC}"  
              fi  
         fi
fi         
#EOF 