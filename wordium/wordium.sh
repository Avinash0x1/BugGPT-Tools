#!/usr/bin/zsh

#A bit of Styling
RED='\033[31m'
GREEN='\033[32m'
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
        ╭┳╮
╭┳┳┳━┳┳┳╯┣╋┳┳━━╮
┃W┃O┃R╭┫D┃I┃U┃M┃
╰━━┻━┻╯╰━┻┻━┻┻┻╯
EOF
echo -e "${NC}"
##Currently Tracking Wordlists:
# ~ >  70K --> https://github.com/reewardius/bbFuzzing.txt
# ~ >   5K --> https://github.com/Bo0oM/fuzz.txt
# ~ > 180K --> https://github.com/thehlopster/hfuzz
# ~ > 1.8K --> https://github.com/ayoubfathi/leaky-paths
# ~ > 760K --> https://github.com/six2dez/OneListForAll
# ~ > 1.1M --> https://github.com/rix4uni/WordList
##Optimal Goal
# x-mini.txt      --> ~ <  15K 
# x-lhf-mini.txt  --> ~ <  50K
# x-lhf-mid.txt   --> ~ < 100K
# x-lhf-large.txt --> ~ < 500K
# x-massive.txt   --> ~ <   2M

#Help / Usage
if [[ "$*" == *"-h"* ]] || [[ "$*" == *"--help"* ]] || [[ "$*" == *"help"* ]] ; then
  echo -e "${YELLOW}➼ Usage${NC}: ${PURPLE}wordium${NC} ${BLUE}-w${NC} ${GREEN}</path/to/your/wordlist/directory> ${NC}"
  echo ""
  echo -e "${YELLOW}Extended Help${NC}"
  echo -e "${BLUE}-w${NC},  ${BLUE}--wordlist-dir${NC}     Specify where to create your wordlists (${YELLOW}Required${NC}, else specify as ${GREEN}\$WORDLIST${NC} in ${RED}\$ENV:VAR)${NC}\n"
  echo -e "${BLUE}-up${NC}, ${BLUE}--update${NC}           ${GREEN}Update ${PURPLE}wordium${NC}\n"
  echo -e "${YELLOW}Example Usage${NC}: "
  echo -e "${PURPLE}wordium${NC} -w ${BLUE}/tmp/wordlists${NC}\n"  
  echo -e "➼ ${YELLOW}Don't Worry${NC} if your ${RED}Terminal Hangs${NC} for a bit.. It's a feature not a bug"
  exit 0
fi

# Update. Github caches take several minutes to reflect globally  
if [[ $# -gt 0 && ( "$*" == *"up"* || "$*" == *"-up"* || "$*" == *"update"* || "$*" == *"--update"* ) ]]; then
  echo -e "➼ ${YELLOW}Checking For ${BLUE}Updates${NC}"
      if ping -c 2 github.com > /dev/null; then
      REMOTE_FILE=$(mktemp)
      curl -s -H "Cache-Control: no-cache" https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/wordium/wordium.sh -o "$REMOTE_FILE"
         if ! diff --brief /usr/local/bin/wordium "$REMOTE_FILE" >/dev/null 2>&1; then
             echo -e "➼ ${YELLOW}NEW!! Update Found! ${BLUE}Updating ..${NC}" 
             dos2unix $REMOTE_FILE > /dev/null 2>&1 
             sudo mv "$REMOTE_FILE" /usr/local/bin/wordium && echo -e "➼ ${GREEN}Updated${NC} to ${BLUE}@latest${NC}\n" 
             echo -e "➼ ${YELLOW}ChangeLog:${NC} ${PINK}$(curl -s https://api.github.com/repos/Azathothas/BugGPT-Tools/commits?path=wordium/wordium.sh | jq -r '.[0].commit.message')${NC}"
             echo -e "${YELLOW}Pushed at${NC}: ${BLUE}$(curl -s https://api.github.com/repos/Azathothas/BugGPT-Tools/commits?path=wordium/wordium.sh | jq -r '.[0].commit.author.date')${NC}\n"
             sudo chmod +xwr /usr/local/bin/wordium
             rm -f "$REMOTE_FILE" 2>/dev/null
             else
             echo -e "➼ ${YELLOW}Already ${BLUE}UptoDate${NC}"
             echo -e "➼ Most ${YELLOW}recent change${NC} was on: ${BLUE}$(curl -s https://api.github.com/repos/Azathothas/BugGPT-Tools/commits?path=wordium/wordium.sh | jq -r '.[0].commit.author.date')${NC} [${PINK}$(curl -s https://api.github.com/repos/Azathothas/BugGPT-Tools/commits?path=wordium/wordium.sh | jq -r '.[0].commit.message')${NC}]\n"             
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

# Accepts wildcard options ( -w*)
while getopts ":w:-:" opt; do
  case $opt in
    w ) WORDLIST="$OPTARG" ;;
    - ) case "${OPTARG}" in
          wordlist-dir=* ) WORDLIST="${OPTARG#*=}" ;;
        esac;;
    : ) echo -e "${RED}Option ${BLUE}-$OPTARG${NC} requires you specify your ${BLUE}Wordlists directory${NC}" >&2; exit 1 ;;
    \? ) echo -e "${RED}Invalid option: -$OPTARG${NC} , use ${BLUE}-w${NC} or ${BLUE}--wordlist-dir${NC}" >&2; exit 1 ;;
  esac
