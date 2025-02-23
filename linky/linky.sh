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
RESET='\033[0m'
NC='\033[0m'

#Banner
echo -e "${PURPLE}"
cat << "EOF"
  ╔╗  ╔╗
╔╗╠╬═╦╣╠╦╦╗
║╚╣║║║║═╣║║
╚═╩╩╩═╩╩╬╗║
        ╚═╝
EOF
echo -e "${NC}"
#Initialization, Only on a fresh install
if [[ "$*" == *"-init"* ]] || [[ "$*" == *"--init"* ]] || [[ "$*" == *"init"* ]] ; then
  echo -e "➼ ${GREEN}Initializing linky...${NC}"
  echo -e "➼ Please ${YELLOW}exit (ctrl + c)${NC} if you already did this" 
  echo "➼ Setting up...$(rm -rf /tmp/example.com 2>/dev/null)"
  linky -u https://example5.com -o /tmp/example.com -gh ghp_xyz 
  rm -rf /tmp/example.com 2>/dev/null
  echo ""
  echo -e "${GREEN}Initialized Successfully${NC}"
  exit 0
fi
#Help / Usage
if [[ "$*" == *"-help"* ]] || [[ "$*" == *"--help"* ]] || [[ "$*" == *"help"* ]] ; then
  echo -e "${YELLOW}➼ Usage${NC}: ${PURPLE}linky${NC} ${BLUE}-u${NC} <url> ${BLUE}-o${NC} /path/to/outputdir ${BLUE}-gh${NC} <github_token> <other-options, see ${BLUE}--help${NC}\n"
  echo -e "${YELLOW}Extended Help${NC}"
  echo -e "${BLUE}-u${NC},       ${BLUE}--url${NC}              Specify the ${BLUE}URL${NC}  to scrape (${YELLOW}Required${NC} )"
  echo -e "${BLUE}-o${NC},       ${BLUE}--output_dir${NC}       Specify the ${BLUE}directory${NC} to save the ${BLUE}output files${NC} (${YELLOW}Required${NC})"
  echo -e "${BLUE}-h${NC},       ${BLUE}--headers${NC}          Specify additional ${BLUE}headers${NC} or ${BLUE}cookies${NC} (use ${YELLOW}\"\"${NC}, optional)"
  echo -e "${BLUE}-d${NC},       ${BLUE}--deep${NC}             Specify if ${YELLOW}Gospider Hakrawler Katana${NC} & ${YELLOW}XnLinkfinder${NC} should run with ${RED}depth 5${NC}.(${YELLOW}Slow${NC})"
  echo -e "${BLUE}-cdns${NC},    ${BLUE}--cdns${NC}             Use ${YELLOW}CDNs${NC} with ${GREEN}any ${BLUE}scope${NC}"   
  echo -e "${BLUE}-ctmp${NC},    ${BLUE}--clean-tmp${NC}        Cleans ${YELLOW}/tmp/${NC} files after run"
  echo -e "${BLUE}-curls${NC},   ${BLUE}--clean-urls${NC}       Removes noisy junk urls (${YELLOW}godeclutter | urless${NC})"
  echo -e "${BLUE}-params${NC},  ${BLUE}--discover-params${NC}  Runs ${YELLOW}Arjun${NC} for parameter discovery (${YELLOW}Basic & Slow${NC})"
  echo -e "${BLUE}-fl${NC},      ${BLUE}--flex-scope${NC}       Run linky with ${BLUE}normal scope${NC} but ${YELLOW}include CDNs${NC}" 
  echo -e "${BLUE}-wl${NC},      ${BLUE}--wildcard${NC}         Run linky with ${PINK}wildcard${NC} (${RED}.*${NC}) scope"
  echo -e "${BLUE}-up,      ${BLUE}--update${NC}           ${GREEN}Update ${PURPLE}linky${NC}\n"
  echo -e "(${YELLOW}Not Required${NC} if ${BLUE}$HOME/.config/.github_tokens ${GREEN}exists${NC})"
  echo -e "${BLUE}-gh${NC},      ${BLUE}--github_token${NC}     Specify manually: ${YELLOW}ghp_xxx${NC}\n"
  echo -e "(Uses ${YELLOW}Entropy Scanning${NC} : ${RED}Massive Output, Resource-Intensive & Slow${NC})"
  echo -e "${BLUE}-secrets${NC}, ${BLUE}--scan-secrets${NC}     Runs ${YELLOW}gf-secrets + TruffleHog${NC}\n"
  echo -e "(${YELLOW}Only run on a fresh Install${NC})"
  echo -e "${BLUE}-init${NC},    ${BLUE}--init${NC}             ${GREEN}Initialize${NC} ➼ ${PURPLE}linky${NC} by dry-running it against example.com\n"
  echo -e "${YELLOW}Example Usage${NC}: "
  echo -e "${BLUE}Basic${NC}: "
  echo -e "${PURPLE}linky${NC} ${BLUE}--url${NC} ${YELLOW}https://example.com${NC} ${BLUE}--output_dir${NC} ${YELLOW}/path/to/outputdir${NC} ${BLUE}--github_token${NC} ${YELLOW}ghp_xyz${NC}\n"
  echo -e "${RED}Extensive${NC}: "
  echo -e "${PURPLE}linky${NC} ${BLUE}--url${NC} ${YELLOW}https://example.com${NC} ${BLUE}--output_dir${NC} ${YELLOW}/path/to/outputdir${NC} ${BLUE}--github_token${NC} ${YELLOW}ghp_xyz${NC} ${BLUE}--headers ${YELLOW}\"Authorization: Bearer token; Cookie: cookie_value\"${NC} ${BLUE}--deep${NC} ${BLUE}--discover-params${NC} ${BLUE}--wildcard${NC}"
  echo ""
  echo -e "${GREEN}Tips${NC}: "
  echo -e "➼ Include ${BLUE}UrlScan API keys${NC} in ${BLUE}$HOME/Tools/waymore/config.yml${NC} to find more links"
  echo -e "➼ Include multiple ${GREEN}github_tokens${NC} in ${BLUE}$HOME/.config/.github_tokens${NC} to avoid ${RED}rate limits${NC}"
  echo -e "➼ ${RED}--scan-secrets${NC} produces ${YELLOW}massive files (Several ${RED}GB${NC}s). So ${GREEN}TuffleHog is run by default${NC}. Best run with ${BLUE}--deep${NC}" 
  echo -e "➼ ${YELLOW}Don't Worry${NC} if your ${RED}Terminal Hangs${NC} for a bit.. It's a feature not a bug\n"
  exit 0
