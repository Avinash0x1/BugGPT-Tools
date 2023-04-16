#!/usr/bin/bash

#A bit of Styling
RED='\033[31m'
GREEN='\033[32m'
GREY='\033[37m'
BLUE='\033[34m'
YELLOW='\033[33m'
PURPLE='\033[35m'
RESET='\033[0m'
NC='\033[0m'
#Banner
echo -e "${PURPLE}"
cat << "EOF"
       ╭╮
╭┳┳┳━┳━┫╰┳┳╮
┃>W┃e┫e┫b┃u┃
╰━━┻━┻━┻━┻━╯
EOF
echo -e "${NC}"
#Initialization, Only on a fresh install
if [[ "$*" == *"-init"* ]] || [[ "$*" == *"--init"* ]] || [[ "$*" == *"init"* ]] ; then
  echo -e "➼ ${GREEN}Initializing weebu...${NC}"
  echo -e "➼ Please ${YELLOW}exit (ctrl + c)${NC} if you already did this" 
  echo "➼ Setting up...$(rm -rf /tmp/example.com 2>/dev/null)"
  weebu -u https://example5.com -o /tmp/example.com --linky --wildcard-scope 
  rm -rf /tmp/example.com 2>/dev/null
  echo ""
  echo -e "${GREEN}Initialized Successfully${NC}"
  exit 0
fi
#Help / Usage
if [[ "$*" == *"-help"* ]] || [[ "$*" == *"--help"* ]] || [[ "$*" == *"help"* ]] ; then
  echo -e "${YELLOW}➼ Usage${NC}: ${PURPLE}weebu${NC} ${BLUE}-u${NC} <url or ${BLUE}(-d${NC} <domain>)> ${BLUE}-o${NC} /path/to/outputdir <other-options, see ${BLUE}--help${NC}>"
  echo ""
  echo -e "${YELLOW}Extended Help${NC}"
  echo -e "${BLUE}-u${NC},       ${BLUE}--url${NC}              Specify the URL (${YELLOW}Required${NC} else specify domain (${BLUE}--domain${NC}))"
  echo -e "${BLUE}-d${NC},       ${BLUE}--domain${NC}           Specify the ${BLUE}domain/subdomain${NC} (without ${YELLOW}http|https${NC})"
  echo -e "${BLUE}-o${NC},       ${BLUE}--output${NC}           Specify the ${BLUE}directory${NC} to save the output files (${YELLOW}Required${NC})"
  echo -e "${BLUE}-tu${NC},      ${BLUE}--tcp-udp${NC}          Use ${YELLOW}nmap (${RED}TCP${NC} + ${RED}UDP${NC}) ${YELLOW}super slow${NC}"
  echo -e "${BLUE}-linky${NC},   ${BLUE}--linky${NC}            ${YELLOW}Runs ${GREEN}linky${NC} (${BLUE}https://github.com/Azathothas/BugGPT-Tools/tree/main/linky${NC})"
  echo -e "${BLUE}-wl${NC},      ${BLUE}--wildcard-scope${NC}   Use ${YELLOW}wildcard (${RED}.*${NC}) ${YELLOW}scope${NC} to not miss anything"
  echo -e "${BLUE}-h${NC},       ${BLUE}--headers${NC}          Specify additional ${BLUE}headers${NC} or ${BLUE}cookies${NC} (use ${YELLOW}\"\"${NC}, optional)"
  echo -e "${BLUE}-up,      ${BLUE}--update${NC}           ${GREEN}Update ${PURPLE}weebu${NC}\n"
  echo -e "(${YELLOW}Not Required if ${RED}not running ${GREEN}--linky${NC})\n or if ${BLUE}$HOME/.config/.github_tokens ${GREEN}exists${NC}"
  echo -e "${BLUE}-gh${NC},      ${BLUE}--github_token${NC}     Specify manually: ${RED}ghp_xxx${NC}\n"
  echo -e "(${YELLOW}Only run on a fresh Install${NC})"
  echo -e "${BLUE}-init${NC},    ${BLUE}--init${NC}             ${GREEN}Initialize${NC} ➼ ${PURPLE}weebu${NC} by dry-running it against example.com\n"
  echo -e "${YELLOW}Example Usage${NC}: "
  echo -e "${BLUE}Basic${NC}: "
  echo -e "${PURPLE}weebu${NC} ${BLUE}--url${NC} ${YELLOW}https://example.com${NC} ${BLUE}--output${NC} ${YELLOW}/path/to/outputdir${NC} ${GREEN}--linky${NC} ${BLUE}--wildcard-scope${NC}\n"
  echo -e "${RED}Extensive${NC}: "
  echo -e "${PURPLE}weebu ${BLUE}--url${NC} ${YELLOW}https://example.com${NC} ${BLUE}--output${NC} ${YELLOW}/path/to/outputdir${NC} ${BLUE}--github_token${NC} ${YELLOW}ghp_xyz${NC} ${BLUE}--headers${NC} ${YELLOW}\"Authorization: Bearer token; Cookie: cookie_value\"${NC} ${GREEN}--linky${NC} ${BLUE}--wildcard-scope${NC} ${RED}--tcp_udp${NC}\n"
  echo -e "${GREEN}Tips${NC}: "
  if [ ! -f "$HOME/.config/amass/config.ini" ]; then
    echo -e "Your ${YELLOW}$HOME/.config/amass/config.ini${NC} ${RED}does not exist${NC}. You must create one:${BLUE}https://github.com/owasp-amass/amass/blob/master/examples/config.ini${NC}"
  else
    echo -e "➼ Specify ${YELLOW}VirusTotal${NC} , ${YELLOW}PassiveTotal${NC} & ${YELLOW}Shodan${NC} ${GREEN}API KEYS${NC} in ${BLUE}$HOME/.config/amass/config.ini${NC} if you haven't already!"
    echo -e "➼ Include ${BLUE}IP2WHOIS_API_KEY${NC} in ${BLUE}$HOME/.env.wtfis${NC} to find more info"
  fi  
  echo -e "➼ Include multiple ${GREEN}github_tokens${NC} in ${BLUE}$HOME/.config/.github_tokens${NC} to avoid ${RED}rate limits${NC}" 
  echo -e "➼ ${YELLOW}Don't Worry${NC} if your ${RED}Terminal Hangs${NC} for a bit.. It's a feature not a bug\n"
  exit 0
