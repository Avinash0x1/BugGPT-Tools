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
   #ZoomEye  
     ZoomEye_api_keys=$(awk '/data_sources.ZoomEye.Credentials/{flag=1;next} /^\[/{flag=0} flag && /username/{user=$3} flag && /password/{print user":"$3}' $amass_config_parsed)
     invalid_key_found=false
     if [ -n "$ZoomEye_api_keys" ]; then
              i=1
              while read -r api_key; do
              varname="ZoomEye_cred_$i"
              eval "$varname=\"$api_key\""
               i=$((i+1))
             done <<< "$ZoomEye_api_keys"
            # curl
             for ((j=1; ; j++)); do
               var_name="ZoomEye_cred_$j"
               api_key=${!var_name}
               if [ -z "$api_key" ]; then
                break
                fi
              response=$(curl -qski "https://api.zoomeye.org/user/login" -H "Accept: application/json" -H "Content-Type: application/json" -d "{\"username\":\"${api_key%:*}\", \"password\":\"${api_key#*:}\"}")
              status_code=$(echo "$response" | awk '/HTTP/{print $2}')
              if [ "$status_code" = "423" ] || [ "$status_code" = "401" ] || [ "$status_code" = "403" ]; then
                  echo -e "ⓘ ${VIOLET} ZoomEye${NC} ${YELLOW}Username:Password${NC} = ${BLUE}${api_key}${NC} ${RED}\u2717 Invalid${NC}"
                  invalid_key_found=true
              elif [[ "$status_code" = "200" && -n "$quota" ]]; then
                          echo -e "ⓘ ${VIOLET} ZoomEye${NC}"
                           export ZOOMEYE_USERNAME="${api_key%:*}"
                           export ZOOMEYE_PASSWORD="${api_key#*:}" 
                           echo -e "${YELLOW}API key${NC} : ${PURPLE}$api_key${NC}"                            
                           python3 /media/sf_Parrot-Nexus/Github/Public/BugGPT-Tools/aki/APIKEYBEAST-forked.py -s zoomeye   
                           echo -e "\n"                           
               fi
            done
         if ! $invalid_key_found; then
            echo -e "ⓘ ${VIOLET} ZoomEye${NC} : ${GREEN}\u2713${NC}"  
         fi  
      fi
   #IntelX          
    IntelX_api_keys=$(awk '/data_sources.IntelX.Credentials/{flag=1;next} /^\[/{flag=0} flag && /apikey/{print $3}' $amass_config_parsed)
    invalid_key_found=false
          if [ -n "$IntelX_api_keys" ]; then
              echo -e "ⓘ ${VIOLET} IntelX${NC} has ${YELLOW}Rate Limits${NC} so have ${GREEN}Patience${NC}"                   
                  i=1
                  while read -r api_key; do
                  var_name="IntelX_api_key_$i"
                  eval "$var_name=\"$api_key\""
                  i=$((i+1))
                  done <<< "$IntelX_api_keys"
                     #curl
                    for ((j=1; ; j++)); do
                          var_name="IntelX_api_key_$j"
                          api_key=${!var_name}
                     if [ -z "$api_key" ]; then
                       break
                     fi
                          response=$(curl -qski "https://2.intelx.io/authenticate/info" -H "x-key:$api_key" -H "Accept: application/json" && sleep 62s)
                          status_code=$(echo "$response" | awk '/HTTP/{print $2}')
                     if [ "$status_code" = "401" ] ; then
                       echo -e "ⓘ ${VIOLET} IntelX${NC} ${YELLOW}API key${NC} = ${BLUE}$api_key${NC} ${RED}\u2717 Invalid${NC}"
                       invalid_key_found=true
                     elif [ "$status_code" = "403" ] ; then
                       echo -e "ⓘ ${VIOLET} IntelX${NC} ${YELLOW}API key${NC} = ${BLUE}$api_key${NC} ${RED}\u2717 Rate Limited${NC}"                      
                     elif [[ "$status_code" = "200" && -n "$quota" ]]; then
                          echo -e "ⓘ ${VIOLET} IntelX${NC}"
                           export INTELX_API_KEY="$api_key" 
                           echo -e "${YELLOW}API key${NC} : ${PURPLE}$api_key${NC}"                            
                           python3 /media/sf_Parrot-Nexus/Github/Public/BugGPT-Tools/aki/APIKEYBEAST-forked.py -s intelx   
                           sleep 62s   
                           echo -e "\n"                           
                     fi
              done
              if ! $invalid_key_found; then
                  echo -e "ⓘ ${VIOLET} IntelX${NC} : ${GREEN}\u2713${NC}"  
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
echo -e "\n"
echo -e "${YELLOW}ⓘ Some API Checks will take${RED} longer${NC} to avoid ${GREEN}rate limits${NC} (Shodan, etc)\n ${BLUE}Please have ${GREEN}Patience${NC}\n"




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
                          response=$(curl -qski  "https://api.github.com/repos/Azathothas/BugGPT-Tools/stats/code_frequency" -H "Authorization: Bearer $api_key" -H "Accept: application/vnd.github+json"  && sleep 20s)
                          if echo "$response" | grep -q "Bad credentials"; then   
                           echo -e "ⓘ ${VIOLET} GitHub${NC} ${YELLOW}API key${NC} = ${BLUE}$api_key${NC} ${RED}\u2717 Invalid${NC}"
                           invalid_key_found=true                           
                          elif [ "$status_code" = "403" ]; then
                           echo -e "ⓘ ${VIOLET} GitHub${NC} ${YELLOW}API key${NC} = ${BLUE}$api_key${NC} ${RED}! 403 Forbidden${NC}"     
                           invalid_key_found=true                                                          
                          fi
              done
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
 