fi

# Update. Github caches take several minutes to reflect globally  
if [[ $# -gt 0 && ( "$*" == *"up"* || "$*" == *"-up"* || "$*" == *"update"* || "$*" == *"--update"* ) ]]; then
  echo -e "➼ ${YELLOW}Checking For ${BLUE}Updates${NC}"
      if ping -c 2 github.com > /dev/null; then
      REMOTE_FILE=$(mktemp)
      curl -s -H "Cache-Control: no-cache" https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/linky/linky.sh -o "$REMOTE_FILE"
         if ! diff --brief /usr/local/bin/linky "$REMOTE_FILE" >/dev/null 2>&1; then
             echo -e "➼ ${YELLOW}NEW!! Update Found! ${BLUE}Updating ..${NC}" 
             dos2unix $REMOTE_FILE > /dev/null 2>&1 
             sudo mv "$REMOTE_FILE" /usr/local/bin/linky && echo -e "➼ ${GREEN}Updated${NC} to ${BLUE}@latest${NC}\n" 
             echo -e "➼ ${YELLOW}ChangeLog:${NC} ${DGREEN}$(curl -s https://api.github.com/repos/Azathothas/BugGPT-Tools/commits?path=linky/linky.sh | jq -r '.[0].commit.message')${NC}"
             echo -e "➼ ${YELLOW}Pushed at${NC}: ${DGREEN}$(curl -s https://api.github.com/repos/Azathothas/BugGPT-Tools/commits?path=linky/linky.sh | jq -r '.[0].commit.author.date')${NC}\n"
             sudo chmod +xwr /usr/local/bin/linky
             rm -f "$REMOTE_FILE" 2>/dev/null
             else
             echo -e "➼ ${YELLOW}Already ${BLUE}UptoDate${NC}"
             echo -e "➼ Most ${YELLOW}recent change${NC} was on: ${DGREEN}$(curl -s https://api.github.com/repos/Azathothas/BugGPT-Tools/commits?path=linky/linky.sh | jq -r '.[0].commit.author.date')${NC} [${DGREEN}$(curl -s https://api.github.com/repos/Azathothas/BugGPT-Tools/commits?path=linky/linky.sh | jq -r '.[0].commit.message')${NC}]\n"             
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
    -o|--output_dir)
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
    -d|--deep) 
     deep=1
     shift
    ;;
    -ctmp|--clean-tmp) 
     clean_tmp=1
     shift
    ;;  
    -curls|--clean-urls) 
     clean_urls=1
     shift
    ;;  
    -params|--discover-params)
     discover_params=1
     shift
    ;;  
    -fl|--flex-scope)
     flex_scope=1
     shift
    ;;
    -cdns|--cdns)
     cdn_scope=1
     shift
    ;;              
    -wl|--wildcard)
     wildcard_scope=1
     shift
    ;;     
    -secrets|--scan-secrets)
     scan_secrets=1
     shift
    ;;
    *) 
    echo -e "${RED}Error: Invalid option '$key' , try --help for Usage$(rm -rf $outputDir 2>/dev/null)"
    exit 1
    ;;
  esac
done

#Setup Vars & default values
export url=$url
url=${url:=$URL}
if [ -z "$url" ]; then
  echo -e "${RED}Error: ${YELLOW}URL is missing${NC} for option ${BLUE}'-u | --url'${NC}"
  rm -rf $outputDir/tmp $outputDir/.scope
  exit 1  
fi
export outputDir=$outputDir
#Select Random token if !ghp
if [ -z "$githubToken" ]; then
  github_tokens="$HOME/.config/.github_tokens"
  if [ -s "$github_tokens" ]; then
    random_token=$(shuf -n 1 "$github_tokens")
    export githubToken=$random_token
  fi
fi
#Others
export cdn_scope=$cdn_scope
export clean_tmp=$clean_tmp
export deep=$deep
export discover_params=$discover_params
export flex_scope=$flex_scope
export optionalHeaders=$optionalHeaders
export wildcard=$wildcard_scope
export scan_secrets=$scan_secrets
originalDir=$(pwd)

#Recheck Values
echo -e "${YELLOW}url: ${BLUE}$url${NC}"
echo -e "${YELLOW}outputDir: ${BLUE}$outputDir${NC}"
echo -e "${YELLOW}githubToken: ${BLUE}$githubToken${NC}"
echo -e "${YELLOW}optionalHeaders: ${BLUE}$optionalHeaders${NC}"
if [ -n "$deep" ] && [ "$deep" -eq 1 ]; then
  echo -e "${YELLOW}Run with --depth 5 for all crawlers? : ${BLUE}Yes $(echo -e "${GREEN}\u2713${NC}")${NC}"
else
  echo -e "${YELLOW}Run with --depth 5 for all crawlers? : ${RED}No $(echo -e "${RED}\u2717${NC}")${NC}"
fi
if [ -n "$clean_tmp" ] && [ "$clean_tmp" -eq 1 ]; then
  echo -e "${YELLOW}Clean Temporary Files ($outputDir/tmp)? : ${BLUE}Yes $(echo -e "${GREEN}\u2713${NC}")${NC}"
else
  echo -e "${YELLOW}Clean Temporary Files ($outputDir/tmp)? : ${RED}No $(echo -e "${RED}\u2717${NC}")${NC}"
fi
if [ -n "$clean_urls" ] && [ "$clean_urls" -eq 1 ]; then
  echo -e "${YELLOW}Clean URLs (Urless | GoDeclutter)? : ${BLUE}Yes $(echo -e "${GREEN}\u2713${NC}")${NC}"