done
# Check if WORDLIST is already set in the environment
if [ -z "$WORDLIST" ]; then
  echo -e "Path for ${BLUE}WORDLIST${NC} is ${RED}not set in the environment or specified as an option.${NC}" >&2
  echo -e "➼ Will choose ${BLUE}$HOME/Wordlist${NC} as default directory"
  echo -e "➼ ${YELLOW}If You don't want that, hit ${RED}ctrl + c${NC} now!"
  echo -e "➼ ${YELLOW}Waiting 10 Seconds${NC} ${GREEJ}before continuing${NC} in ${BLUE}$HOME/Wordlist${NC}" && sleep 15s
  mkdir -p $HOME/Wordlist
  export WORDLIST=$HOME/Wordlist 
  cd "$WORDLIST"
else
  echo -e "➼ ${YELLOW}Specified Wordlist Directory${NC}: ${BLUE}$(echo $WORDLIST)${NC}\n" && sleep 5s
  mkdir -p $WORDLIST && cd $WORDLIST
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
#anew
if ! command -v anew &> /dev/null; then
   echo "➼ anew is not installed. Installing..." 
   go install -v github.com/tomnomnom/anew@latest
fi
#dos2unix, for updates
if ! command -v dos2unix >/dev/null 2>&1; then
    echo "➼ dos2unix is not installed. Installing..."
    sudo apt-get update && sudo apt-get install dos2unix -y