fi

# Update. Github caches take several minutes to reflect globally  
if [[ $# -gt 0 && ( "$*" == *"up"* || "$*" == *"-up"* || "$*" == *"update"* || "$*" == *"--update"* ) ]]; then
  echo -e "➼ ${YELLOW}Checking For ${BLUE}Updates${NC}"
  REMOTE_FILE=$(mktemp)
  curl -s -H "Cache-Control: no-cache" https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/weebu/weebu.sh -o "$REMOTE_FILE"
  if ! diff --brief /usr/local/bin/weebu "$REMOTE_FILE" >/dev/null 2>&1; then
    echo -e "➼ ${YELLOW}NEW!! Update Found! ${BLUE}Updating ..${NC}" 
    dos2unix $REMOTE_FILE > /dev/null 2>&1 
    sudo mv "$REMOTE_FILE" /usr/local/bin/weebu && echo -e "➼ ${GREEN}Updated${NC} to ${BLUE}@latest${NC}" 
    sudo chmod +xwr /usr/local/bin/weebu
    rm -f "$REMOTE_FILE" 2>/dev/null
  else
    echo -e "➼ ${YELLOW}Already UptoDate${NC}"
    rm -f "$REMOTE_FILE" 2>/dev/null
    exit 0
  fi
  exit 0
fi

# Parse command line options
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    -u|--url)
    if [ -z "$2" ]; then
      echo -e "${RED}Error: ${YELLOW}URL is missing${NC} for option ${BLUE}'-u | --url'${NC}"
      exit 1
    fi
    url="$2"
    shift 
    shift 
    ;;
    -d|--domain)
    if [ -z "$2" ]; then
      echo -e "${RED}Error: ${YELLOW}Domain is missing${NC} for option ${BLUE}'-d | --domain'${NC}"
      echo -e "${YELLOW}}Make sure not to include (${RED}http${NC}|${RED}https${NC})"
      exit 1
    fi
    url_domain="$2"
    shift 
    shift 
    ;;    
    -o|--output)
    if [ -z "$2" ]; then
      echo -e "${RED}Error: ${YELLOW}Output Directory${NC} is missing for option ${BLUE}'-o | --output_dir'${NC}"
      exit 1
    fi
    outputDir="$2"
    shift 
    shift 
    if [ -d "$outputDir" ]; then
        find $outputDir -type f -size 0 -delete 
        if [ -z "$(ls -A $outputDir)" ]; then
        rm -r $outputDir
        fi
    fi
    # Check if directory already exists
    if [ -d "$outputDir" ]; then
      echo -e "${RED}Directory ${YELLOW}$outputDir${NC} already exists. Supply another for ${BLUE}'-o | --output_dir'${NC}"
      exit 1
    fi
    # Create directory
    mkdir -p "$outputDir/tmp/"
    echo -e "${YELLOW}INFO: ➼ ${BLUE}$outputDir${NC} created successfully"
    ;;
    -gh|--github_token)
    if [ -z "$2" ]; then
      echo -e "${RED}Error: ${YELLOW}Github Tokens${NC} not specified for option ${BLUE}'-gh | --github_token'${NC}"
      exit 1
    fi
    githubToken="$2"
    shift 
    shift 
    ;;
    -h|--headers)
    if [ -z "$2" ]; then
      echo -e "${RED}Error: Header / Cookie Values${NC} missing for option ${BLUE}'-h | --headers'${NC}"
      echo -e "To display help, use ${BLUE}'help | -help | --help'${NC}"
      exit 1
    fi
    optionalHeaders="$2"
    shift 
    shift 
    ;;
    -linky|--linky) 
     run_linky=1
     shift
    ;;  
    -wl|--wildcard-scope) 
     wildcard_scope=1
     shift
    ;;  
    -tu|--tcp-udp)
     tcp_udp=1
     shift
    ;;   
    *) 
    echo -e "${RED}Error: Invalid option '$key' , try --help for Usage$(rm -rf $outputDir 2>/dev/null)"
    exit 1
    ;;
  esac
done