else
  echo -e "${YELLOW}Clean URLs (Urless | GoDeclutter)? : ${RED}No $(echo -e "${RED}\u2717${NC}")${NC}"
fi
if [ -n "$discover_params" ] && [ "$discover_params" -eq 1 ]; then
  echo -e "${YELLOW}Parameter Discovery for all URLS? : ${BLUE}Yes $(echo -e "${GREEN}\u2713${NC}")${NC}"
else
  echo -e "${YELLOW}Parameter Discovery for all URLS? : ${RED}No $(echo -e "${RED}\u2717${NC}")${NC}"
fi
if [ -n "$scan_secrets" ] && [ "$scan_secrets" -eq 1 ]; then
  echo -e "${YELLOW}Secrets Scanning everything in $outputDir? : ${BLUE}Yes $(echo -e "${GREEN}\u2713${NC}")${NC}"
else
  echo -e "${YELLOW}Secrets Scanning everything in $outputDir? : ${RED}No $(echo -e "${RED}\u2717${NC}")${NC}"
fi
##Scope
#Extract root domain name 
scope_domain=$(echo "$url" | unfurl apexes)
alt_scope_domain=$(fasttld extract $url | grep -E 'domain:|suffix:' | awk '{print $2}' | sed -n '2,3p' | sed -n '1p;2p' | tr '\n' '.' | sed 's/\.$//' ; echo)
#Extract full domain name
domain=$(echo "$url" | unfurl domains)
#Set .scope 
   #CDNS 
    mkdir -p $outputDir/tmp
    CDNs=(2o7.net adobedtm.com akamaihd.net akamaized.net aliyuncs.com amazonaws.com appsflyer.com arubacloud.com aspnetcdn.com azureedge.net bdimg.com bootstrapcdn.com cachefly.net cdnjs.com cdnsun.net centurylink.net cloudcdn.net cloudflare.com cloudflareinsights.com cloudfront.net cloudinary.com cloudsigma.com core.windows.net d3js.org demdex.net edgekey.net edgesuite.net everesttech.net fastly.net firebase.com fontawesome.com gcdn.co googleapis.com googletagmanager.com incapsula.com jquery.com jquery.com.ui jsdelivr.net kxcdn.com omtrdc.net onappcdn.com rackspacecloud.com rawgit.com scaleway.com section.io ssl.cf1.rackcdn.com stackpathcdn.com swarmify.com unpkg.com vercel.app yastatic.net)
       for cdn in "${CDNs[@]}"
          do
         echo $cdn >> $outputDir/tmp/cdns.txt
         done
#Flex Scope
if [ -n "$flex_scope" ] && [ "$flex_scope" -eq 1 ]; then
  echo -e "${YELLOW}Use Flexible scope${NC} (${RED}.*${NC}) ? : ${BLUE}Yes $(echo -e "${GREEN}\u2713${NC}")${NC}"
  cat $outputDir/tmp/cdns.txt | scopegen -in | anew -q $outputDir/.scope 
  echo $alt_scope_domain | scopegen -in | anew -q $outputDir/.scope
  sed -i '/^\s*$/d; /^\.\*\.\*$/d; /^\.\*\\\.\$$/d' $outputDir/.scope
else
  echo -e "${YELLOW}Use Flexible scope${NC} (${RED}.*${NC}) ? : ${RED}No $(echo -e "${RED}\u2717${NC}")${NC}"
  echo $domain | scopegen -in | anew -q $outputDir/.scope
      if [ -n "$cdn_scope" ] && [ "$cdn_scope" -eq 1 ]; then
         cat $outputDir/tmp/cdns.txt | scopegen -in | anew -q $outputDir/.scope 
         echo -e "${YELLOW}CDNs${NC} (${RED}.*${NC}) ? : ${BLUE}Yes $(echo -e "${GREEN}\u2713${NC}")${NC}"
      else
         echo -e "${YELLOW}CDNs${NC} (${RED}.*${NC}) ? : ${RED}No $(echo -e "${RED}\u2717${NC}")${NC}"
      fi  
  sed -i '/^\s*$/d; /^\.\*\.\*$/d; /^\.\*\\\.\$$/d' $outputDir/.scope
fi
#Wildcard
if [ -n "$wildcard" ] && [ "$wildcard" -eq 1 ]; then
  echo -e "${YELLOW}Use wildcard scope${NC} (${RED}.*${NC}) ? : ${BLUE}Yes $(echo -e "${GREEN}\u2713${NC}")${NC}"
  #Extract root domain name 
  wl_scope=$(echo "$url" | subxtract | sed '/^$/d' | sed '/public[s ]*suffix[s ]*list[s ]*updated/Id')
  echo $wl_scope | scopegen -wl | anew -q $outputDir/.scope
  echo $alt_scope_domain | scopegen -in | anew -q $outputDir/.scope
      if [ -n "$cdn_scope" ] && [ "$cdn_scope" -eq 1 ]; then
         cat $outputDir/tmp/cdns.txt | scopegen -in | anew -q $outputDir/.scope 
         echo -e "${YELLOW}CDNs${NC} (${RED}.*${NC}) ? : ${BLUE}Yes $(echo -e "${GREEN}\u2713${NC}")${NC}"
      else
         echo -e "${YELLOW}CDNs${NC} (${RED}.*${NC}) ? : ${RED}No $(echo -e "${RED}\u2717${NC}")${NC}"
      fi       
#Cleans bad chars
  sed -i '/^\s*$/d; /^\.\*\.\*$/d; /^\.\*\\\.\$$/d' $outputDir/.scope
