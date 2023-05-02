#!/bin/bash

#A bit of Styling
RED='\033[31m'
GREEN='\033[32m'
BLUE='\033[34m'
PURPLE='\033[35m'
YELLOW='\033[33m'
RESET='\033[0m'
NC='\033[0m'

#Help / Usage
if [[ "$*" == *"-h"* ]] || [[ "$*" == *"--help"* ]] || [[ "$*" == *"help"* ]] ; then
#Banner
echo -e "${PURPLE}"
cat << "EOF"
╔═╗ ╔╗  ╔╗       ╔╗
║═╬╦╣╚╦╦╣╚╦╦╦═╗╔═╣╚╗
╠s║u║b╠X╣t╣r╣a╚╣c╣t╣
╚═╩═╩═╩╩╩═╩╝╚══╩═╩═╝
EOF
echo -e "${NC}"
  echo -e "${YELLOW}➼ Usage${NC}: ${PURPLE}subxtract${NC} ${BLUE}-i${NC} ${GREEN}</path/to/domain/urls.txt> ${NC}"
  echo ""
  echo -e "${YELLOW}Extended Help${NC}:"
  echo -e "${BLUE}-i${NC},  ${BLUE}--input${NC}     Specify input file containing domains or urls (${YELLOW}Required${NC})\n                 else stdin: ${YELLOW}cat${NC} ${BLUE}domains.txt${NC} ${RED}| ${NC}${PURPLE}subxtract${NC}\n"
  echo -e "${BLUE}-s${NC},  ${BLUE}--subs${NC}      Extract ${BLUE}Subdomains only${NC} (default: false)"  
  echo -e "${BLUE}-up${NC}, ${BLUE}--update${NC}    ${GREEN}Update ${PURPLE}subxtract${NC}\n"
  exit 0
fi

# Update. Github caches take several minutes to reflect globally  
if [[ $# -gt 0 && ( "$*" == *"up"* || "$*" == *"-up"* || "$*" == *"update"* || "$*" == *"--update"* ) ]]; then
  echo -e "➼ ${YELLOW}Checking For ${BLUE}Updates${NC}"
      if ping -c 2 github.com > /dev/null; then
      REMOTE_FILE=$(mktemp)
      curl -s -H "Cache-Control: no-cache" https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/subxtract/subxtract.sh -o "$REMOTE_FILE"
         if ! diff --brief /usr/local/bin/subxtract "$REMOTE_FILE" >/dev/null 2>&1; then
             echo -e "➼ ${YELLOW}NEW!! Update Found! ${BLUE}Updating ..${NC}" 
             dos2unix $REMOTE_FILE > /dev/null 2>&1 
             sudo mv "$REMOTE_FILE" /usr/local/bin/subxtract && echo -e "➼ ${GREEN}Updated${NC} to ${BLUE}@latest${NC}\n" 
             echo -e "➼ ${YELLOW}ChangeLog:${NC} ${DGREEN}$(curl -s https://api.github.com/repos/Azathothas/BugGPT-Tools/commits?path=subxtract/subxtract.sh | jq -r '.[0].commit.message')${NC}"
             echo -e "➼ ${YELLOW}Pushed at${NC}: ${DGREEN}$(curl -s https://api.github.com/repos/Azathothas/BugGPT-Tools/commits?path=subxtract/subxtract.sh | jq -r '.[0].commit.author.date')${NC}\n"
             sudo chmod +xwr /usr/local/bin/subxtract
             rm -f "$REMOTE_FILE" 2>/dev/null
             else
             echo -e "➼ ${YELLOW}Already ${BLUE}UptoDate${NC}"
             echo -e "➼ Most ${YELLOW}recent change${NC} was on: ${DGREEN}$(curl -s https://api.github.com/repos/Azathothas/BugGPT-Tools/commits?path=subxtract/subxtract.sh | jq -r '.[0].commit.author.date')${NC} [${DGREEN}$(curl -s https://api.github.com/repos/Azathothas/BugGPT-Tools/commits?path=subxtract/subxtract.sh | jq -r '.[0].commit.message')${NC}]\n"             
             rm -f "$REMOTE_FILE" 2>/dev/null
             exit 0
             fi
     else
         echo -e "➼ ${YELLOW}Github.com${NC} is ${RED}unreachable${NC}"
         echo -e "➼ ${YELLOW}Try again later!${NC} "
         exit 1
     fi
  exit 0
fi

#Dependency Checks
#Golang
if ! command -v go &> /dev/null 2>&1; then
    echo "➼ golang is not installed. Installing..."
    cd /tmp && git clone https://github.com/udhos/update-golang  && cd /tmp/update-golang && sudo ./update-golang.sh
    source /etc/profile.d/golang_path.sh
else
    GO_VERSION=$(go version | awk '{print $3}')
if [[ "$(printf '%s\n' "1.20.0" "$(echo "$GO_VERSION" | sed 's/go//')" | sort -V | head -n1)" != "1.20.0" ]]; then
        echo "➼ golang version 1.20.0 or greater is not installed. Installing..."
        cd /tmp && git clone https://github.com/udhos/update-golang  && cd /tmp/update-golang && sudo ./update-golang.sh
        source /etc/profile.d/golang_path.sh
    else
        echo ""
    fi
fi
#dos2unix, for updates
if ! command -v dos2unix >/dev/null 2>&1; then
    echo "➼ dos2unix is not installed. Installing..."
    sudo apt-get update && sudo apt-get install dos2unix -y
fi
#gup
if ! command -v gup >/dev/null 2>&1; then
    echo "➼ gup is not installed. Installing..."
    go install -v github.com/nao1215/gup@latest && clear
    echo "➼ Updating all your go tools..keep patience..."
fi
#Health Check for binaries
binaries=("anew" "burpscope" "fasttld" "fff" "scopegen" "scopeview")
for binary in "${binaries[@]}"; do
    if ! command -v "$binary" &> /dev/null; then
        echo "➼ Error: $binary not found"
        echo "➼ Attempting to Install missing tools"
        #anew
        go install -v github.com/tomnomnom/anew@latest
        #burpscope
        go install -v github.com/Azathothas/BugGPT-Tools/burpscope@main        
        #fasttld 
        sudo wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/linky/assets/fasttld -O /usr/local/bin/fasttld && sudo chmod +xwr /usr/local/bin/fasttld
        #scopegen
        go install -v github.com/Azathothas/BugGPT-Tools/scopegen@main
        #scopeview
        sudo wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/scopeview/scopeview.sh -O /usr/local/bin/scopeview && sudo chmod +xwr /usr/local/bin/scopeview
        #unfurl
        go install -v github.com/tomnomnom/unfurl@latest
    fi
done

# Initialize variables
input_file=""
extract_subs=false

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -i|--input)
      input_file="$2"
      shift 
      shift 
      ;;
    -s|--subs)
      extract_subs=true
      shift 
      ;;
    *) 
      echo "Invalid: $key, use --help for help "
      exit 1
      ;;
  esac