#Setup Vars & default values
#Check URL, else httpx from domain
if [ -n "$url_domain" ]; then
    turl=$(echo "$url_domain" | httpx -silent)
    export url=$turl
    export URL=$turl
elif [ -n "$url" ]; then
    export URL=$url
fi

#Check domain, else subxtract from url
if [ -z "$url_domain" ]; then
    url_domain=$(echo "$url" | unfurl domains)
fi
if [ -n "$url_domain" ]; then
    #sdomain=$(echo "$url_domain" | subxtract -s | sed '/^$/d' | sed '/public[s ]*suffix[s ]*list[s ]*updated/Id')
    sdomain=$(echo "$url_domain" | unfurl domains )
    export url_domain=$sdomain
fi
#check health
timeout 20 echo "$url_domain" | httpx -silent -ports 20,21,22,25,53,80,110,137,139,143,161,443,445,465,587,902,993,995,1433,2379,3000,3306,3389,4004,4194,4443,5432,5900,6443,6666,6782,6783,6784,6969,8000,8008,8080,8081,8088,8888,8443,9000,9001,9002,9090,9099,10000,10250,10255,10256,10443,30876,44134,50000,50001,60000 | grep -q '.'
if [ $? -ne 0 ]; then
echo -e "${RED}✘ Error${NC}: Host ${BLUE}$url_domain${NC} is ${YELLOW}unreachable!${NC}"
echo -e "Please ${YELLOW}double check${NC} your ${BLUE}URL${NC} | ${BLUE}Domain${NC}"
exit 0
fi
#output
export outputDir=$outputDir
#Select Random token if !ghp
if [ -z "$githubToken" ]; then
  github_tokens="$HOME/.config/.github_tokens"
  if [ -s "$github_tokens" ]; then
    random_token=$(shuf -n 1 "$github_tokens")
    export githubToken=$random_token
  fi
fi
#Other
export optionalHeaders=$optionalHeaders
export linky=$run_linky
export deep=$deep
export wildcard=$wildcard_scope
export tcp_udp=$tcp_udp
originalDir=$(pwd)
#ip-addr
export ipv4_1=$(nslookup $url_domain 8.8.8.8 | grep 'Address' | sed '/^$/d' | awk '{print $2}' | grep -v '192\.' | grep '\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}' | awk '/^[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$/' > /tmp/ipvx.txt && cat /tmp/ipvx.txt | sed -n '1p')
export ipv4_2=$(cat /tmp/ipvx.txt | sed -n '2p')
export ipv6_1=$(nslookup $url_domain 8.8.8.8 | grep 'Address' | sed '/^$/d' | awk '{print $2}' | grep -E '^([0-9a-fA-F]{0,4}:){1,7}[0-9a-fA-F]{0,4}$' > /tmp/$ipv4_1-x.txt && cat /tmp/$ipv4_1-x.txt | sed -n '1p')
export ipv6_2=$(cat /tmp/$ipv4_1-x.txt | sed -n '2p')

#Recheck Values
echo -e "${YELLOW}url: ${BLUE}$url${NC}"
echo -e "${YELLOW}domain: ${BLUE}$url_domain${NC}"
echo -e "${YELLOW}ipv4: ${BLUE}$ipv4_1${NC} (${YELLOW}cdn${NC}: ${YELLOW}$(echo $ipv4_1|cdna)${NC}) | ${BLUE}$ipv4_2${NC} (${YELLOW}cdn${NC}: ${YELLOW}$(echo $ipv4_1|cdna)${NC})"
echo -e "${YELLOW}ipv6: ${BLUE}$ipv6_1${NC} | ${BLUE}$ipv6_2${NC}"
echo -e "${YELLOW}outputDir: ${BLUE}$outputDir${NC}"
echo -e "${YELLOW}githubToken: ${BLUE}$githubToken${NC}"
echo -e "${YELLOW}optionalHeaders: ${BLUE}$optionalHeaders${NC}"
#Linky
if [ -n "$linky" ] && [ "$linky" -eq 1 ]; then
  echo -e "${YELLOW}Run ${GREEN}linky${NC} ? : ${BLUE}Yes $(echo -e "${GREEN}\u2713${NC}")${NC}"
else
  echo -e "${YELLOW}Run ${GREEN}linky${NC} ? : ${RED}No $(echo -e "${RED}\u2717${NC}")${NC}"
fi
#nmap
if [ -n "$tcp_udp" ] && [ "$tcp_udp" -eq 1 ]; then
  echo -e "${YELLOW}nmap ${GREEN}TCP${NC} + ${RED}UDP${NC} ? : ${BLUE}Yes $(echo -e "${GREEN}\u2713${NC}")${NC}"
else
  echo -e "${YELLOW}nmap ${GREEN}TCP${NC} + ${RED}UDP${NC} ? : ${RED}No $(echo -e "${RED}\u2717${NC}")${NC}"