else
  echo -e "${YELLOW}Use wildcard scope${NC} (${RED}.*${NC}) ? : ${RED}No $(echo -e "${RED}\u2717${NC}")${NC}"
  sub_scope=$(echo "$url_domain" | subxtract -s | sed '/^$/d' | sed '/public[s ]*suffix[s ]*list[s ]*updated/Id')
  echo $sub_scope | scopegen -in | anew -q $outputDir/tmp/.scope
  echo $domain | scopegen -in | anew -q $outputDir/.scope
      if [ -n "$cdn_scope" ] && [ "$cdn_scope" -eq 1 ]; then
         cat $outputDir/tmp/cdns.txt | scopegen -in | anew -q $outputDir/.scope 
         echo -e "${YELLOW}CDNs${NC} (${RED}.*${NC}) ? : ${BLUE}Yes $(echo -e "${GREEN}\u2713${NC}")${NC}"
      else
         echo -e "${YELLOW}CDNs${NC} (${RED}.*${NC}) ? : ${RED}No $(echo -e "${RED}\u2717${NC}")${NC}"
      fi    
  sed -i '/^\s*$/d; /^\.\*\.\*$/d; /^\.\*\\\.\$$/d' $outputDir/.scope
fi
echo -e "${BLUE}Scope is set as:${NC}$(sort -u $outputDir/.scope -o $outputDir/.scope) " 
echo -e "${GREY}$(cat $outputDir/.scope)${NC}\n"
echo -e "${YELLOW}Don't Worry${NC} if your ${RED}Terminal Hangs${NC} for a bit.."
echo "It's a feature not a bug!"
echo ""

#Dependency Checks
#aptitude
if ! command -v aptitude >/dev/null 2>&1; then
    echo "➼ aptitude is not installed. Installing..."
    sudo apt-get install aptitude -y
    sudo aptitude install bzip2 python3-bz2file libncurses-dev libreadline-dev libcurl4-openssl-dev libssl-dev readline-common sqlite3 tk lzma make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git -y
fi
#Chromium webdrivers
if ! command -v chromium >/dev/null 2>&1; then
    echo "➼ chromium-chromedriver is not installed. Installing..."
    sudo apt-get update && sudo apt-get install chromium chromium-chromedriver chromium-common chromium-driver -y
fi
#dos2unix
if ! command -v dos2unix >/dev/null 2>&1; then
    echo "➼ dos2unix is not installed. Installing..."
    sudo apt-get update && sudo apt-get install dos2unix -y
fi
#go
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
        sudo su -c "bash <(curl -sL https://git.io/go-installer)"
    fi
fi
#go updater
if ! command -v gup >/dev/null 2>&1; then
    echo "➼ gup is not installed. Installing..."
    go install -v github.com/nao1215/gup@latest && clear
    gup completion
    exec "$SHELL"
    echo "➼ Updating all your go tools..keep patience...$(gup update)"
fi
#npm global
if ! command -v npm &> /dev/null 2>&1; then
    echo "➼ npm is not installed. Installing..."
    sudo apt-get update && sudo apt-get install npm -y
fi
#parallel
if ! command -v parallel >/dev/null 2>&1; then
    echo "➼ parallel is not installed. Installing..."
    sudo apt-get update && sudo apt-get install parallel -y
fi
#pip3
if ! command -v pip3 &> /dev/null; then
   echo "➼ python3-pip is not installed. Installing..." 
   sudo apt-get update && sudo apt-get install python3-pip -y
   pip install --upgrade pip
fi
#pipx
if ! command -v pipx &> /dev/null; then
   echo "➼ pipx is not installed. Installing..." 
   python3 -m pip install pipx
   python3 -m pipx ensurepath
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
             exec "$SHELL"
            #set pyenv global vars
             pyenv install 3.11.2
             pyenv global 3.11.2  
     elif [ "$SHELL" = "/bin/zsh" ]; then
             echo 'export PYENV_ROOT="$HOME/.pyenv"' >>  $HOME/.zshrc
             echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >>  $HOME/.zshrc && source  $HOME/.zshrc
             echo 'eval "$(pyenv init -)"' >>  $HOME/.zshrc
             source  $HOME/.zshrc
             exec "$SHELL"
            #set pyenv global vars
             pyenv install 3.11.2
             pyenv global 3.11.2 
     elif [ "$SHELL" = "/usr/bin/fish" ]; then
             set -Ux PYENV_ROOT $HOME/.pyenv
             set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
             echo "pyenv init - | source" >> $HOME/.config/fish/config.fish
             exec "$SHELL"
            #set pyenv global vars
             pyenv install 3.11.2
             pyenv global 3.11.2              
     else
           echo "Unknown shell: $SHELL"
     fi
fi
#Health Check for binaries
binaries=("anew" "ansi2txt" "arjun" "fasttld" "fff" "fget" "gau" "godeclutter" "gospider" "hakrawler" "js-beautify" "katana" "nuclei" "roboxtractor" "scopegen" "scopeview" "subjs" "trufflehog" "unfurl" "waybackurls" "yataf")
for binary in "${binaries[@]}"; do
    if ! command -v "$binary" &> /dev/null; then
        echo "➼ Error: $binary not found"
        echo "➼ Attempting to Install missing tools"
        go install -v github.com/tomnomnom/anew@latest
        #ansi2txt
        pip3 install ansi2txt
        pipx install -f "git+https://github.com/s0md3v/Arjun.git" --include-deps
        go install -v github.com/lc/gau/v2/cmd/gau@latest
        sudo wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/linky/assets/fasttld -O /usr/local/bin/fasttld && sudo chmod +xwr /usr/local/bin/fasttld
        go env -w GO111MODULE="auto" ; go get -u -v github.com/tomnomnom/fff
        go env -w GO111MODULE="auto" ; go get -u -v github.com/bp0lr/fget
        go install -v github.com/c3l3si4n/godeclutter@main
        go install -v github.com/jaeles-project/gospider@latest
        go install -v github.com/hakluke/hakrawler@latest
        sudo npm -g install js-beautify
        go install -v github.com/projectdiscovery/katana/cmd/katana@latest
        go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest && nuclei -update-templates
        go env -w GO111MODULE="auto" ; go get -u github.com/Josue87/roboxtractor
        go install -v github.com/Azathothas/BugGPT-Tools/scopegen@main
        sudo wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/scopeview/scopeview.sh -O /usr/local/bin/scopeview && sudo chmod +xwr /usr/local/bin/scopeview
        go install -v github.com/lc/subjs@latest
        cd /tmp && git clone https://github.com/trufflesecurity/trufflehog.git ; cd /tmp/trufflehog && go install -v
        go install -v github.com/tomnomnom/unfurl@latest
        go install -v github.com/tomnomnom/waybackurls@latest
        go install -v github.com/Damian89/yataf@master
    fi
