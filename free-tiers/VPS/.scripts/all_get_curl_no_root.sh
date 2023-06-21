#!/usr/bin/env bash

#----------------------------------------------------------------------#
#Sanity Checks
#If curl already installed
if command -v curl >/dev/null 2>&1; then
   echo -e "\nW: curl is already installed at: $(which curl)"
   echo -e "W: Why so eager to fix smth that's not broken ?\n"
   echo -e "Further Steps: https://github.com/Azathothas/BugGPT-Tools/tree/main/free-tiers/VPS/.binaries\n"
  exit 1
fi  
#If invoked as root
if [ "$EUID" -eq 0 ]; then
   echo -e "\nW: This is mean to be run wthout ROOT"
   echo -e "W: Running anyway may mess up all your dirs & settings"
   echo -e "W: Will also probably fail"
   echo -e "W: Hit (ctrl + c) if this was a mistake"
   echo -e "W: Script will run anyway within 15s...\n"
   sleep 15s
fi   
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
#Get Sys Info
echo -e "\n----\nGetting System Information......\n----\n"
#Pure bash neofetch
echo -e "\n--------------------------------------------\nHostname: $(hostname)\nUser: $(whoami) $([ "$EUID" -ne 0 ] && echo '(NOT root)' || echo '(root)')\nSudo: $(command -v sudo >/dev/null 2>&1 && echo 'Installed' || echo 'Not Installed/Available')\nUptime: $(uptime -p 2>/dev/null || uptime | awk '{sub(/,$/, "", $3); print $3}')\nOS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | sed 's/"//g') ($(cat /etc/os-release | grep ID_LIKE | cut -d= -f2 | sed 's/"//g'))\nArchitecture: $(uname -m)\nKernel: $(uname -r)\nPackage Manager: $(cmds=$(for cmd in apk apt brew conda dnf emerge eopkg flatpak guix installer nix pacman pacman4 pisi pkg pkgutil port snap swupd tdnf xbps yum zypper; do command -v "$cmd" >/dev/null && printf "%s," "$cmd"; done) ; echo "${cmds%,}")\nSystem: $(ps -p 1 -o comm=)\nShell: $(echo "$SHELL")\nCPU: $(grep -c ^processor /proc/cpuinfo) x $(grep -m1 "model name" /proc/cpuinfo | cut -d: -f2 ) @ $(grep -m1 "cpu MHz" /proc/cpuinfo | cut -d: -f2 | tr -d '[:space:]') MHz\nRAM: $(free -h | awk '/^Mem:/ {print $3 "/" $2}')\nDisk: $(df -h 2>/dev/null | awk '/^\/dev\// {if (line) line = line " | "; line = line $1"("$6")" " " $3 "/" $2 " (" $5 " used)"} END {print line}')\nIPv4: $(curl -qfsSL "http://ipv4.whatismyip.akamai.com" 2>/dev/null || echo 'Failed, Maybe no Curl?')\nIPv6: $(curl -qfsSL --ipv6 "http://ipv6.whatismyip.akamai.com" 2>/dev/null || echo 'Failed to Connect')\nCurl: $(command -v curl >/dev/null 2>&1 && which curl || echo '(Not Installed)')\nWget: $(command -v wget >/dev/null 2>&1 && which wget || echo '(Not Installed)')\nGoLang: $(command -v go >/dev/null 2>&1 && go version || echo '(Not Installed)')\nPython(pip): $(command -v pip >/dev/null 2>&1 && pip -V || echo '(Not Installed, maybe try pip3)')\nRust(Cargo): $(command -v cargo >/dev/null 2>&1 && cargo -V || echo '(Not Installed)')\n--------------------------------------------\n\n"
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
#Export Arch
arch=$(uname -m) && export arch="$arch"
  if [[ "$arch" == *86* ]]; then
     curl_dl="https://github.com/moparisthebest/static-curl/releases/download/v8.0.1/curl-i386" && export curl_dl="$curl_dl"
  elif [[ "$arch" == *amd* ]]; then
     curl_dl="https://github.com/moparisthebest/static-curl/releases/download/v8.0.1/curl-amd64" && export curl_dl="$curl_dl"
  elif [[ "$arch" == *aarch* ]]; then
     curl_dl="https://github.com/moparisthebest/static-curl/releases/latest/download/curl-aarch64" && export curl_dl="$curl_dl" 
  elif [[ "$arch" == *arm64* ]]; then
     curl_dl="https://github.com/moparisthebest/static-curl/releases/latest/download/curl-aarch64" && export curl_dl="$curl_dl" 
  elif [[ "$arch" == *v7* ]]; then
     curl_dl="https://github.com/moparisthebest/static-curl/releases/latest/download/curl-armv7" && export curl_dl="$curl_dl"
  elif [[ "$arch" == *hf* ]]; then   
     curl_dl="https://github.com/moparisthebest/static-curl/releases/latest/download/curl-armhf" && export curl_dl="$curl_dl"
  elif [[ "$arch" == *ppc* ]]; then     
     curl_dl="https://github.com/moparisthebest/static-curl/releases/latest/download/curl-ppc64le" && export curl_dl="$curl_dl"
  fi  