fi
#Scope
mkdir -p $outputDir/tmp
if [ -n "$wildcard" ] && [ "$wildcard" -eq 1 ]; then
  echo -e "${YELLOW}Use wildcard scope${NC} (${RED}.*${NC}) ? : ${BLUE}Yes $(echo -e "${GREEN}\u2713${NC}")${NC}"
  #Extract root domain name 
  wild_scope=$(echo "$url" | subxtract | sed '/^$/d' | sed '/public[s ]*suffix[s ]*list[s ]*updated/Id')
  url_scope=$(echo "$url_domain" | subxtract | sed '/^$/d' | sed '/public[s ]*suffix[s ]*list[s ]*updated/Id')
  echo -e "${BLUE}Scope is set as:${NC} "
  echo $wild_scope | scopegen -wl | anew -q $outputDir/tmp/.scope
  echo $url_scope | scopegen -wl | anew -q $outputDir/tmp/.scope  
  CDNs=(adobedtm akamai alibabacloud aliyun amazonaws appsflyer arubacloud aspnetcdn awsstatic azure bootstrapcdn bdimg cachefly cdn cdnjs cdnsun centurylink cloud cloudflare cloudfront cloudinary cloudsigma d3js fastly firebase fontawesome gcorelabs googleapis googletagmanager incapsula jquery jsdelivr keycdn onapp rackspace rawgit scaleaway section stackpath swarmify unpkg vercel yastatic)
       for cdn in "${CDNs[@]}"
          do
         echo $cdn >> $outputDir/tmp/cdns.txt
         done
  cat $outputDir/tmp/cdns.txt | sed '/^$/d' | scopegen -wl | anew -q $outputDir/tmp/.scope 
  #Cleans bad chars
  sed -i '/^\s*$/d; /^\.\*\.\*$/d; /^\.\*\\\.\$$/d' $outputDir/tmp/.scope
  echo -e "${YELLOW}$(cat $outputDir/tmp/.scope)${NC}\n"
else
  echo -e "${YELLOW}Use wildcard scope${NC} (${RED}.*${NC}) ? : ${RED}No $(echo -e "${RED}\u2717${NC}")${NC}"
  echo -e "${BLUE}Scope is set as:${NC}\n" && mkdir -p $outputDir/tmp
  echo $url_domain | scopegen -in | anew -q $outputDir/tmp/.scope
  sed -i '/^\s*$/d; /^\.\*\.\*$/d; /^\.\*\\\.\$$/d' $outputDir/tmp/.scope
  echo -e "${GREY}$(cat $outputDir/tmp/.scope)${NC}\n"  
fi
echo -e "${YELLOW}Don't Worry${NC} if your ${RED}Terminal Hangs${NC} for a bit.."
echo -e "It's a feature not a bug!\n"

#Dependency Checks
#Golang
if ! command -v go &> /dev/null 2>&1; then
    echo "➼ golang is not installed. Installing..."
    cd /tmp && git clone https://github.com/udhos/update-golang  && cd /tmp/update-golang && sudo ./update-golang.sh
    source /etc/profile.d/golang_path.sh
    sudo su -c "bash <(curl -sL https://git.io/go-installer)"
else
    GO_VERSION=$(go version | awk '{print $3}')
if [[ "$(printf '%s\n' "1.20.0" "$(echo "$GO_VERSION" | sed 's/go//')" | sort -V | head -n1)" != "1.20.0" ]]; then
        echo "➼ golang version 1.20.0 or greater is not installed. Installing..."
        cd /tmp && git clone https://github.com/udhos/update-golang  && cd /tmp/update-golang && sudo ./update-golang.sh
        source /etc/profile.d/golang_path.sh
    #else
    #    echo ""
    fi
fi
#asn
if ! command -v asn >/dev/null 2>&1; then
    echo "➼ asn is not installed. Installing..."
    sudo apt-get update && sudo apt-get install curl whois bind9-host mtr-tiny jq ipcalc grepcidr nmap ncat aha -y
    sudo wget https://raw.githubusercontent.com/nitefood/asn/master/asn -O /usr/local/bin/asn && sudo chmod +xwr /usr/local/bin/asn
fi
#dos2unix, for updates
if ! command -v dos2unix >/dev/null 2>&1; then
    echo "➼ dos2unix is not installed. Installing..."
    sudo apt-get update && sudo apt-get install dos2unix -y
fi
#linky
if ! command -v linky >/dev/null 2>&1; then
    sudo wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/linky/linky.sh -O /usr/local/bin/linky && sudo chmod +xwr /usr/local/bin/linky && linky -init
fi
#nmap
if ! command -v nmap >/dev/null 2>&1; then
    echo "➼ nmap is not installed. Installing..."
    sudo apt-get update && sudo apt-get install nmap -y
fi
#pipx
if ! command -v pipx >/dev/null 2>&1; then
    echo "➼ pipx is not installed. Installing..."
    #Python3-Pip
     sudo aptitude install python3-pip python3-aiohttp python3-requests python3-matplotlib python3-keras python3-opencv python3-django python3-flask -y
     #pipx
     python3 -m pip install pipx
     python3 -m pipx ensurepath
     sudo su -c "python3 -m pip install pipx"
     sudo su -c "python3 -m pipx ensurepath"
