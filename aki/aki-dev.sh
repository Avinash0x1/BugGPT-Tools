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
echo -e "${PURPLE}"
cat << "EOF"       
 _  |  o 
(_| |< |  : Api Key | Tokens validator 
EOF
echo -e "${NC}"
 
#Defaults
proxy=
quota=
# Parse command line arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -a|--amass)
        amass_config="$2"
        shift 
        shift 
        ;;
        -s|--subfinder)
        subfinder_config="$2"
        shift 
        shift 
        ;;
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
        -p|--proxy)
        proxy=1
        shift
        ;;         
        -q|--quota)
        quota=1
        shift
        ;;        
        *)    
        echo -e "${RED}Error: Invalid option ${YELLOW}'$key'${NC} , try ${BLUE}--help${NC} for Usage"
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

#Defaults
amass_config_def="$HOME/.config/amass/config.ini"
subfinder_config_def="$HOME/.config/subfinder/provider-config.yaml"


proxy_mubeng(){
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
kill_mubeng(){
  wait
  kill $bg_pid
}
#if no input passed to -a or --amass 
if [ -z "$amass_config" ]; then
        # Check if default amass config file exists
       if [[ -f $amass_config_def ]]; then
            echo -e "${GREEN}ⓘ Using default ${BLUE}amass config file${NC}: ${PURPLE}$amass_config_def${NC}\n"
            export amass_config=$amass_config_def
       else
           echo -e "${RED}\u2717 Couldn't find${NC} the default${NC} ${PURPLE}amass config file${NC}: ${RED}$amass_config_def${NC}"
           echo -e "${YELLOW}specify it manually using${NC} ${BLUE}-a${NC} | ${BLUE}--amass${NC}\n"
           #Nor was an input passed to -s or --subfinder
            if [[ -z $subfinder_config ]]; then
                   # Check if default subfinder config file exists
                    subfinder_config_def="$HOME/.config/subfinder/provider-config.yaml"            
                if [[ -f $subfinder_config_def ]]; then
                   echo -e "${GREEN}ⓘ Using default ${BLUE}subfinder config file${NC}: ${PURPLE}$subfinder_config_def${NC}\n"
                   export subfinder_config=$subfinder_config_def
                 else
                    echo -e "${RED}\u2717 Couldn't find${NC} the default${NC} ${PURPLE}subfinder config file${NC}: ${RED}$subfinder_config_def${NC}"
                    echo -e "${YELLOW}specify it manually using${NC} ${BLUE}-s${NC} | ${BLUE}--subfinder${NC}\n"
                    echo -e "${RED}\u2717 Fatal${NC}: Neither one of${PURPLE} amass${NC} | ${PURPLE}subfinder${NC}  ${BLUE}options was used${NC} nor a ${PURPLE}default config file${NC} [${GREEN}amass${NC}: ${PURPLE}$amass_config_def${NC} ${RED}Not Found${NC}] [${GREEN}subfinder${NC}: ${PURPLE}$subfinder_config_def${NC} ${RED}Not Found${NC}]\n"
                exit 1
                fi
            fi
        fi  
else
    echo -e "${GREEN}ⓘ Using Specified ${BLUE}amass config file${NC}: ${PURPLE}$amass_config${NC}\n"  
         if [ ! -f  $amass_config ]; then 
            echo -e "${RED}\u2717 Fatal${NC}: [ ${BLUE}amass config file${NC}: ${PURPLE}$amass_config${NC} ${RED}Not Found${NC} ]"
              if  [ -f  $amass_config_def ]; then  
                 echo -e "${GREEN}ⓘ Using default ${BLUE}amass config file${NC}: ${PURPLE}$amass_config_def${NC}\n"            
                 export amass_config=$amass_config_def
              else
                 echo -e "${RED}\u2717 Fatal${NC}: [ ${BLUE}Default${NC}: ${PURPLE}$amass_config_def${NC} ${RED}also Not Found${NC} ]\n"              
              fi        
         fi       
fi


#if no input passed to -s or --subfinder, and it didn't get exported above
if [ -z "$subfinder_config" ]; then
        # Check if default subfinder config file exists
         if [[ -f $subfinder_config_def ]]; then
            echo -e "${GREEN}ⓘ Using default ${BLUE}subfinder config file${NC}: ${PURPLE}$subfinder_config_def${NC}\n"
             export subfinder_config=$subfinder_config_def
         else
           echo -e "${RED}\u2717 Couldn't find${NC} the default${NC} ${PURPLE}subfinder config file${NC}: ${RED}$subfinder_config_def${NC}"
           echo -e "${YELLOW}specify it manually using${NC} ${BLUE}-s${NC} | ${BLUE}--subfinder${NC}\n"
            #check if amass config is at least exported
                if [ -z "$amass_config" ]; then
                # Check if default amass config file exists
                   if [[ -f $amass_config_def ]]; then
                    echo -e "${GREEN}ⓘ Using default ${BLUE}amass config file${NC}: ${PURPLE}$amass_config_def${NC}\n"
                    export amass_config=$amass_config_def
                 else
                    echo -e "${RED}\u2717 Couldn't find${NC} the default${PURPLE} amass config file${NC}: ${RED}$amass_config_def${NC}"
                    echo -e "${YELLOW}specify it manually using${NC} ${BLUE}-a${NC} | ${BLUE}--amass${NC}\n"
                    echo -e "${RED}\u2717 Fatal${NC}: Neither one of${PURPLE} amass${NC} | ${PURPLE}subfinder${NC}  ${BLUE}options was used${NC} nor a ${PURPLE}default config file${NC} [${GREEN}amass${NC}: ${PURPLE}$amass_config_def${NC} ${RED}Not Found${NC}] [${GREEN}subfinder${NC}: ${PURPLE}$subfinder_config_def${NC} ${RED}Not Found${NC}]\n"
                exit 1
                fi
            fi
        fi     
else
    echo -e "${GREEN}ⓘ Using Specified ${BLUE}subfinder config file${NC}: ${PURPLE}$subfinder_config${NC}\n"  
         if [ ! -f  $subfinder_config ]; then 
            echo -e "${RED}\u2717 Fatal${NC}: [ ${BLUE}subfinder config file${NC}: ${PURPLE}$subfinder_config${NC} ${RED}Not Found${NC} ]"
              if  [ -f  $subfinder_config_def ]; then  
                 echo -e "${GREEN}ⓘ Using default ${BLUE}subfinder config file${NC}: ${PURPLE}$subfinder_config_def${NC}\n"            
                 export subfinder_config=$subfinder_config_def
              else
                 echo -e "${RED}\u2717 Fatal${NC}: [ ${BLUE}Default${NC}: ${PURPLE}$subfinder_config_def${NC} ${RED}also Not Found${NC} ]\n"              
              fi        
         fi       
fi

#Git
if [ -z "$github_tokens" ]; then
  github_tokens="$HOME/.config/.github_tokens"
  echo -e "${GREEN}ⓘ Using default ${BLUE}github_tokens file${NC}: ${PURPLE}$github_tokens${NC}\n"
fi
if [ -z "$gitlab_tokens" ]; then
  gitlab_tokens="$HOME/.config/.gitlab_tokens"
  echo -e "${GREEN}ⓘ Using default ${BLUE}gitlab_tokens file${NC}: ${PURPLE}$gitlab_tokens${NC}\n"
fi


#Re Check
#amass
if [ -n "$amass_config" ] && [ -e "$amass_config" ]; then
  echo -e "${YELLOW}Check ${GREEN}amass${NC} ${YELLOW}?${NC} : ${BLUE}Yes $(echo -e "${GREEN}\u2713${NC}")${NC}"
else
  echo -e "${YELLOW}Check ${GREEN}amass${NC} ${YELLOW}?${NC} : ${RED}No $(echo -e "${RED}\u2717${NC}")${NC}"
fi
#subfinder
if [ -n "$subfinder_config" ] && [ -e "$subfinder_config" ]; then
  echo -e "${YELLOW}Check ${GREEN}Subfinder${NC} ${YELLOW}?${NC} : ${BLUE}Yes $(echo -e "${GREEN}\u2713${NC}")${NC}"
else
  echo -e "${YELLOW}Check ${GREEN}Subfinder${NC} ${YELLOW}?${NC} : ${RED}No $(echo -e "${RED}\u2717${NC}")${NC}"
fi
#Github Tokens
if [ -n "$github_tokens" ] && [ -e "$github_tokens" ]; then
  echo -e "${YELLOW}Check ${GREEN}Github Tokens${NC} ${YELLOW}?${NC} : ${BLUE}Yes $(echo -e "${GREEN}\u2713${NC}")${NC}"
else
  echo -e "${YELLOW}Check ${GREEN}Github Tokens${NC} ${YELLOW}?${NC} : ${RED}No $(echo -e "${RED}\u2717${NC}")${NC}"
fi
#Gitlab Tokens
if [ -n "$gitlab_tokens" ] && [ -e "$gitlab_tokens" ]; then
  echo -e "${YELLOW}Check ${GREEN}Gitlab Tokens${NC} ${YELLOW}?${NC} : ${BLUE}Yes $(echo -e "${GREEN}\u2713${NC}")${NC}"
else
  echo -e "${YELLOW}Check ${GREEN}Gitlab Tokens${NC} ${YELLOW}?${NC} : ${RED}No $(echo -e "${RED}\u2717${NC}")${NC}"
fi
#whether to use proxy     
if [ -z "$proxy" ]; then
   echo -e "${YELLOW}Use ${BLUE}Proxy${YELLOW} ?${NC} : ${RED}No $(echo -e "${RED}\u2717${NC}")${NC}"
else
   echo -e "${YELLOW}Use ${BLUE}Proxy${YELLOW} ?${NC} : ${BLUE}Yes $(echo -e "${GREEN}\u2713${NC}")${NC}"     
fi 
#whether to show usage quotas     
if [ -z "$quota" ]; then
   echo -e "${YELLOW}Show ${BLUE}Quota Usage${YELLOW} ?${NC} : ${RED}No $(echo -e "${RED}\u2717${NC}")${NC}"
else
   echo -e "${YELLOW}Show ${BLUE}Quota Usage${YELLOW} ?${NC} : ${BLUE}Yes $(echo -e "${GREEN}\u2713${NC}")${NC}"     
fi 
echo -e "\n"
echo -e "${YELLOW}ⓘ Some API Checks will take${RED} longer${NC} to avoid ${GREEN}rate limits${NC} (Shodan, etc)\n ${BLUE}Please have ${GREEN}Patience${NC}\n"


#amass parser
if [ -n "$amass_config" ]; then
    amass_config_parsed=$(mktemp)
    #Parse using regex
    sed -n '/^\[/,$p' $amass_config | sed '/^$/d' | grep -E '^(apikey|\[|secret|username|password)' > $amass_config_parsed
    echo -e "${RED}"
    cat << "EOF"       
            .+++:.            :                             .+++.
      +W@@@@@@8        &+W@#               o8W8:      +W@@@@@@#.   oW@@@W#+
     &@#+   .o@##.    .@@@o@W.o@@o       :@@#&W8o    .@#:  .:oW+  .@#+++&#&
    +@&        &@&     #@8 +@W@&8@+     :@W.   +@8   +@:          .@8
    8@          @@     8@o  8@8  WW    .@W      W@+  .@W.          o@#:
    WW          &@o    &@:  o@+  o@+   #@.      8@o   +W@#+.        +W@8:
    #@          :@W    &@+  &@+   @8  :@o       o@o     oW@@W+        oW@8
    o@+          @@&   &@+  &@+   #@  &@.      .W@W       .+#@&         o@W.
     WW         +@W@8. &@+  :&    o@+ #@      :@W&@&         &@:  ..     :@o
     :@W:      o@# +Wo &@+        :W: +@W&o++o@W. &@&  8@#o+&@W.  #@:    o@+
      :W@@WWWW@@8       +              :&W@@@@&    &W  .o#@@W&.   :W@WWW@@&
        +o&&&&+.                                                    +oooo.
EOF
echo -e "${NC}"  
fi



#subfinder parser
if [ -n "$subfinder_config" ]; then
    subfinder_config_parsed=$(mktemp)
        #Parse using yq
        if ! yq e .$subfinder_config > /dev/null 2>&1; then
              echo -e "${RED}✘ Error${NC}: ${BLUE}$subfinder_config${NC} is not a valid ${YELLOW}YAML${NC}"
              echo -e "Please ${YELLOW}double check${NC} your ${BLUE}$subfinder_config${NC}"
              echo -e "${YELLOW}Validate${NC} using : ${BLUE}https://www.yamllint.com/${NC}"              
              exit 1
        else
           cat $subfinder_config | yq > $subfinder_config_parsed   
         fi
echo -e "${PINK}\n"
cat << "EOF"         
                     __    _____           __         
   _______  __/ /_  / __(_)___  ____/ /__  _____
  / ___/ / / / __ \/ /_/ / __ \/ __  / _ \/ ___/
 (__  ) /_/ / /_/ / __/ / / / / /_/ /  __/ /    
/____/\__,_/_.___/_/ /_/_/ /_/\__,_/\___/_/   
EOF
echo -e "${NC}"
     #censys  
     censys_Creds=$(yq eval '.censys[]' $subfinder_config_parsed)
     invalid_key_found=false
     if [ -n "$censys_Creds" ]; then
            for api_key in $censys_Creds
            do
                export encoded_key=$(printf $api_key | tr -d '[:space:]' | base64 | tr -d '[:space:]')
                          response=$(curl -qski "https://search.censys.io/api/v1/account" -H "accept: application/json" -H "Authorization: Basic $encoded_key")
                          status_code=$(echo "$response" | awk '/HTTP/{print $2}')
                     if [ "$status_code" = "401" ] || [ "$status_code" = "403" ]; then
                       echo -e "ⓘ ${VIOLET} Censys${NC} ${YELLOW}API key : Secret${NC} = ${BLUE}$(echo -n "$encoded_key" | base64 -d)${NC} ${RED}\u2717 Invalid${NC}"
                       invalid_key_found=true
                     elif [[ "$status_code" = "200" && -n "$quota" ]]; then
                           echo -e "ⓘ ${VIOLET} Censys${NC}"
                           export CENSYS_USERNAME=$(curl -qsk "https://search.censys.io/api/v1/account" -H "Authorization: Basic $encoded_key" -H "Accept: application/json" | jq -r '.login')                           
                           export CENSYS_AUTH="$encoded_key" 
                           echo -e "${YELLOW}API key${NC} : ${PURPLE}$api_key${NC}"                            
                           python3 $HOME/Tools/AKI/Deps/APIKEYBEAST-forked.py -s censys      
                           echo -e "\n"    
                     fi
            done
         if ! $invalid_key_found; then
            echo -e "ⓘ ${VIOLET} censys${NC} : ${GREEN}\u2713${NC}"  
         fi  
      fi 
fi


##Github -gh
if [ -n "$github_tokens" ] && [ -e "$github_tokens" ]; then
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
        GitHub_api_keys=$(cat $github_tokens)
        invalid_key_found=false
          if [ -n "$GitHub_api_keys" ]; then
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
                      if [ -n "$proxy" ] && [ "$proxy" -eq 1 ]; then
                          proxy_mubeng
                          while true; do
                             proxy_response=$(curl -x http://localhost:9997 -qski "https://api.github.com/user" -H "Authorization: Bearer $api_key" -H "Accept: application/vnd.github+json")
                             echo $proxy_response
                            if ! echo "$proxy_response" | grep -q "Proxy Server error"; then
                                response=$(echo "proxy_response" | sed '1d')
                               echo  $response
                            fi
                          done  
                          #response=$(curl -x http://localhost:9997 -qski "https://api.github.com/user" -H "Authorization: Bearer $api_key" -H "Accept: application/vnd.github+json")
                          if echo "$response" | grep -q "Bad credentials"; then   
                           echo -e "ⓘ ${VIOLET} GitHub${NC} ${YELLOW}API key${NC} = ${BLUE}$api_key${NC} ${RED}\u2717 Invalid${NC}"
                           invalid_key_found=true                           
                          elif [ "$status_code" = "403" ]; then
                           echo -e "ⓘ ${VIOLET} GitHub${NC} ${YELLOW}API key${NC} = ${BLUE}$api_key${NC} ${RED}! 403 Forbidden${NC}"     
                           invalid_key_found=true                                                          
                          fi
                      else
                          response=$(curl -qski  "https://api.github.com/user" -H "Authorization: Bearer $api_key" -H "Accept: application/vnd.github+json"  && sleep 30s)
                          if echo "$response" | grep -q "Bad credentials"; then   
                           echo -e "ⓘ ${VIOLET} GitHub${NC} ${YELLOW}API key${NC} = ${BLUE}$api_key${NC} ${RED}\u2717 Invalid${NC}"
                           invalid_key_found=true                           
                          elif [ "$status_code" = "403" ]; then
                           echo -e "ⓘ ${VIOLET} GitHub${NC} ${YELLOW}API key${NC} = ${BLUE}$api_key${NC} ${RED}! 403 Forbidden${NC}"     
                           invalid_key_found=true                                                          
                          fi
                      fi    
              done
              if [ -n "$proxy" ] && [ "$proxy" -eq 1 ]; then
               kill_mubeng
              fi
              if ! $invalid_key_found; then
                  echo -e "ⓘ ${VIOLET} GitHub${NC} : ${GREEN}\u2713${NC}"  
              fi  
         fi     
fi                               



##GitLab  
if [ -n "$gitlab_tokens" ] && [ -e "$gitlab_tokens" ]; then
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
      GitLab_api_keys=$(cat $gitlab_tokens)
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
                          response=$(curl -qski "https://gitlab.com/api/v4/projects" -H "PRIVATE-TOKEN: $api_key")
                          status_code=$(echo "$response" | awk '/HTTP/{print $2}')
                     if [ "$status_code" = "401" ] ; then
                       echo -e "ⓘ ${VIOLET} GitLab${NC} ${YELLOW}API key${NC} = ${BLUE}$api_key${NC} ${RED}\u2717 Invalid${NC}"
                       invalid_key_found=true
                     elif [ "$status_code" = "403" ] ; then
                       echo -e "ⓘ ${VIOLET} GitLab${NC} ${YELLOW}API key${NC} = ${BLUE}$api_key${NC} ${RED}\U0001F480 BLOCKED${NC}"
                       invalid_key_found=true      
                     fi                   
              done
              if ! $invalid_key_found; then
                  echo -e "ⓘ ${VIOLET} GitLab${NC} : ${GREEN}\u2713${NC}"  
              fi  
         fi   
fi
 