done
#Health Check for Tools
paths=("$HOME/Tools/JSA/automation.sh" "$HOME/Tools/Arjun/arjun/db/large.txt" "$HOME/Tools/gf-secrets/gf-secrets.sh" "$HOME/Tools/github-search/github-endpoints.py" "$HOME/Tools/urless/urless.py" "$HOME/Tools/waymore/waymore.py" "$HOME/Tools/xnLinkFinder/xnLinkFinder.py")
for path in "${paths[@]}"; do
    if [ ! -f "$path" ]; then
        echo "➼ Error: $path not found"
        echo "➼ Attempting to Install missing tools under $HOME/Tools $(mkdir -p $HOME/Tools)"  
        #set pyenv global vars
        pyenv install 3.11.2
        pyenv global 3.11.2  
        #Arjun
        cd $HOME/Tools && git clone https://github.com/s0md3v/Arjun.git   
        #Setup gf-patterns
        cd /tmp/ && git clone https://github.com/NitinYadav00/gf-patterns ; cd /tmp/gf-patterns && mv *.json ~/.gf
        cd $HOME/Tools && git clone https://github.com/dwisiswant0/gf-secrets 
        chmod +x $HOME/Tools/gf-secrets/gf-secrets.sh
        #Using Secres-DB & secpat2gf
        pip3 install secpat2gf
        wget https://raw.githubusercontent.com/mazen160/secrets-patterns-db/master/db/rules-stable.yml -O /tmp/rules.yaml 
        secpat2gf --save -r /tmp/rules.yaml        
        #gwen001/github-search
        cd $HOME/Tools && git clone https://github.com/gwen001/github-search.git && cd $HOME/Tools/github-search && pip3 install -r requirements.txt
        pip3 install colored 
        pip install --upgrade pip
        #w9w/JSA
        cd $HOME/Tools && git clone https://github.com/w9w/JSA.git && cd $HOME/Tools/JSA && pip3 install -r requirements.txt
        wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/linky/assets/JSA_automation.sh -O $HOME/Tools/JSA/automation.sh
        chmod +x $HOME/Tools/JSA/automation.sh && chmod +x $HOME/Tools/JSA/automation/404_js_wayback.sh
        #xnl-h4ck3r/Urless
        cd $HOME/Tools && git clone https://github.com/xnl-h4ck3r/urless.git && cd $HOME/Tools/urless 
        sudo python3 $HOME/Tools/urless/setup.py install
        #xnl-h4ck3r/Waymore
        cd $HOME/Tools && git clone https://github.com/xnl-h4ck3r/waymore.git && cd $HOME/Tools/waymore 
        python3 -m pip install argparse PyYAML requests setuptools termcolor psutil urlparse3
        pip3 install -r requirements.txt 
        cd $HOME/Tools/waymore && sudo python3 $HOME/Tools/waymore/setup.py install
        #xnl-h4ck3r/xnLinkFinder 
        cd $HOME/Tools && git clone https://github.com/xnl-h4ck3r/xnLinkFinder.git && cd $HOME/Tools/xnLinkFinder
        sudo python3 $HOME/Tools/xnLinkFinder/setup.py install        
    fi
done

#Start Tools
#Set pyenv var again
pyenv global 3.11.2
#Gau
echo -e "➼ ${YELLOW}Running ${BLUE}gau${NC} on: ${GREEN}$url${NC}" && sleep 3s
echo $url | gau --threads 20 | anew $outputDir/tmp/gau-urls.txt
cat $outputDir/tmp/gau-urls.txt | anew -q $outputDir/tmp/urls.txt && clear

#Github-Endpoints
echo -e "➼ ${YELLOW}Running ${BLUE}github-endpoints${NC} on: ${GREEN}$url${NC}" && sleep 3s
python3 $HOME/Tools/github-search/github-endpoints.py -t $githubToken -d $domain --extend | anew $outputDir/tmp/git-urls.txt
cat $outputDir/tmp/git-urls.txt | anew $outputDir/tmp/urls.txt

#GoSpider
echo -e "➼ ${YELLOW}Running ${BLUE}GoSpider${NC} on: ${GREEN}$url${NC} "
if [ -n "$optionalHeaders" ]; then 
  if [ -n "$deep" ]; then
    gospider -s $url --other-source --include-subs --include-other-source --concurrent 50 --depth 5 -H "$optionalHeaders" --quiet | grep -aEo 'https?://[^ ]+' | sed 's/]$//' | anew $outputDir/tmp/gospider-urls.txt
  else
    gospider -s $url --other-source --include-subs --include-other-source --concurrent 20 -H "$optionalHeaders" --quiet | grep -aEo 'https?://[^ ]+' | sed 's/]$//' |  anew $outputDir/tmp/gospider-urls.txt
  fi
else
  if [ -n "$deep" ]; then
    gospider -s $url --other-source --include-subs --include-other-source --concurrent 50 --depth 5 --quiet | grep -aEo 'https?://[^ ]+' | sed 's/]$//' | anew $outputDir/tmp/gospider-urls.txt
  else 
    gospider -s $url --other-source --include-subs --include-other-source --concurrent 20 --quiet | grep -aEo 'https?://[^ ]+' | sed 's/]$//' | anew $outputDir/tmp/gospider-urls.txt
  fi
fi
cat $outputDir/tmp/gospider-urls.txt | anew -q $outputDir/tmp/urls.txt && clear 