#----------------------------------------------------------------------#
#Deps
#-----#
mkdir -p $HOME/bin
#curl
if ! command -v curl >/dev/null 2>&1; then
 echo -e "\n----\n Curl not found (X)......\n----\n"
  if ! command -v wget >/dev/null 2>&1; then
   echo -e "\n----\n wget not found (X)......\n----\n"   
    if ! command -v pip >/dev/null 2>&1; then 
     echo -e "\n----\n pip (Python) not found (X)......\n----\n"    
      if ! command -v pip3 >/dev/null 2>&1; then 
       echo -e "\n----\n pip3 (Python3) not found (X)......\n----\n"      
        if ! command -v go >/dev/null 2>&1; then 
         echo -e "\n----\n go (Golang) not found (X)......\n----\n"
          if ! command -v node >/dev/null 2>&1; then 
           echo -e "\n----\n node (JavaScript) not found (X)......\n----\n"
            if ! command -v php >/dev/null 2>&1; then 
             echo -e "\n----\n php not found (X)......\n----\n"
              if ! command -v cargo >/dev/null 2>&1; then 
               echo -e "\n----\n cargo (Rust) not found (X)......\n----\n"
                  if [ "$EUID" -eq 0 ]; then
                       echo -e "\nWe do have root access, so not all hope is lost"
                       echo -e "Read more at: \nhttps://github.com/Azathothas/BugGPT-Tools/tree/main/free-tiers/VPS/.binaries#scenarios-"
                  else   
                       echo -e "Fatal: No root & No Third Party Deps to sideload curl\n"
                       echo -e "I : There may still be a way (Example if you can control VM at runtime)"
                       echo -e "I : If nthg works, create an Issue: \nhttps://github.com/Azathothas/BugGPT-Tools/issues/new"
                       echo -e "I : Do mention your OS & Environment Details\n"
                       echo -e "Read: \nhttps://github.com/Azathothas/BugGPT-Tools/tree/main/free-tiers/VPS/.binaries\n"
                       exit 1
                  fi     
              fi
            fi
          fi         
        fi
      fi
    fi 
  fi    