fi
#pyenv
if ! command -v pipx >/dev/null 2>&1; then
    curl -skq https://pyenv.run | bash
    if [ "$SHELL" = "/bin/bash" ]; then
             echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.bashrc
             echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >>  $HOME/.bashrc
             echo 'eval "$(pyenv init -)"' >>  $HOME/.bashrc
             echo 'export PYENV_ROOT="$HOME/.pyenv"' >>  $HOME/.profile
             echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >>  $HOME/.profile
             echo 'eval "$(pyenv init -)"' >>  $HOME/.profile
     elif [ "$SHELL" = "/bin/zsh" ]; then
             echo 'export PYENV_ROOT="$HOME/.pyenv"' >>  $HOME/.zshrc
             echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >>  $HOME/.zshrc && source  $HOME/.zshrc
             echo 'eval "$(pyenv init -)"' >>  $HOME/.zshrc
             source  $HOME/.zshrc
     elif [ "$SHELL" = "/usr/bin/fish" ]; then
             set -Ux PYENV_ROOT $HOME/.pyenv
             set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
            echo "pyenv init - | source" >> $HOME/.config/fish/config.fish
     else
           echo "Unknown shell: $SHELL"
     fi
fi
#Health Check for binaries
binaries=("anew" "ansi2txt" "cdna" "eget" "fasttld" "httpx" "nmap-formatter" "scopegen" "scopeview" "subxtract" "webanalyze" "whris" "wtfis")
for binary in "${binaries[@]}"; do
    if ! command -v "$binary" &> /dev/null; then
        echo "➼ Error: $binary not found"
        echo "➼ Attempting to Install missing tools"
        #anew
        go install -v github.com/tomnomnom/anew@latest
        #ansi2txt
        pip3 install ansi2txt
        #cdna
        go install -v github.com/Azathothas/BugGPT-Tools/cdna@main
        #eget
        go install -v github.com/zyedidia/eget@latest
        sudo su -c "go install -v github.com/zyedidia/eget@latest"
        #fasttld
        sudo wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/linky/assets/fasttld -O /usr/local/bin/fasttld && sudo chmod +xwr /usr/local/bin/fasttld
        #httpx
        go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
        #nmap-formatter
        go install -v github.com/vdjagilev/nmap-formatter/v2@latest
        #scopegen
        go install -v github.com/Azathothas/BugGPT-Tools/scopegen@main
        #scopeview
        sudo wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/scopeview/scopeview.sh -O /usr/local/bin/scopeview && sudo chmod +xwr /usr/local/bin/scopeview
        #subxtract
        sudo wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/subxtract/subxtract.sh -O /usr/local/bin/subxtract && sudo chmod +xwr /usr/local/bin/subxtract 
        #webanalyze
        sudo /root/go/bin/eget rverton/webanalyze --to /usr/local/bin/webanalyze && sudo chmod +xwr /usr/local/bin/webanalyze
        #whris
        go install -v github.com/harakeishi/whris@latest        
        #wtfis
        pipx install wtfis 
    fi
done
#Health Check for Tools
paths=("$HOME/Tools/humble/humble.py")
for path in "${paths[@]}"; do
    if [ ! -f "$path" ]; then
        echo "➼ Error: $path not found"
        echo "➼ Attempting to Install missing tools under $HOME/Tools $(mkdir -p $HOME/Tools)"    
        #Humble
         cd $HOME/Tools && git clone https://github.com/rfc-st/humble 
         pyenv global 3.11.2
         cd $HOME/Tools/humble && pip3 install -r requirements.txt   
         pip3 install colored && pip install --upgrade pip      
    fi
done
#configure wtfis --> $HOME/.env.wtfis
if [ ! -f "$HOME/.env.wtfis" ]; then
  echo "VT_API_KEY=$(cat $HOME/.config/amass/config.ini | grep -i data_sources.VirusTotal.Credentials -A 1 | grep -oP "(?<=apikey = ).*")" | anew "$HOME/.env.wtfis"
  echo "PT_API_KEY=$(cat $HOME/.config/amass/config.ini | grep -i data_sources.PassiveTotal.Credentials -A 1 | grep -oP "(?<=apikey = ).*")" | anew "$HOME/.env.wtfis"  
  echo "PT_API_USER=$(cat $HOME/.config/amass/config.ini | grep -i data_sources.PassiveTotal.Credentials -A 2 | grep -oP "(?<=username = ).*")" | anew "$HOME/.env.wtfis"   
  echo "SHODAN_API_KEY=$(cat $HOME/.config/amass/config.ini | grep -i data_sources.Shodan.Credentials -A 1 | grep -oP "(?<=apikey = ).*")" | anew "$HOME/.env.wtfis" 
  echo "IP2WHOIS_API_KEY=" | anew "$HOME/.env.wtfis"
  echo "WTFIS_DEFAULTS=-s -1 -n" | anew "$HOME/.env.wtfis"  
  sudo chmod +xwr $HOME/.env.wtfis
  echo "IP2WHOIS_API_KEY=#https://www.ip2whois.com --> https://www.ip2location.io/sign-up -->#API Key --> https://www.ip2location.io/dashboard"| anew "$HOME/.env.wtfis"
