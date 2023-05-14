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

#Banner
echo -e "${PINK}"
cat << "EOF"                            
               o    o
   _echoProxia_ )  ( 
{((((((((((((( ( o_o)
  /\/\/\/\/\/\\ `--                                                                                                                         
EOF
echo -e "${NC}"


#Help / Usage
if [[ "$*" == *"-h"* ]] || [[ "$*" == *"--help"* ]] || [[ "$*" == *"help"* ]] ; then
  echo -e "${YELLOW}➼ Usage${NC}: ${PINK}echoproxia${NC} ${BLUE}-d${NC} <${GREEN}download${NC} ${PURPLE}fresh proxies${NC}> ${BLUE}-v${NC} <${YELLOW}validate${NC} || ${PURPLE}filter live${NC}> ${BLUE}-mu <${GREEN}use ${PURPLE}mubeng${NC}>${NC} ${BLUE}-r ${BLUE}<rotate ${PURPLE}IP${NC} after ${GREEN}N${NC} ${YELLOW}requests${NC}>${NC} ${BLUE}-ex${NC} <auto ${RED}exit${NC} after ${GREEN}N${NC} ${YELLOW}minutes${NC}>\n"
  echo -e "${DGREEN}Extended Usage${NC} :"
  echo -e "${BLUE}-d${NC},    ${BLUE}--download${NC}            ${GREEN}Download${NC} || ${YELLOW}Verify ${PURPLE}Fresh Proxies${NC} (${YELLOW}slow${NC})"
  echo -e "${BLUE}-ex${NC},   ${BLUE}--exit-after${NC}          ${YELLOW}Auto Stop${NC} ${PURPLE}Proxy Server${NC} after ${PURPLE}N ${YELLOW}minutes${NC} (example: ${BLUE}-ex${NC} ${GREEN}5${NC})"
  echo -e "${BLUE}-f${NC},    ${BLUE}--file${NC}                ${YELLOW}Use your own ${GREEN}custom ${BLUE}proxy file${NC} [${YELLOW}Format${NC}: ${PINK}IP${NC}:${PINK}PORT${NC} (${YELLOW}1 per line${NC})]"
  echo -e "${BLUE}-mu${NC},   ${BLUE}--mubeng${NC}              ${YELLOW}Use ${PURPLE}mubeng${NC} (${DGREEN}Default${NC})"
  echo -e "${BLUE}-pb${NC},   ${BLUE}--proxy-broker${NC}        ${YELLOW}Use ${PURPLE}proxybroker${NC} (${YELLOW} rotate ${PURPLE}IP${NC} '${BLUE}-r${NC}' ${RED}NOT Supported${NC})" 
  echo -e "${BLUE}-r${NC},    ${BLUE}--rotate${NC}              ${YELLOW}Rotate ${PURPLE}IP${NC} after ${GREEN}N${NC} ${YELLOW}requests${NC} (example: ${BLUE}-r${NC} ${GREEN}5${NC})"   
  echo -e "${BLUE}-v${NC},    ${BLUE}--validate${NC}            ${YELLOW}Validate${NC} || ${PURPLE}Filter ${GREEN} Healthy (${DGREEN}live${NC})${NC} ${YELLOW}Proxies${NC} (Uses ${PURPLE}mubeng${NC})"
  echo -e "${BLUE}-fr${NC},   ${BLUE}--fireprox${NC}            ${YELLOW}Use${NC} ${RED}FireProx${NC} \n${PURPLE}how ?${NC} : ${BLUE}https://github.com/Azathothas/BugGPT-Tools/tree/main/echoproxia#fireprox${NC})\n"
 exit 0      
fi 

#Defaults:
download_proxies=
exit_after=
proxy_file=
rotate_rate=
use_mubeng=
use_proxyboker=
validate_proxies=


# Parse command line arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -d|--download)
        download_proxies=1
        shift
        ;; 
        -ex|--exit-after)
         if [ -z "$2" ]; then
             echo -e "${RED}Error: ${YELLOW}Exit${NC} after when? is missing for option ${BLUE}'-ex | --exit-after'${NC}"
             exit 1
         fi        
        exit_after="$2"
        shift
        shift
        ;;          
        -f|--file)
         if [ -z "$2" ]; then
             echo -e "${RED}Error: ${YELLOW}Proxy file${NC} is missing for option ${BLUE}'-f | --f'${NC}"
             exit 1
         fi        
        proxy_file="$2"
        shift 
        shift 
        ;;         
        -fr|--fireprox)
        use_fireprox=1
        shift
        ;;                                                           
        -mu|--mubeng)
        use_mubeng=1
        shift
        ;;        
        -pb|--proxy-broker)
        use_proxyboker=1
        shift
        ;;
        -r|--rotate)
         if [ -z "$2" ]; then
             echo -e "${RED}Error: ${YELLOW}Rotate${NC} ${PINK}IP${NC} after ${PURPLE}N${NC} requests is missing for option ${BLUE}'-r | --rotate'${NC}"
             exit 1
         fi
        rotate_rate="$2"
        shift 
        shift 
        ;;
        -v|--validate)
        validate_proxies=1
        shift
        ;;                              
        *)    
        echo -e "${RED}Error: Invalid option ${YELLOW}'$key'${NC} , try ${BLUE}--help${NC} for Usage"
        exit 1
        ;;
    esac
done




#Start Mubeng
proxy_mubeng()
{
  echo -e "➼ ${BLUE}Fetching${NC} || ${GREEN}Verifying ${PURPLE}Proxies${NC}"
  raw_proxies=$(mktemp)
  http_proxies=$(mktemp)
  mubeng_proxies=$(mktemp)
  wget --quiet https://raw.githubusercontent.com/monosans/proxy-list/main/proxies/http.txt -O $raw_proxies
  awk '{print "http://"$0}' "$raw_proxies" > $http_proxies
  #mubeng -f $http_proxies -c -g 100 -o $mubeng_proxies && sleep 5s && clear
  echo -e "➼ ${BLUE}Proxy Server ${NC} || ${PURPLE}localhost${NC}:${PURPLE}9997${NC}\n"
  #mubeng -a localhost:9997 -f $mubeng_proxies -r 1 -m random 
  mubeng -a localhost:9997 -f $http_proxies -r 1 -m random -t 2s > /dev/null 2>&1 &
  export bg_pid=$!
}
kill_mubeng()
{
  wait
  kill $bg_pid
}
