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
  echo -e "${BLUE}-gh${NC},  ${BLUE}--github${NC}           ${BLUE}File containing ${PURPLE}Github Tokens${NC} [${YELLOW}1 per line${NC}]"
  echo -e "${BLUE}-gl${NC},  ${BLUE}--gitlab${NC}           ${BLUE}File containing ${PURPLE}Gitlab Tokens${NC} [${YELLOW}1 per line${NC}]"
  echo -e "${BLUE}-o${NC},   ${BLUE}--output${NC}           ${BLUE}Output ${YELLOW}dir/file${NC}"
  echo -e "${BLUE}-r${NC},   ${BLUE}--remove${NC}           ${PINK}Removes ${RED}Invalid tokens${NC} & ${YELLOW}Rewrites ${BLUE}original${NC}\n"
  exit 0
fi

# Defaults
remove=
# Parse command line arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -gh|--github)
        github_tokens="$2"
        shift 
        shift 
        ;;
        -gl|--gitlab)
        gitlab_tokens="$2"
        shift 
        shift 
        ;;
        -o|--output)
        if [ -z "$2" ]; then
             echo -e "${YELLOW}Info: ${YELLOW}Output filename${NC} is missing for option ${BLUE}'-o | --output'${NC}"
             if [ -n "$gitlab_tokens" ] && [ -e "$gitlab_tokens" ]; then 
                 echo -e "${YELLOW}Default: ${BLUE}$(pwd)/gitlab-valid.txt"
             elif [ -n "$github_tokens" ] && [ -e "$github_tokens" ]; then
                 echo -e "${YELLOW}Default: ${BLUE}$(pwd)/github-valid.txt" 
             fi 
        fi        
        output="$2"
        shift
        shift 
        ;;        
        -r|--remove)
        remove=1
        shift
        ;;                
        *)    
        echo -e "${RED}Error: Invalid option ${YELLOW}'$key'${NC}, use ${BLUE}-gh${NC} | ${BLUE}-gl${NC}"
        exit 1
        ;;
    esac
done

#Dependency checks
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

#Check Internet
if ! ping -c 2 github.com > /dev/null; then
   echo -e "${RED}\u2717 Fatal${NC}: ${YELLOW}No Internet${NC}"
 exit 1
fi

##Github -gh
if [ -n "$github_tokens" ] && [ -e "$github_tokens" ]; then
     if [ -z "$output" ]; then
     export output="$(pwd)/github-valid.txt"
     fi
echo -e "${BLUE}\n"
cat << "EOF"       
   _____ _ _   _    _       _     
  / ____(_) | | |  | |     | |    
 | |  __ _| |_| |__| |_   _| |__  
 | | |_ | | __|  __  | | | | '_ \ 
 | |__| | | |_| |  | | |_| | |_) |
  \_____|_|\__|_|  |_|\__,_|_.__/ 