else
  if grep -q "IP2WHOIS_API_KEY=alice" "$HOME/.env.wtfis"; then
  sed -i "s/IP2WHOIS_API_KEY=alice/IP2WHOIS_API_KEY=$(echo "IP2WHOIS_API_KEY=#https://www.ip2whois.com --> https://www.ip2location.io/sign-up -->#API Key --> https://www.ip2location.io/dashboard"| anew "$HOME/.env.wtfis")/"
  fi
  if grep -q "VT_API_KEY=foo" "$HOME/.env.wtfis"; then
    sed -i "s/VT_API_KEY=foo/VT_API_KEY=$(cat $HOME/.config/amass/config.ini | grep -i data_sources.VirusTotal.Credentials -A 1 | grep -oP "(?<=apikey = ).*")/" "$HOME/.env.wtfis"
  fi
  if grep -q "PT_API_KEY=bar" "$HOME/.env.wtfis"; then
    sed -i "s/PT_API_KEY=bar/PT_API_KEY=$(cat $HOME/.config/amass/config.ini | grep -i data_sources.PassiveTotal.Credentials -A 2 | grep -oP "(?<=apikey = ).*")/" "$HOME/.env.wtfis"
  fi
  if grep -q "PT_API_USER=baz@example.com" "$HOME/.env.wtfis"; then
    sed -i "s/PT_API_USER=baz@example.com/PT_API_USER=$(cat $HOME/.config/amass/config.ini | grep -i data_sources.PassiveTotal.Credentials -A 2 | grep -oP "(?<=username = ).*")/" "$HOME/.env.wtfis"  
  fi
  if grep -q "SHODAN_API_KEY=hunter2" "$HOME/.env.wtfis"; then
    sed -i "s/SHODAN_API_KEY=hunter2/SHODAN_API_KEY=$(cat $HOME/.config/amass/config.ini | grep -i data_sources.Shodan.Credentials -A 2 | grep -oP "(?<=apikey = ).*")/" "$HOME/.env.wtfis"  
  fi
fi
  echo "WTFIS_DEFAULTS=-s -1 -n" | anew "$HOME/.env.wtfis"
  sudo chmod +xwr $HOME/.env.wtfis
##

#Main Subroutines
#INFO: 
echo -e "➼ INFO: \n" | tee -a $outputDir/Info.txt
#Whris:
whris $url_domain -v | tee -a $outputDir/Info.txt 
echo -e "\n" | tee -a $outputDir/Info.txt
#wtfis
wtfis $url_domain | tee -a $outputDir/Info.txt
sed -i '/^✓ Fetching data from Virustotal/d' $outputDir/Info.txt
sed -i '/^✓ Fetching domain whois from Virustotal/d' $outputDir/Info.txt
sed -i '/^✓ Fetching IP enrichments from Shodan/d' $outputDir/Info.txt
sed -i '/^✓ Fetching domain whois from Passivetotal/d' $outputDir/Info.txt
#asn detailed trace
asn -d $url_domain | ansi2txt | sed '/^[B]*$/d' | tee -a $outputDir/Info.txt
#shodan scan
asn -s $url_domain | ansi2txt | sed '/^[B]*$/d' | tee -a $TargetDir/1.txt
echo -e "\n" | tee -a $outputDir/Info.txt
#TechStack
#HttpX
echo "--------------------HttpX---TechDetect--------------------" | tee -a $outputDir/Info.txt
echo $url_domain | httpx -ports 20,21,22,25,53,80,110,137,139,143,161,443,445,465,587,902,993,995,1433,2379,3000,3306,3389,4004,4194,4443,5432,5900,6443,6666,6782,6783,6784,8000,8008,8080,8081,8088,8888,8443,9000,9001,9002,9090,9091,9099,10000,10250,10255,10256,10443,30876,44134,50000,50001,60000 -ip -status-code -title -location -follow-host-redirects -server -tech-detect -cdn -content-type -content-length -silent | ansi2txt | tee -a $outputDir/Info.txt
#webanalyze
wbappsfile=$(mktemp -d) && cd $wbappsfile && webanalyze -update
echo -e "\n" | tee -a $outputDir/Info.txt
echo "--------------------Webanalyzed---TechDetect--------------------" | tee -a $outputDir/Info.txt
webanalyze -host $url_domain -crawl 1 -silent | tee -a $outputDir/Info.txt
cd $originalDir