else
  #Try downloading with wget
   if command -v wget >/dev/null 2>&1; then
     echo -e "\n-----------------\nDownloading Curl for arch : $arch [wget]\n-----------------\n"
       wget "$curl_dl" -O $HOME/bin/curl && chmod +xwr $HOME/bin/curl
  #Try with pip
   elif command -v pip >/dev/null 2>&1; then
    echo -e "\n-----------------\nDownloading httpie for arch : $arch [pip]\n-----------------\n"
       pip install httpie 2>/dev/null
         if command -v httpie >/dev/null 2>&1; then
           echo -e "\n-----------------\nDownloading Curl for arch : $arch [httpie]\n-----------------\n"
             http --download "$curl_dl" --follow -o "$HOME/bin/curl" && chmod +xwr $HOME/bin/curl
         fi
  #Try with pip3       
   elif command -v pip3 >/dev/null 2>&1; then  
     echo -e "\n-----------------\nDownloading httpie for arch : $arch [pip3]\n-----------------\n"
       pip3 install httpie 2>/dev/null
         if command -v httpie >/dev/null 2>&1; then
           echo -e "\n-----------------\nDownloading Curl for arch : $arch [httpie]\n-----------------\n"
             http --download "$curl_dl" --follow -o "$HOME/bin/curl" && chmod +xwr $HOME/bin/curl            
         fi
  #Try with golang
   elif command -v go >/dev/null 2>&1; then  
     echo -e "\n-----------------\nDownloading eget for arch : $arch [go install]\n-----------------\n"     
       go install -v github.com/zyedidia/eget@latest
         if command -v eget >/dev/null 2>&1; then
           echo -e "\n-----------------\nDownloading Curl for arch : $arch [eget]\n-----------------\n"         
             eget "$curl_dl" --to $HOME/bin/curl && chmod +xwr $HOME/bin/curl
         fi
  #Try with npm/node
    elif command -v cargo >/dev/null 2>&1; then
     echo -e "\n-----------------\nDownloading Curl for arch : $arch [node-js]\n-----------------\n"     
       node -e 'const https = require("https"); const fs = require("fs"); const url = process.env.curl_dl; const file = fs.createWriteStream("curl"); const followRedirects = require("follow-redirects"); followRedirects.maxBodyLength = 10 * 1024 * 1024; const { https: httpsWithRedirects } = followRedirects; httpsWithRedirects.get(url, (response) => { console.log("Response status code:", response.statusCode); console.log("Content type:", response.headers["content-type"]); response.pipe(file); file.on("finish", () => { console.log("Download completed"); file.close(); }); }).on("error", (err) => { console.error("Error occurred during download:", err); });'
       mv ./curl $HOME/bin/curl && chmod +x $HOME/bin/curl         
  #Try with php
    elif command -v php >/dev/null 2>&1; then
     echo -e "\n-----------------\nDownloading Curl for arch : $arch [php]\n-----------------\n"     
         php -r '$curl_dl = getenv("curl_dl");if ($curl_dl) {$ch = curl_init($curl_dl);curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);$response = curl_exec($ch);curl_close($ch);if ($response !== false) {file_put_contents("curl", $response);echo "File downloaded successfully as: curl\n";} else {echo "Error downloading file.\n";}} else {echo "Environment variable \$curl_dl not set.\n";}'
         mv ./curl $HOME/bin/curl && chmod +x $HOME/bin/curl
  #Try with rust
    elif command -v cargo >/dev/null 2>&1; then
     echo -e "\n-----------------\nDownloading Curl for arch : $arch [rust-xh]\n-----------------\n"     
          cargo install --git "https://github.com/ducaale/xh"
            if command -v xh >/dev/null 2>&1; then
                xh -d "$curl_dl" -o $HOME/bin/curl && chmod +xwr $HOME/bin/curl
            fi
    fi
fi    
#End    
echo -e "\n==================================\n Installing Curl....\n" && sleep 10s
if ! command -v curl >/dev/null 2>&1; then    
     echo -e "All methods Failed....\n"
     echo -e "Further Instructions: https://github.com/Azathothas/BugGPT-Tools/tree/main/free-tiers/VPS/.binaries\n"
  exit 1
else
   if command -v curl >/dev/null 2>&1; then 
      Clear && echo -e "\n-----------------\nSuccessfully Installed curl at $(which curl)\n-----------------\n"    
      curl -h
   fi
fi
#----------------------------------------------------------------------#
#EOF