#Hakrawler
echo -e "➼ ${YELLOW}Running ${BLUE}hakrawler${NC} on: ${GREEN}$url${NC}" && sleep 3s
if [ -n "$optionalHeaders" ]; then 
   if [ -n "$deep" ]; then
   echo $url | hakrawler -d 5 -insecure -t 50 -h "$optionalHeaders" | anew $outputDir/tmp/hak-urls.txt
  else
   echo $url | hakrawler -insecure -t 20 -h "$optionalHeaders" | anew $outputDir/tmp/hak-urls.txt
  fi
else
   if [ -n "$deep" ]; then
    echo $url | hakrawler -d 5 -insecure -t 50 | anew $outputDir/tmp/hak-urls.txt
  else 
   echo $url | hakrawler -insecure -t 20 | anew $outputDir/tmp/hak-urls.txt
  fi
fi 
cat $outputDir/tmp/hak-urls.txt | anew -q $outputDir/tmp/urls.txt && clear

#Katana
echo -e "➼ ${YELLOW}Running ${BLUE}Katana${NC} on: ${GREEN}$url${NC}" && sleep 3s
if [ -n "$optionalHeaders" ]; then 
   if [ -n "$deep" ]; then
    echo $url | katana -d 5 -H "$optionalHeaders" -o $outputDir/tmp/katana-urls.txt 
  else 
    echo $url | katana -H "$optionalHeaders" -o $outputDir/tmp/katana-urls.txt 
  fi
else
   if [ -n "$deep" ]; then
    echo $url | katana -d 5 -o $outputDir/tmp/katana-urls.txt 
  else
    echo $url | katana -o $outputDir/tmp/katana-urls.txt 
  fi
fi
cat $outputDir/tmp/katana-urls.txt | anew -q $outputDir/tmp/urls.txt && clear 

#Robots.txt
echo -e "➼ ${YELLOW}Finding all ${BLUE}robots.txt${NC} Endpoints on: ${GREEN}$url${NC}" 
roboxtractor -u $url -s -m 1 -wb -v | sort -u | awk '{print "/" $1}' | anew $outputDir/robots.txt

#XnLinkFinder
echo -e "➼ ${YELLOW}Running ${BLUE}xnLinkFinder${NC} on: ${GREEN}$url${NC}" && sleep 3s
if [ -n "$optionalHeaders" ]; then 
   if [ -n "$deep" ]; then
    python3 $HOME/Tools/xnLinkFinder/xnLinkFinder.py -i $url -H "$optionalHeaders" -sp $url -d 5 -sf .*$scope_domain -v -insecure -o $outputDir/tmp/xnl-urls.txt -op $outputDir/tmp/xnl-parameters.txt
  else
    python3 $HOME/Tools/xnLinkFinder/xnLinkFinder.py -i $url -H "$optionalHeaders" -sp $url -sf .*$scope_domain -v -insecure -o $outputDir/tmp/xnl-urls.txt -op $outputDir/tmp/xnl-parameters.txt
  fi
else
  if [ -n "$deep" ]; then
    python3 $HOME/Tools/xnLinkFinder/xnLinkFinder.py -i $url -sp $url -d 5 -sf .*$scope_domain -v -insecure -o $outputDir/tmp/xnl-urls.txt -op $outputDir/tmp/xnl-parameters.txt
  else
    python3 $HOME/Tools/xnLinkFinder/xnLinkFinder.py -i $url -sp $url -sf .*$scope_domain -v -insecure -o $outputDir/tmp/xnl-urls.txt -op $outputDir/tmp/xnl-parameters.txt
  fi
fi
cat $outputDir/tmp/xnl-urls.txt | anew $outputDir/tmp/urls.txt
cat $outputDir/tmp/xnl-parameters.txt | anew $outputDir/parameters.txt
clear 

#Waymore
echo -e "➼ Running Waymore on: ${GREEN}$url${NC}"
mkdir -p $outputDir/waymore/waymore-responses
cd $HOME/Tools/waymore && python3 $HOME/Tools/waymore/waymore.py --input $domain -xcc --output-urls $outputDir/waymore/waymore-urls.txt --output-responses $outputDir/waymore/waymore-responses --verbose --processes 5
mkdir -p /tmp/waymore/
cp -r $outputDir/waymore/waymore-responses /tmp/waymore/
cat $outputDir/waymore/waymore-urls.txt | anew $outputDir/tmp/urls.txt
#XnLinkfinder for Waymore
cd $HOME/Tools/xnLinkFinder && python3 $HOME/Tools/xnLinkFinder/xnLinkFinder.py -i /tmp/waymore/ --origin --output $outputDir/waymore/waymore-linkfinder.txt --output-params $outputDir/waymore/waymore-params.txt
cat $outputDir/waymore/waymore-linkfinder.txt | grep -aEo 'https?://[^ ]+' | sed 's/]$//' | anew $outputDir/tmp/urls.txt
cat $outputDir/waymore/waymore-params.txt | anew $outputDir/parameters.txt
cat $outputDir/waymore/waymore-linkfinder.txt | cut -d'[' -f1 |  scopeview -s $outputDir/.scope | anew $outputDir/endpoints.txt
#Remove nosise
rm -rf /tmp/waymore/
sed -i '/^waymore\|^tmp$\|^EN$\|^w3c$\|^http[s]\?$\|^DTD$/I d' $outputDir/waymore/waymore-params.txt

#Dedupe & Filter Scope
sort -u $outputDir/tmp/urls.txt -o $outputDir/tmp/urls.txt
if [ -n "$clean_urls" ]; then 
  echo -e "➼ Removing Junk URLs (urless): ${GREEN}$url${NC}"
  cd $HOME/Tools/urless && python3 $HOME/Tools/urless/urless.py --input $outputDir/tmp/urls.txt -o $outputDir/tmp/urless.txt
  echo "➼ Decluttering URLs (godeclutter): $url" 
  cat $outputDir/tmp/urls.txt | godeclutter | anew $outputDir/tmp/decluttered-urls.txt
  #merge and filter scope
  cat $outputDir/tmp/urless.txt $outputDir/tmp/decluttered-urls.txt | scopeview -s $outputDir/.scope | sort -u -o $outputDir/urls.txt