#DNSMAP --> https://dnsdumpster.com 
echo ""
echo -e "➼ Generating ${PURPLE}DNSMAP${NC} for ${BLUE}$url_domain${NC}"
#Fetch cookies & token
curl -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/111.0" -sk -D - https://dnsdumpster.com/ > /tmp/dscurl.txt && export csrftoken=$(cat /tmp/dscurl.txt | grep -i csrftoken | sed -E 's/.*csrftoken=([^;]+);.*/\1/') && echo "csrfoken: $csrftoken" && export csrfmiddlewaretoken=$(cat /tmp/dscurl.txt | grep -iE 'csrfmiddlewaretoken' | sed -E 's/.*value="([^"]+)".*/\1/') && echo "csrfmiddlewaretoken: $csrfmiddlewaretoken"
echo ""
#Initiate Request
dnsdumpster_response=$(curl -ski --no-buffer --request POST --url https://dnsdumpster.com/ --header 'Content-Type: application/x-www-form-urlencoded' --header "Cookie:csrftoken=$csrftoken"  --header "Host: dnsdumpster.com" --header "Referer: https://dnsdumpster.com/" --data "csrfmiddlewaretoken=$csrfmiddlewaretoken&targetip=$url_domain&user=free")
#Check if the response contains errors
if [[ $dnsdumpster_response == *"There was an error getting results. Check your query and try again"* ]]; then

    echo -e "${RED}✘ DNSdumpster failed${NC} to ${YELLOW}fetch ${BLUE}$url_domain-dnsmap.png${NC}"
    echo -e "${YELLOW}ⓘ  Are you sure ${BLUE}$url_domain${NC} is ${YELLOW}apex & alive${NC}?\n"
else
    wget --quiet --no-check-certificate --header 'Cookie: csrftoken=$csrftoken' --header 'Host: dnsdumpster.com' --header 'Referer: https://dnsdumpster.com/' "https://dnsdumpster.com/static/map/$url_domain.png" -O $outputDir/$url_domain-DNSMAP.png
    echo -e "${GREEN}✓ Successfully fetched ${BLUE}$url_domain-DNSMAP.png${NC}" 
fi

#Headers
#Check if latest python:
if python3 -c 'import sys; print(sys.version_info >= (3, 11, 0))'; then
   echo -e "➼ ${YELLOW}Python =>3.11.0${NC} ?\n ${GREEN}✓ Yes!${NC}"
else
   echo -e "➼ ${BLUE}Installing${NC} ${YELLOW}python 3.11.2${NC}, ${GREEN}Press${NC} ${PURPLE}Y${NC} & ${GREEN}Enter${NC}"
   pyenv install 3.11.2
   pyenv global 3.11.2
fi
#Run Humble
cd $TOOLS/humble && python3 $TOOLS/humble/humble.py -u $url -r -o html
mv $TOOLS/humble/*.html $outputDir/$url_domain-headers.html
echo ""
echo -e "${YELLOW}Report${NC} ${GREEN}exported${NC} & ${GREEN}moved${NC} to ${BLUE}$outputDir/$url_domain-headers.html${NC}"
if [ $? -eq 0 ]; then
  echo ""
else
  echo -e "${YELLOW}ⓘ  Are you sure ${BLUE}$url${NC} is ${YELLOW}correct & alive${NC}?"
  echo -e "${YELLOW}ⓘ  If${BLUE}$url${NC} is ${YELLOW}empty${NC}, try running again with ${BLUE}--url${NC}\n"
fi

##Ports
#Nmap
mkdir -p $outputDir/tmp/nmap
if [ "$ipv4_1" == "$ipv4_2" ]; then
  export ipv4="$ipv4_1"
  if [ -n "$tcp_udp" ]; then 
    echo -e "${YELLOW}ⓘ nmapping ${BLUE}$ipv4${NC} ➼ ${RED}tcp + udp${NC}\n"
     sudo nmap -A -sU -sT -p1-65535 -Pn -v --min-rate 5000 --min-parallelism 200 $ipv4 -oX $outputDir/tmp/nmap/tcudp_ipv4.xml
     if [ "$ipv6_1" == "$ipv6_2" ]; then
       export ipv6="$ipv6_1"     
    echo -e "${YELLOW}ⓘ nmapping ${BLUE}$ipv6${NC} ➼ ${RED}tcp + udp${NC}\n"
         sudo nmap -A -sU -sT -p1-65535 -Pn -v --min-rate 5000 --min-parallelism 200 -6 $ipv6 -oX $outputDir/tmp/nmap/tcudp_ipv6.xml
     else
    echo -e "${YELLOW}ⓘ nmapping ${BLUE}$ipv6_1${NC} & ${BLUE}$ipv6_2${NC} ➼ ${GREEN}tcp${NC} + ${RED}udp${NC}\n"
         sudo nmap -A -sU -sT -p1-65535 -Pn -v --min-rate 5000 --min-parallelism 200 -6 $ipv6_1 -oX $outputDir/tmp/nmap/tcudp_ipv6_1.xml
         sudo nmap -A -sU -sT -p1-65535 -Pn -v --min-rate 5000 --min-parallelism 200 -6 $ipv6_2 -oX $outputDir/tmp/nmap/tcudp_ipv6_2.xml
     fi
  else
    echo -e "${YELLOW}ⓘ nmapping ${BLUE}$ipv4${NC} ➼ ${GREEN}tcp${NC} only\n"
     sudo nmap -A -p1-65535 -Pn -v --min-rate 2000 $ipv4 -oX $outputDir/tmp/nmap/ipv4.xml
     if [ "$ipv6_1" == "$ipv6_2" ]; then
        export ipv6="$ipv6_1"  
  echo -e "${YELLOW}ⓘ nmapping ${BLUE}$ipv6${NC} ➼ ${GREEN}tcp${NC} only\n"           
        sudo nmap -A -p1-65535 -Pn -v --min-rate 2000 -6 $ipv6 -oX $outputDir/tmp/nmap/ipv6.xml
     else
  echo -e "${YELLOW}ⓘ nmapping ${BLUE}$ipv6_1${NC} | ${BLUE}$ipv6_2${NC} ➼ ${GREEN}tcp${NC} only\n"     
        sudo nmap -A -p1-65535 -Pn -v --min-rate 2000 -6 $ipv6_1 -oX $outputDir/tmp/nmap/ipv6_1.xml
        sudo nmap -A -p1-65535 -Pn -v --min-rate 2000 -6 $ipv6_2 -oX $outputDir/tmp/nmap/ipv6_2.xml   
     fi 
  fi
else
  if [ -n "$tcp_udp" ]; then 
  echo -e "${YELLOW}ⓘ nmapping ${BLUE}$ipv4_1${NC} | ${BLUE}$ipv4_2${NC} | ${BLUE}$ipv6_1${NC} | ${BLUE}$ipv6_2${NC}\n ➼ ${GREEN}tcp${NC} + ${RED}udp${NC}\n"  
     sudo nmap -A -sU -sT -p1-65535 -Pn -v --min-rate 5000 --min-parallelism 200 $ipv4_1 -oX $outputDir/tmp/nmap/tcudp_ipv4_1.xml
     sudo nmap -A -sU -sT -p1-65535 -Pn -v --min-rate 5000 --min-parallelism 200 $ipv4_2 -oX $outputDir/tmp/nmap/tcudp_ipv4_2.xml
     sudo nmap -A -sU -sT -p1-65535 -Pn -v --min-rate 5000 --min-parallelism 200 -6 $ipv6_1 -oX $outputDir/tmp/nmap/tcudp_ipv6_1.xml
     sudo nmap -A -sU -sT -p1-65535 -Pn -v --min-rate 5000 --min-parallelism 200 -6 $ipv6_2 -oX $outputDir/tmp/nmap/tcudp_ipv6_2.xml
  else
     echo -e "${YELLOW}ⓘ nmapping ${BLUE}$ipv4_1${NC}\n ➼ ${GREEN}tcp${NC} only\n"
     sudo nmap -A -p1-65535 -Pn -v --min-rate 2000 $ipv4_1 -oX $outputDir/tmp/nmap/ipv4_1.xml
     echo -e "${YELLOW}ⓘ nmapping ${BLUE}$ipv4_2${NC}\n ➼ ${GREEN}tcp${NC} only\n"
     sudo nmap -A -p1-65535 -Pn -v --min-rate 2000 $ipv4_2 -oX $outputDir/tmp/nmap/ipv4_2.xml
          if [ "$ipv6_1" == "$ipv6_2" ]; then
              export ipv6="$ipv6_1"  
              echo -e "${YELLOW}ⓘ nmapping ${BLUE}$ipv6${NC}\n ➼ ${GREEN}tcp${NC} only\n"
              sudo nmap -A -p1-65535 -Pn -v --min-rate 2000 -6 $ipv6 -oX $outputDir/tmp/nmap/ipv6.xml
          else    
              echo -e "${YELLOW}ⓘ nmapping ${BLUE}$ipv6_1${NC}\n ➼ ${GREEN}tcp${NC} only\n"
              sudo nmap -A -p1-65535 -Pn -v --min-rate 2000 -6 $ipv6_1 -oX $outputDir/tmp/nmap/ipv6_1.xml
              echo -e "${YELLOW}ⓘ nmapping ${BLUE}$ipv6_2${NC}\n ➼ ${GREEN}tcp${NC} only\n"
              sudo nmap -A -p1-65535 -Pn -v --min-rate 2000 -6 $ipv6_2 -oX $outputDir/tmp/nmap/ipv6_2.xml
          fi    
  fi
fi
# permissions
find $outputDir -type f -exec sudo chmod +xwr {} \; -o -type d -exec chmod +xwr {} \;
echo -e "\n"
# Parse Output & Clean Results
find $outputDir/tmp/nmap -type f -name "*.xml" -print0 | xargs -0 -I {} sh -c 'prefix="$url_domain-"; filename=$(basename "{}" .xml); output_file="${prefix}${filename}.html"; nmap-formatter html "{}" > "$output_file"'


#linky
if [ -n "$linky" ]; then 
rm -rf $outputDir/linky 2>/dev/null ; mkdir -p $outputDir/linky
  export linky_url=$(echo $url | sed 's#\(^https\?://[^/]*\).*#\1#')
  flags=("--deep" "-params")
  if [ -n "$optionalHeaders" ]; then
    flags+=("-h" "$optionalHeaders")
  fi
  if [ -n "$githubToken" ]; then
    flags+=("-gh" "$githubToken")
  fi
  if [ -n "$wildcard" ]; then
    flags+=("-wl")
  fi
  echo -e "➼ Running ${GREEN}ⓘ Linky${NC} on ${BLUE}$url${NC} with flags: ${YELLOW}${flags[*]}${NC}\n"
  linky -u $linky_url -o $outputDir/linky "${flags[@]}"
fi





#



#Cleanups
find $outputDir -type f -exec sudo chmod +xwr {} \; -o -type d -exec chmod +xwr {} \;
find $outputDir -type f -size 0 -delete && find $outputDir -type d -empty -delete


#Check For Update on Script end
echo -e "\n"
REMOTE_FILE=$(mktemp)
curl -s -H "Cache-Control: no-cache" https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/weebu/weebu.sh -o "$REMOTE_FILE"
if ! diff --brief /usr/local/bin/weebu "$REMOTE_FILE" >/dev/null 2>&1; then
echo ""
echo -e "➼ ${YELLOW}Update Found!${NC} ${BLUE}updating ..${NC} $(weebu -up)" 
  else
  rm -f "$REMOTE_FILE" 2>/dev/null
    exit 0
fi
#EOF