done

# Read from file or stdin
declare -A seen_tlds=() # initialize associative array
if [[ -n "$input_file" ]]; then
  while read -r domain; do
    if $extract_subs; then
      subdomain_and_domain=$(fasttld extract "$domain" | grep -E 'domain:|suffix:' | awk '{print $2}' | sed -n '2,3p' | sed -n '1p;2p' | tr '\n' '.' | sed 's/\.$//')
      if [[ -n "$subdomain_and_domain" && -z "${seen_tlds[$subdomain_and_domain]}" ]]; then
        echo "$subdomain_and_domain"
        seen_tlds[$subdomain_and_domain]=1
      fi
    else
      tld=$(fasttld extract "$domain" | awk '/^ *domain:/ {print $NF}')
      if [[ -n "$tld" && -z "${seen_tlds[$tld]}" ]]; then
        echo "$tld"
        seen_tlds[$tld]=1
      fi
    fi
  done < "$input_file"
else
  while read -r domain; do
    if $extract_subs; then
      subdomain_and_domain=$(fasttld extract "$domain" | grep -E 'domain:|suffix:' | awk '{print $2}' | sed -n '2,3p' | sed -n '1p;2p' | tr '\n' '.' | sed 's/\.$//')
      if [[ -n "$subdomain_and_domain" && -z "${seen_tlds[$subdomain_and_domain]}" ]]; then
        echo "$subdomain_and_domain"
        seen_tlds[$subdomain_and_domain]=1
      fi
    else
      tld=$(fasttld extract "$domain" | awk '/^ *domain:/ {print $NF}')
      if [[ -n "$tld" && -z "${seen_tlds[$tld]}" ]]; then
        echo "$tld"
        seen_tlds[$tld]=1
      fi
    fi
  done
fi

#Check For Update on Script end
#Update. Github caches take several minutes to reflect globally  
   if ping -c 2 github.com > /dev/null; then
      REMOTE_FILE=$(mktemp)
      curl -s -H "Cache-Control: no-cache" https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/subxtract/subxtract.sh -o "$REMOTE_FILE"
         if ! diff --brief /usr/local/bin/subxtract "$REMOTE_FILE" >/dev/null 2>&1; then
              echo ""
              echo -e "➼ ${YELLOW}Update Found!${NC} ${BLUE}updating ..${NC} $(subxtract -up)" 
         else
            rm -f "$REMOTE_FILE" 2>/dev/null
              exit 0
         fi
   fi
#EOF