EOF
echo -e "${NC}"
        sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//' -i "$github_tokens" ; sed '/^$/d' -i "$github_tokens"
        sort -u "$github_tokens" -o "$github_tokens"
        GitHub_api_keys=$(cat $github_tokens | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//' | sed '/^$/d' | grep "^ghp")
        invalid_key_found=false
          if [ -n "$GitHub_api_keys" ]; then
                echo -e "ⓘ ${VIOLET} Github${NC} has ${YELLOW}Rate Limits${NC} so have ${GREEN}Patience${NC}"
                  i=1
                  while read -r api_key; do
                  var_name="GitHub_api_key_$i"
                  eval "$var_name=\"$api_key\""
                  i=$((i+1))
                  done <<< "$GitHub_api_keys"
                     #curl
                    for ((j=1; ; j++)); do
                          var_name="GitHub_api_key_$j"
                          api_key=${!var_name}
                     if [ -z "$api_key" ]; then
                       break
                     fi
                          response=$(curl -qski  "https://api.github.com/repos/Azathothas/BugGPT-Tools/stats/code_frequency" -H "Authorization: Bearer $api_key" -H "Accept: application/vnd.github+json"  && sleep 20s)
                          remove_github_func(){
                          sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//' -i "$github_tokens" ; sed '/^$/d' -i "$github_tokens" ; sed "/$api_key/d" -i "$github_tokens"
                          }
                          if echo "$response" | grep -q "Bad credentials"; then   
                           echo -e "ⓘ ${VIOLET} GitHub${NC} ${YELLOW}API key${NC} = ${BLUE}$api_key${NC} ${RED}\u2717 Invalid${NC}"
                           invalid_key_found=true     
                                if [ -n "$remove" ] && [ "$remove" -eq 1 ]; then
                                     remove_github_func
                                fi                      
                          elif [ "$status_code" = "403" ]; then
                           echo -e "ⓘ ${VIOLET} GitHub${NC} ${YELLOW}API key${NC} = ${BLUE}$api_key${NC} ${RED}! 403 Forbidden${NC}"     
                           invalid_key_found=true  
                                if [ -n "$remove" ] && [ "$remove" -eq 1 ]; then
                                     remove_github_func
                                fi                                                                                  
                          elif [ -n "$output" ]; then   
                                     echo "$api_key" | anew -q "$output"
                           fi  
              done
              if ! $invalid_key_found; then
                  echo -e "ⓘ ${VIOLET} GitHub${NC} : ${GREEN}\u2713${NC}"  
              fi
              if [ -n "$output" ] ; then  
                    echo -e "\n" 
                    echo -e "${YELLOW}Output ${BLUE}Saved${NC} to ${BLUE}$output${NC}"
                    sort -u $output -o $output
                    echo -e "${YELLOW}Total ${PURPLE}Valid ${YELLOW}Tokens${NC}: ${GREEN}$(wc -l $output | awk '{print $1}')${NC}"     
              fi  
         fi
fi  
#EOF Github                             
unset output             


##GitLab  
if [ -n "$gitlab_tokens" ] && [ -e "$gitlab_tokens" ]; then
     if [ -z "$output" ]; then
     export output="$(pwd)/gitlab-valid.txt"
     fi
echo -e "${YELLOW}\n"
cat << "EOF"       
   _____ _ _   _           _     
  / ____(_) | | |         | |    
 | |  __ _| |_| |     __ _| |__  
 | | |_ | | __| |    / _` | '_ \ 
 | |__| | | |_| |___| (_| | |_) |
  \_____|_|\__|______\__,_|_.__/ 
EOF
echo -e "${NC}"     
      GitLab_api_keys=$(cat $gitlab_tokens | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//' | sed '/^$/d' | grep "^glpat")
      sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//' -i "$gitlab_tokens" ; sed '/^$/d' -i "$gitlab_tokens"
      sort -u "$gitlab_tokens" -o "$gitlab_tokens"
       invalid_key_found=false
          if [ -n "$GitLab_api_keys" ]; then
                  i=1
                  while read -r api_key; do
                  var_name="GitLab_api_key_$i"
                  eval "$var_name=\"$api_key\""
                  i=$((i+1))
                  done <<< "$GitLab_api_keys"
                     #curl
                    for ((j=1; ; j++)); do
                          var_name="GitLab_api_key_$j"
                          api_key=${!var_name}
                     if [ -z "$api_key" ]; then
                       break
                     fi
                          response=$(curl -qski "https://gitlab.com/api/v4/user" -H "PRIVATE-TOKEN: $api_key")
                          status_code=$(echo "$response" | awk '/HTTP/{print $2}')
                          is_bot=$(curl -qsk "https://gitlab.com/api/v4/user" -H "PRIVATE-TOKEN: $api_key" |jq  -r '.bot')
                          is_premium=$(curl -qsk "https://gitlab.com/api/v4/user" -H "PRIVATE-TOKEN: $api_key" | jq -r 'select(.shared_runners_minutes_limit != null) | "premium user"')
                          global_search=$(curl -qsk "https://gitlab.com/api/v4/search?scope=blobs&search=z&per_page=100" -H "PRIVATE-TOKEN: $api_key" | jq -r '.message')
                          remove_gitlab_func(){
                          sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//' -i "$gitlab_tokens" ; sed '/^$/d' -i "$gitlab_tokens" ; sed "/$api_key/d" -i "$gitlab_tokens"
                          }
                          #echo -e "\n"
                          #echo -e "${PURPLE}$api_key${NC}"
                          #echo -e "$(curl -qsk "https://gitlab.com/api/v4/user" -H "PRIVATE-TOKEN: $api_key" | jq)"
                          #echo -e "\n"
                          #echo -e "-----------------------"
                     if [ "$status_code" = "401" ] ; then
                       echo -e "ⓘ ${VIOLET} GitLab${NC} ${YELLOW}API key${NC} = ${BLUE}$api_key${NC} ${RED}\u2717 Invalid${NC}"
                             if [ -n "$remove" ] && [ "$remove" -eq 1 ]; then
                                remove_gitlab_func
                                 #sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//' -i "$gitlab_tokens" ; sed '/^$/d' -i "$gitlab_tokens" ; sed -i "/$api_key/d" "$gitlab_tokens" 
                             fi                         
                       invalid_key_found=true
                     elif [ "$status_code" = "403" ] ; then
                       echo -e "ⓘ ${VIOLET} GitLab${NC} ${YELLOW}API key${NC} = ${BLUE}$api_key${NC} ${RED}\U0001F480 BLOCKED${NC}"
                             if [ -n "$remove" ] && [ "$remove" -eq 1 ]; then
                             remove_gitlab_func
                                 #sed -Ei 's/^[[:space:]]+//; s/[[:space:]]+$//' -i "$gitlab_tokens" ; sed '/^$/d' -i "$gitlab_tokens" ; sed "/$api_key/d" -i "$gitlab_tokens" 
                             fi     
                       invalid_key_found=true      
                     elif echo "$is_bot" | grep -q "true"; then
                       echo -e "ⓘ ${VIOLET} GitLab${NC} ${YELLOW}API key${NC} = ${BLUE}$api_key${NC} ${PINK}\U0001F916 BOT${NC}"
                             if [ -n "$output" ]; then   
                                echo "$api_key" | anew -q "$output"
                             fi 
                       #invalid_key_found=true
                     elif echo "$is_premium" | grep -q "premium user"; then 
                          echo -e "ⓘ ${VIOLET} GitLab${NC} ${YELLOW}API key${NC} = ${BLUE}$api_key${NC} [${PURPLE}Premium User${NC}]"  
                             if [ -n "$output" ]; then   
                                echo "$api_key" | anew -q "$output"
                             fi  
                     elif ! echo "$global_search" | grep -q "disabled"; then      
                          echo -e "ⓘ ${VIOLET} GitLab${NC} ${YELLOW}API key${NC} = ${BLUE}$api_key${NC} [${PURPLE}Global Search${NC} ${GREEN}Enabled!${NC}]"  
                             if [ -n "$output" ]; then   
                                echo "$api_key" | anew -q "$output"
                             fi 
                     elif [ -n "$output" ] ; then   
                           echo "$api_key" | anew -q "$output"
                     fi                   
              done
              if ! $invalid_key_found; then
                  echo -e "ⓘ ${VIOLET} GitLab${NC} : ${GREEN}\u2713${NC}"  
              fi 
              if [ -n "$output" ] ; then  
                    echo -e "\n" 
                    echo -e "${YELLOW}Output ${BLUE}Saved${NC} to ${BLUE}$output${NC}"
                    sort -u $output -o $output
                    echo -e "${YELLOW}Total ${PURPLE}Valid ${YELLOW}Tokens${NC}: ${GREEN}$(wc -l $output | awk '{print $1}')${NC}"     
              fi     
         fi 
fi
#EOF Gitlab
unset output       
unset github_tokens
unset gitlab_tokens    
#EOF