fi
##Check if it's a git dir
dir_to_check="$(pwd)"
# Set the maximum number of parent directories to check
max_parents=2
# Initialize a counter variable
count=0
# Check if the directory or its parent directories have a .git folder
while [[ "$dir_to_check" != "/" ]]; do
  if [[ -d "$dir_to_check/.git" ]]; then
    echo -e "Git ${YELLOW}(.git)${NC} detected in ${YELLOW}$dir_to_check${NC}"
    echo -e "Proceeding with ${BLUE}Submodules${NC}"
    echo -e "${YELLOW}This will take quite some time${NC} (If first run)" 
    echo -e "Depending on your ${YELLOW}internet${NC}, it ${RED}may take upto 1 hr${NC}" 
    echo -e "${BLUE}Just let your terminal be!${NC}"  
    git config --global --add safe.directory $(pwd)
    #Rood's base for lhf wordlists
    wget --quiet https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/misc/wordlists/rood-lhf.txt -O /tmp/wordium-rood-lhf.txt
    cat /tmp/wordium-rood-lhf.txt | anew -q $WORDLIST/x-lhf-mini.txt
    #Submodules
    git submodule add https://github.com/reewardius/bbFuzzing.txt 2>/dev/null
    git submodule add https://github.com/Bo0oM/fuzz.txt 2>/dev/null
    git submodule add https://github.com/thehlopster/hfuzz 2>/dev/null
    git submodule add https://github.com/ayoubfathi/leaky-paths 2>/dev/null
    git submodule add https://github.com/six2dez/OneListForAll 2>/dev/null
    git submodule add https://github.com/rix4uni/WordList 2>/dev/null
    #Clones
    git clone https://github.com/reewardius/bbFuzzing.txt 2>/dev/null
    git clone https://github.com/Bo0oM/fuzz.txt 2>/dev/null
    git clone https://github.com/thehlopster/hfuzz 2>/dev/null
    git clone https://github.com/ayoubfathi/leaky-paths 2>/dev/null
    git clone https://github.com/six2dez/OneListForAll 2>/dev/null
    git clone https://github.com/rix4uni/WordList 2>/dev/null
    #Mark Safe
    find $dir_to_check -type d -name '.git' -exec sh -c 'cd "$(dirname "{}")" && git config --global --add safe.directory "$(pwd)"' \; 
    break
  fi
  dir_to_check=$(dirname "$dir_to_check")
  count=$((count+1))
  if [[ $count -eq $max_parents ]]; then
    echo -e "No Git ${YELLOW}(.git)${NC} folder found in $dir_to_check or its parent directories!"
    echo -e "Proceeding with ${BLUE}git clone${NC}\n"
    echo -e "${YELLOW}This will take quite some time${NC} (If first run)" 
    echo -e "Depending on your ${YELLOW}internet${NC}, it ${RED}may take upto 1 hr${NC}" 
    echo -e "${BLUE}Just let your terminal be!${NC}" 
    #Rood's base for lhf wordlists
    wget --quiet https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/misc/wordlists/rood-lhf.txt -O /tmp/rood-lhf.txt
    cat /tmp/rood-lhf.txt | anew -q $WORDLIST/x-lhf-mini.txt
    git clone https://github.com/reewardius/bbFuzzing.txt 2>/dev/null
    git clone https://github.com/Bo0oM/fuzz.txt 2>/dev/null
    git clone https://github.com/thehlopster/hfuzz 2>/dev/null
    git clone https://github.com/ayoubfathi/leaky-paths 2>/dev/null
    git clone https://github.com/six2dez/OneListForAll 2>/dev/null
    git clone https://github.com/rix4uni/WordList 2>/dev/null 
    break
  fi
done
#Sync Repos to @latest
find $WORDLIST -maxdepth 1 -type d -exec sh -c '(cd {} && [ -d .git ] && echo "Updating {} to @latest" && git pull)' \;
#Begins
#echo -e "➼${YELLOW}Fetching & Updating${NC} from ${BLUE}WORDLIST/WORDLIST${NC} \n" 
#echo -e "➼ ${BLUE}x-lhf-mini.txt${NC}  : $()${NC}" 
##Prints anything with . (dot)
#grep -E '^\.' file.txt
## Removes lines with digits, and removes slashes from beginning of each line 
#sed '/[0-9]/d' file.txt | sed '/^[[:space:]]*$/d' | sed 's#^/##'
#ENV VARS
echo "test" | anew -q $WORDLIST/x-lhf-mini.txt
lhf_mini_lines=$(wc -l < $WORDLIST/x-lhf-mini.txt)
## --> Bo0oM/fuzz.txt
echo ""
echo -e "➼ ${YELLOW}Fetching & Updating${NC} from ${BLUE}Bo0oM/fuzz.txt${NC}" 
echo -e "➼ ${BLUE}x-lhf-mini.txt${NC}  : ${GREEN}$(grep -E '^\.' $WORDLIST/fuzz.txt/fuzz.txt | anew $WORDLIST/x-lhf-mini.txt | wc -l)${NC}" 
echo -e "➼ ${BLUE}x-lhf-mid.txt${NC}  : ${GREEN}$(cat $WORDLIST/fuzz.txt/fuzz.txt | anew $WORDLIST/x-lhf-mid.txt | wc -l)${NC}\n" 