else
  cat $outputDir/tmp/urls.txt | scopeview -s $outputDir/.scope | sort -u -o $outputDir/urls.txt
fi

#JavaScript enum
#Get JS URLs
cat $outputDir/urls.txt | grep -aEi "\.(js|jsx|ts|vue|coffee|mjs|es|es6|jsxm|gs|litcoffee|map|svelte|tsx)([?#].*)?$" | anew $outputDir/js.txt
#Main Module
echo "➼ Downloading all JS files [fGET] $(mkdir -p $outputDir/jsfiles)"
cat $outputDir/js.txt | fget -o $outputDir/jsfiles --random-agent --verbose --workers 50
mv $outputDir/jsfiles/results/**/**/** $outputDir/jsfiles
#Beautify
echo -e "➼ ${YELLOW}Beautifying all ${BLUE}JS files [js-beautifier]${NC}"
js-beautify -r $outputDir/jsfiles/**/**/**/**/**/**.js
#XnLinkfinder for JS
echo "➼ Finding additional links & Paramas from JSfiles"
rm -rf /tmp/$domain-jsfiles 2>/dev/null
cp -r $outputDir/jsfiles /tmp/$domain-jsfiles
echo "➼ Finding Links & Params [xnLinkFinder]"
cd $HOME/Tools/xnLinkFinder && python3 $HOME/Tools/xnLinkFinder/xnLinkFinder.py -i /tmp/$domain-jsfiles --origin --output /tmp/$domain-jsfile-links.txt --output-params /tmp/$domain-jsfiles-params.txt
cp /tmp/$domain-jsfile-links.txt $outputDir/jsfile-links.txt && cp /tmp/$domain-jsfiles-params.txt $outputDir/jsfiles-params.txt
cat $outputDir/jsfile-links.txt | cut -d'[' -f1 | anew $outputDir/endpoints.txt
cat $outputDir/jsfile-links.txt | grep -aEo 'https?://[^ ]+' | sed 's/]$//' | anew $outputDir/tmp/urls.txt
cat $outputDir/jsfiles-params.txt | anew $outputDir/parameters.txt 
#Yataf for JS
rm -rf /tmp/yataf ; rm -rf $outputDir/Secrets/yataf
mkdir -p $outputDir/Secrets/yataf
path_to_directory="$outputDir/jsfiles/" ; log_directory="/tmp/yataf" ; mkdir -p "$log_directory"
find "$path_to_directory" -type f -exec sh -c 'yataf -file "$1" 2>&1 | sed -E '\''s/'$(echo -e "\033")'\[[0-9]{1,2}(;([0-9]{1,2})?)?[mK]//g'\'' | tee -a "$2/$(basename "$1").yataf.log"' _ {} "$log_directory" \;
# Copy Results and Filter
find "$log_directory" -type f -iname "*.yataf.log" -exec grep -q "\[i\] No results found" {} \; -delete
cp -r /tmp/yataf "$outputDir/Secrets/yataf" && clear

#Endpoints
cat $outputDir/urls.txt | sed '$!N; /^\(.*\)\n\1$/!P; D'| grep -P '\.(asp|aspx|bin|cfg|cfm|cgi|coffee|conf|cshtml|dll|eot|es|exe|go|gs|ini|java|js|jsa|jsp|jspx|jsx|jsxm|litcoffee|mjs|mvn|pl|php|ps1|py|rb|sh|sql|toml|ts|vue|wadl|wsdl|xml|yml|yaml|zsh)' | anew -q $outputDir/tmp/all-endpoint-urls.txt
cat $outputDir/tmp/all-endpoint-urls.txt | unfurl paths | sed 's#^/##' | sort -u -o $outputDir/endpoints.txt

#Secrets
  if [ -n "$scan_secrets" ]; then
    #Download Responses
    mkdir -p $outputDir/Secrets/fff-urls
    cat $outputDir/urls.txt | fff --header 'Authorization: Bearer null' --save-status 200 --save-status 405 --save-status 401 --save-status 403 -o $outputDir/Secrets/fff-urls
    #Extensive: gf-Secrets
     echo -e "${RED}Extensive Secret Scanning${NC} ${YELLOW}Initiated${NC}\n$(sleep 5s)"
     cd $outputDir && $HOME/Tools/gf-secrets/gf-secrets.sh | tee -a $outputDir/Secrets/gf-secrets.txt &
     pid=$!
         while true; do
          size=$(du -m $outputDir/Secrets/gf-secrets.txt | awk '{print $1}')
           if [ $size -gt 7000 ]; then
         kill $pid
         echo -e "${YELLOW}File size limit exceeded ${RED}7GBs${NC} ...\n ${BLUE}Exiting${NC}$(sleep 10s)"
         break
       fi
       sleep 1
       done
      #Trufflehog
       trufflehog filesystem --directory=$outputDir/ --concurrency 70 | tee -a $outputDir/Secrets/trufflehog.txt && clear
       else
       #Basic: gf-Secrets
        echo -e "${RED}Extensive Secret Scannig${NC} ${GREEN}Skipped${NC}\n$(sleep 5s)"
        echo -e "Performing ${YELLOW}light Scannig${NC} in ${RED}Backgroud${NC}\n Have some ${GREEN}Patience${NC}"        
        mkdir -p $outputDir/Secrets/fff-urls
        cat $outputDir/urls.txt | fff --header 'Authorization: Bearer null' --save-status 200 --save-status 405 --save-status 401 --save-status 403 -o $outputDir/Secrets/fff-urls
         #gf api-keys
         timeout 5m find $outputDir -type f -exec gf api-keys {} \; | tee -a $outputDir/Secrets/gf-api-keys.txt
         timeout 5m find $outputDir -type f -exec gf gf secrets {} \; | tee -a $outputDir/Secrets/gf-api-keys.txt
         ##find $outputDir -type f -exec gf api-keys {} \; | tee -a $outputDir/Secrets/gf-api-keys.txt &
          #  pid=$!
          #    while true; do
          #    size=$(du -m $outputDir/Secrets/gf-api-keys.txt | awk '{print $1}')
          #    if [ $size -gt 20 ]; then
          #    kill $pid
          #   echo -e "${YELLOW}File size limit exceeded ${RED}20MBs${NC} ...\n ${Blue}Exiting${NC}$(sleep 10s)"
          #   break
          #   fi
          #   sleep 1
          #   done
          #   #gf secrets
          #    find $outputDir -type f -exec gf secrets {} \; | tee -a $outputDir/Secrets/gf-secrets.txt &
          #      pid=$!
          #      while true; do
          #      size=$(du -m $outputDir/Secrets/gf-secrets.txt | awk '{print $1}')
          #      if [ $size -gt 20 ]; then
          #     kill $pid
          #    echo -e "${YELLOW}File size limit exceeded ${RED}20MBs${NC} ...\n ${Blue}Exiting${NC}$(sleep 10s)"
          #     break
          #   fi
          #  sleep 1
          #   done
        #Trufflehog
        trufflehog filesystem --directory=$outputDir/ --concurrency 70 | tee -a $outputDir/Secrets/trufflehog.txt && clear
        echo "" && clear
      fi

#Parameters
TMPPARAM=$(mktemp)
cat $outputDir/urls.txt | grep -Po '(?:\?|\&)(?<key>[\w]+)(?:\=|\&?)(?<value>[\w+,.-]*)' | tr -d '?' | tr -d '&' | sed 's/=.*//' | sort -u | uniq | anew -q $outputDir/parameters.txt
sort -u $outputDir/parameters.txt -o $outputDir/tmp/tmp-param.txt
cat $outputDir/tmp/tmp-param.txt | grep -v '%' | grep -v '/' | grep -v '_' | grep -v '-' | grep -v '+' | grep -E '.*[0-9].*[0-9].*' | tee "$TMPPARAM"
comm -23 <(sort $outputDir/tmp/tmp-param.txt) "$TMPPARAM" > $outputDir/tmp/tmp-parameters_filtered.txt
cat $outputDir/tmp/tmp-parameters_filtered.txt | grep -E '\b\w{10,}\b'| grep  '+' | anew -q $outputDir/tmp/ftmp-param.txt
comm -23 <(sort $outputDir/tmp/tmp-parameters_filtered.txt) $outputDir/tmp/ftmp-param.txt > $outputDir/tmp/ftmp-parameters_filtered.txt
mv $outputDir/tmp/ftmp-parameters_filtered.txt $outputDir/parameters.txt && rm -rf $outputDir/tmp/ftmp*.txt $outputDir/tmp/tmp*.txt 
sed -i '/^waymore\|^tmp$\|^EN$\|^w3c$\|^http[s]\?$\|^DTD$/I d' $outputDir/parameters.txt
#URLs with params
cd $HOME/Tools/urless && python3 $HOME/Tools/urless/urless.py --input $outputDir/urls.txt -o $outputDir/tmp/param-urless.txt && cd -
cat $outputDir/urls.txt | godeclutter | anew -q $outputDir/tmp/param-urless.txt   
cat $outputDir/tmp/param-urless.txt | grep -E 'https?://\S+/\S+\.\w+(\?\S+)?' | grep -vE 'https?://\S+/\S+\.js(\?[^[:space:]]*)?$' | sort -u -o $outputDir/tmp/param-urls.txt
#Arjun
if [ -n "$discover_params" ]; then
   cat $outputDir/parameters.txt | grep -E '^[[:alnum:]]+$' && cat $HOME/Tools/Arjun/arjun/db/small.txt | sort -u -o $outputDir/tmp/tmp-arjun-param.txt
   arjun -i $outputDir/tmp/param-urls.txt -w $outputDir/tmp/tmp-arjun-param.txt -c 250 -t 300 -oT $outputDir/parameters-arjun.txt
   rm $outputDir/tmp/tmp-arjun-param.txt 
else
  echo "Parameter Discovery Skipped$(sleep 5s)"
fi

#QOL Changes
find $outputDir -type f -size 0 -delete && find $outputDir -type d -empty -delete
find $outputDir -type f -name "*.txt" -not -name ".*" -exec sort -u {} -o {} \;  
echo ""
cd $originalDir && clear
echo -e "➼ All ${GREEN}Links${NC} Scraped and Saved in: ${BLUE}$outputDir${BLUE}"
echo ""
cd $outputDir
files=("$outputDir/endpoints.txt" "$outputDir/js.txt" "$outputDir/jsfile-links.txt" "$outputDir/jsfiles-params.txt" "$outputDir/parameters.txt" "$outputDir/robots.txt" "$outputDir/urls.txt" )
labels=("Endpoints" "JavaScript URLs" "JavaScript Links & Endpoints" "JavaScript Parameters" "Parameters" "Robots.TXT" "URLs")
for i in "${!files[@]}"; do
    if [ -f "${files[i]}" ]; then
        count=$(wc -l < "${files[i]}")
        echo -e "➼ Total ${YELLOW}${labels[i]}${NC} (${files[i]}) -->${BLUE} ${count// /}${NC}"
    else
        echo "➼ File ${files[i]} not found"
    fi
done
#Removes Temp
if [ -n "$clean_tmp" ]; then
rm -rf $outputDir/tmp 2>/dev/null
fi

#Check For Update on Script end
#Update. Github caches take several minutes to reflect globally  
   if ping -c 2 github.com > /dev/null; then
      REMOTE_FILE=$(mktemp)
      curl -s -H "Cache-Control: no-cache" https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/linky/linky.sh -o "$REMOTE_FILE"
         if ! diff --brief /usr/local/bin/linky "$REMOTE_FILE" >/dev/null 2>&1; then
              echo ""
              echo -e "➼ ${YELLOW}Update Found!${NC} ${BLUE}updating ..${NC} $(linky -up)" 
         else
            rm -f "$REMOTE_FILE" 2>/dev/null
              exit 0
         fi
   fi
#EOF