## --> reewardius/bbFuzzing.txt
echo -e "➼ ${YELLOW}Fetching & Updating${NC} from ${BLUE}reewardius/bbFuzzing.txt${NC}"
echo -e "➼ ${BLUE}x-lhf-mini.txt${NC}  : ${GREEN}$(grep -E '^\.' $WORDLIST/bbFuzzing.txt/bbFuzzing.txt | anew $WORDLIST/x-lhf-mini.txt | wc -l)${NC}" 
echo -e "➼ ${BLUE}x-lhf-mid.txt ${NC}  : ${GREEN}$(cat $WORDLIST/bbFuzzing.txt/bbFuzzing.txt | grep -Ei 'api|build|conf|dev|env|git|graph|helm|json|kube|k8|sql|swagger|xml|yaml|yml|wadl|wsdl' | anew $WORDLIST/x-lhf-mid.txt | wc -l)${NC}" 
echo -e "➼ ${BLUE}x-lhf-large.txt${NC}  : ${GREEN}$(cat $WORDLIST/bbFuzzing.txt/bbFuzzing.txt | anew $WORDLIST/x-lhf-large.txt | wc -l)${NC}\n" 

## --> thehlopster/hfuzz
echo -e "➼ ${YELLOW}Fetching & Updating${NC} from ${BLUE}thehlopster/hfuzz${NC}" 
echo -e "➼ ${BLUE}x-lhf-mini.txt${NC}  : ${GREEN}$(grep -E '^\.' $WORDLIST/hfuzz/hfuzz.txt | anew $WORDLIST/x-lhf-mini.txt | wc -l)${NC}" 
echo -e "➼ ${BLUE}x-lhf-large.tx${NC}  : ${GREEN}$(sed '/[0-9]/d' $WORDLIST/hfuzz/hfuzz.txt | sed '/^[[:space:]]*$/d' | sed 's#^/##' |  grep -Ei 'api|build|conf|dev|env|git|graph|helm|json|kube|k8|sql|swagger|xml|yaml|yml|wadl|wsdl' | anew $WORDLIST/x-lhf-large.txt | wc -l)${NC}\n" 

## --> ayoubfathi/leaky-paths
echo -e "➼ ${YELLOW}Fetching & Updating${NC} from ${BLUE}ayoubfathi/leaky-paths${NC}" 
echo -e "➼ ${BLUE}x-lhf-mini.txt${NC}  : ${GREEN}$(sed '/[0-9]/d' $WORDLIST/leaky-paths/leaky-paths.txt | sed '/^[[:space:]]*$/d' | anew $WORDLIST/x-lhf-mini.txt | wc -l)${NC}\n" 

## --> Six2dez/OneListForAll
echo -e "➼ ${YELLOW}Fetching & Updating${NC} from ${BLUE}Six2dez/OneListForAll${NC}" 
echo -e "➼ ${BLUE}x-lhf-mini.txt${NC}  : ${GREEN}$(grep -E '^\.' $WORDLIST/OneListForAll/onelistforallmicro.txt | anew $WORDLIST/x-lhf-mini.txt | wc -l)${NC}" 
echo -e "➼ ${BLUE}x-lhf-large.txt${NC}  : ${GREEN}$(cat $WORDLIST/OneListForAll/onelistforallshort.txt | grep -Ei 'api|build|conf|dev|env|git|graph|helm|json|kube|k8|sql|swagger|xml|yaml|yml|wadl|wsdl' | anew $WORDLIST/x-lhf-large.txt | wc -l)${NC}" 
echo -e "➼ ${BLUE}x-massive.txt${NC}  : ${GREEN}$(cat $WORDLIST/OneListForAll/onelistforallshort.txt | anew $WORDLIST/x-massive.txt | wc -l)${NC}\n" 

## --> rix4uni/WordList
echo -e "➼ ${YELLOW}Fetching & Updating${NC} from ${BLUE}rix4uni/WordList${NC}" 
echo -e "➼ ${BLUE}x-lhf-mini.txt${NC}  : ${GREEN}$(grep -E '^\.' $WORDLIST/WordList/onelistforall.txt | anew $WORDLIST/x-lhf-mini.txt | wc -l) , $(grep -E '^\.' $WORDLIST/WordList/onelistforshort.txt | anew $WORDLIST/x-lhf-mini.txt | wc -l)${NC}" 
echo -e "➼ ${BLUE}x-lhf-mid.txt${NC}  : ${GREEN}$(cat $WORDLIST/WordList/admin-panel-paths.txt | anew $WORDLIST/x-lhf-mid.txt | wc -l)${NC}" 
echo -e "➼ ${BLUE}x-lhf-large.txt${NC}  : ${GREEN}$(cat $WORDLIST/WordList/onelistforshort.txt | sed 's#^/##' | anew $WORDLIST/x-lhf-large.txt | wc -l)${NC}" 
echo -e "➼ ${BLUE}x-massive.txt${NC}  : ${GREEN}$(sed '/[0-9]/d' $WORDLIST/WordList/onelistforall.txt | sed '/^[[:space:]]*$/d' | sed 's#^/##' |  grep -Ei 'api|build|conf|dev|env|git|graph|helm|json|kube|k8|sql|swagger|xml|yaml|yml|wadl|wsdl' | anew $WORDLIST/x-massive.txt | wc -l)${NC}\n" 

#Anew & CleanUP
echo -e "➼ ${YELLOW}New Additions${NC} "
echo -e "➼ ${BLUE}x-lhf-mini.txt${NC}  : ${GREEN}$(($(wc -l < x-lhf-mini.txt) - $lhf_mini_lines))${NC}" 
echo -e "➼ ${BLUE}x-lhf-mid.txt${NC}   : ${GREEN}$(cat $WORDLIST/x-lhf-mini.txt | anew $WORDLIST/x-lhf-mid.txt | wc -l)${NC}" 
echo -e "➼ ${BLUE}x-lhf-large.txt${NC} : ${GREEN}$(cat $WORDLIST/x-lhf-mid.txt | anew $WORDLIST/x-lhf-large.txt | wc -l)${NC}" 
echo -e "➼ ${BLUE}x-massive.txt${NC}   : ${GREEN}$(cat $WORDLIST/x-lhf-large.txt | anew $WORDLIST/x-massive.txt | wc -l)${NC}\n" 
#Sort -u -o everything 
find $WORDLIST -maxdepth 1 -type f -name "*.txt" -not -name ".*" -exec sort -u {} -o {} \;  

echo -e "➼ ${YELLOW}Generating ${BLUE}x-mini.txt${NC} " 
#Prefetch base for x-mini.txt
wget --quiet "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/misc/wordlists/fuzz-mini.txt" -O /tmp/wordium-mini.txt
cat $WORDLIST/fuzz.txt/fuzz.txt $WORDLIST/leaky-paths/leaky-paths.txt | sed 's#^/##' | anew -q /tmp/wordium-mini.txt
grep -E '^\.' $WORDLIST/x-lhf-large.txt | anew -q /tmp/wordium-mini.txt
sort -u /tmp/wordium-mini.txt -o /tmp/wordium-mini.txt 
echo -e "➼ ${YELLOW}Newly added${NC}: ${GREEN}$(cat /tmp/wordium-mini.txt | anew $WORDLIST/x-mini.txt | wc -l)${NC}\n"

#WordCount After each run:
echo -e "➼${YELLOW}Updated Wordlists${NC}:" 
echo -e "➼ ${BLUE}x-mini.txt${NC}      : ${GREEN}$(wc -l $WORDLIST/x-mini.txt)${NC}" 
echo -e "➼ ${BLUE}x-lhf-mini.txt${NC}  : ${GREEN}$(wc -l $WORDLIST/x-lhf-mini.txt)${NC}" 
echo -e "➼ ${BLUE}x-lhf-mid.txt${NC}   : ${GREEN}$(wc -l $WORDLIST/x-lhf-mid.txt)${NC}" 
echo -e "➼ ${BLUE}x-lhf-large.txt${NC} : ${GREEN}$(wc -l $WORDLIST/x-lhf-large.txt)${NC}"
echo -e "➼ ${BLUE}x-massive.txt${NC}   : ${GREEN}$(wc -l $WORDLIST/x-massive.txt)${NC}\n" 

#Check For Update on Script end
#Update. Github caches take several minutes to reflect globally  
   if ping -c 2 github.com > /dev/null; then
      REMOTE_FILE=$(mktemp)
      curl -s -H "Cache-Control: no-cache" https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/wordium/wordium.sh -o "$REMOTE_FILE"
         if ! diff --brief /usr/local/bin/wordium "$REMOTE_FILE" >/dev/null 2>&1; then
              echo ""
              echo -e "➼ ${YELLOW}Update Found!${NC} ${BLUE}updating ..${NC} $(wordium -up)" 
         else
            rm -f "$REMOTE_FILE" 2>/dev/null
              exit 0
         fi
   fi
#EOF