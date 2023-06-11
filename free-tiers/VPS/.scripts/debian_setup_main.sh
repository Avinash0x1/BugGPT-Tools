#!/usr/bin/env bash

#-------------------------------------------------------------------------#
#Debian, with user & root separated, script run as user with passwordless sudo
#-------------------------------------------------------------------------#
export DEBIAN_FRONTEND=noninteractive

export origin=$(pwd)
#Mk Dirs
mkdir -p "$HOME"/{.config,Tools,tmp} >/dev/null 2>&1
    #-------------------------------------------------------------------------#
      #Fetch & Import Parrot Sources
        curl -qfsSL "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/free-tiers/VPS/.scripts/debian_add_parrot_sources.list.sh" | sudo bash 
         #Clean & Update
         sudo apt-get clean -y && sudo apt-get update
    #-------------------------------------------------------------------------#
    #aptitude clean cacheW
         sudo DEBIAN_FRONTEND=noninteractive sudo apt-get update -y && sudo apt-get install aptitude -y
         sudo DEBIAN_FRONTEND=noninteractive sudo apt-get update -y
         sudo DEBIAN_FRONTEND=noninteractive sudo aptitude clean -y && sudo aptitude autoclean -y && clear
         sudo DEBIAN_FRONTEND=noninteractive sudo apt autoremove -y
    #-------------------------------------------------------------------------#
    #Core + misc apt Tools
         sudo apt-get update && sudo apt-get install aptitude dialog -y
         clear && echo -e "➼${GREEN} Initializing ${PURPLE}Core${NC} Dependencies${NC}\n"
         #Using aptitude resolve some deps
          sudo DEBIAN_FRONTEND=noninteractive sudo aptitude install default-jre-headless -y && sudo apt-get install node-cacache -y
         #npm needs to be installed Interactively: sudo aptitude install npm
        #Main 
         sudo DEBIAN_FRONTEND=noninteractive sudo apt-get install apt-transport-https autoconf awscli build-essential bzip2 ca-certificates ccze chromium-browser colordiff composer cron curl dconf-cli dkms dnsutils dos2unix doxygen freeglut3-dev gawk git gnupg-agent gunicorn htop iputils-ping iputils-arping iputils-clockdiff iputils-tracepath inotify-tools java-common joe jq locate lzma make massdns mesa-common-dev mesa-utils moreutils nano net-tools nikto nim nmap nodejs openssh-client openssh-server perl php php-cli pkg-config pv postgresql-all psmisc python3-bz2file python3-openssl python3-venv readline-common ruby software-properties-common sqlite3 sqlmap ssh ssh-tools sudo tig tk tk-dev unzip uuid-runtime wfuzz wget whiptail xclip xsltproc xz-utils zip zlib1g-dev -y --ignore-missing
        #Fix Broken
         sudo DEBIAN_FRONTEND=noninteractive sudo dpkg --configure -a 
         sudo DEBIAN_FRONTEND=noninteractive sudo sudo apt --fix-broken install -y
         sudo DEBIAN_FRONTEND=noninteractive sudo apt autoremove -y
        #UpdateDB using locate
         #Configure ssh
         #Already pre runs a tailscale instance for ssh
         #sudo service ssh start
          sudo DEBIAN_FRONTEND=noninteractive sudo updatedb --prunepaths=/media 2>/dev/null
    #Install zsh, for ~/.zshrc
         sudo DEBIAN_FRONTEND=noninteractive sudo apt-get install zsh zsh-syntax-highlighting zsh-autosuggestions -y
       #fzf  
         sudo eget sharkdp/fd --asset gnu --to /usr/local/bin/fdfind && sudo chmod +xwr /usr/local/bin/fdfind
         sudo eget sharkdp/bat --asset gnu --to /usr/local/bin/batcat && sudo chmod +xwr /usr/local/bin/batcat
       #Install fzf
         if [ ! -d "$HOME/.fzf" ]; then
           git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf >/dev/null 2>&1
           ~/.fzf/install --all >/dev/null 2>&1
         fi  
       # Setup fzf
       # fzf is auto setup from ~/.zshrc
       # Install nerdfonts
        cd $(mktemp -d) && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/FiraCode.zip && sudo unzip FiraCode.zip -d /usr/share/fonts && sudo fc-cache -f -v && clear
        cd -
       # Install Starship
         curl -sS https://starship.rs/install.sh | sudo sh -s -- -y >/dev/null 2>&1
       #Install tmux
        sudo DEBIAN_FRONTEND=noninteractive sudo apt-get install tmux -y
       #Install plugins
       #Tmux Plugins
        if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
           mkdir -p "$HOME/.tmux"
           git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm >/dev/null 2>&1
        fi
    #-------------------------------------------------------------------------#
    #Docker
      #Colab runs inside a docker container without --privileged
      #It's not possible to run docker (even rootless) unless parent is `--privileged`
      #Ref: https://github.com/rootless-containers/rootlesskit/issues/181
    #-------------------------------------------------------------------------#
    #GoLang  
        echo -e "➼ ${GREEN}Installing${NC} || ${BLUE}Updating ${PURPLE}golang${NC}..."
        cd $(mktemp -d) && git clone https://github.com/udhos/update-golang  && cd ./update-golang && sudo ./update-golang.sh
        cd -
        source /etc/profile.d/golang_path.sh
        sudo su -c "source /etc/profile.d/golang_path.sh"
        sudo su -c "bash <(curl -sL https://git.io/go-installer)"
        #Eget for binaries
        go install -v github.com/zyedidia/eget@latest
        sudo su -c "go install -v github.com/zyedidia/eget@latest >/dev/null"
    #-------------------------------------------------------------------------#
    #Python3: Pip+pipx+pyenv
         sudo apt-get update -y
         sudo aptitude install python3 python3-pip python3-aiohttp python3-certbot-apache python3-requests python3-matplotlib python3-keras python3-opencv python3-django python3-flask -y && clear
    #python3_pipx
         python3 -m pip install pipx && python3 -m pipx ensurepath && clear
    #pip3 deps
         pip3 install dbus-python PyQt5 db-sqlite3 psycopg2-binary readline whitenoise --upgrade 
         pip3 install --upgrade pip
    #-------------------------------------------------------------------------#
    #Rustlang
      curl -qfsSL "https://sh.rustup.rs" | bash /dev/stdin -y
      source "$HOME/.cargo/env" && clear
      sudo su -c 'curl -qfsSL "https://sh.rustup.rs" | bash /dev/stdin -y'
      sudo su -c 'source "$HOME/.cargo/env"' && clear
    #-------------------------------------------------------------------------#
    #Eget
     #feroxbuster
      sudo eget epi052/feroxbuster --to /usr/local/bin/feroxbuster && sudo chmod +x /usr/local/bin/feroxbuster
     #gping: https://github.com/orf/gping
      sudo eget orf/gping --asset Linux --asset 64 --to /usr/local/bin/gping && sudo chmod +x /usr/local/bin/gping
     #HaylXon
      sudo eget pwnwriter/haylxon --to /usr/local/bin/hxn && sudo chmod +x /usr/local/bin/hxn
     #jless
      sudo eget PaulJuliusMartinez/jless --to /usr/local/bin/jless && sudo chmod +x /usr/local/bin/jless
     #Speedtest-go
      sudo eget showwin/speedtest-go --to /usr/local/bin/speedtest-go && sudo chmod +x /usr/local/bin/speedtest-go 
     #x8
      sudo eget Sh1Yo/x8 --to /usr/local/bin/x8 && sudo chmod +x /usr/local/bin/x8
     #YQ
      sudo eget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 --to /usr/local/bin/yq && sudo chmod +xwr /usr/local/bin/yq  
    #-------------------------------------------------------------------------#
    #Misc
       #aki
       sudo wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/aki/aki.sh -O /usr/local/bin/aki && sudo chmod +xwr /usr/local/bin/aki 2>/dev/null
       #amass
       sudo rm "$(which amass)" 2>/dev/null
       go install -v github.com/owasp-amass/amass/v3/...@master
       #anew
       go install -v github.com/tomnomnom/anew@latest 2>/dev/null
       #ansi2html 
       pip3 install ansi2html 2>/dev/null
       #ansi2txt
       pip3 install ansi2txt 2>/dev/null
       #airiXSS
       go install -v github.com/ferreiraklet/airixss@latest 2>/dev/null
       #Arjun
       pip3 install "git+https://github.com/s0md3v/Arjun.git" 2>/dev/null
       #asn
       sudo curl -qfsSLk "https://raw.githubusercontent.com/nitefood/asn/master/asn" -o /usr/local/bin/asn && sudo chmod +xwr /usr/local/bin/asn
       #bbScope
       go install -v github.com/sw33tLie/bbscope@latest 2>/dev/null
       #bhedak
       pip3 install bhedak 2>/dev/null
       #Cent
       go install -v github.com/xm1k3/cent@latest && cent init 2>/dev/null
       #Cero
       go env -w GO111MODULE="auto" 2>/dev/null
       go install -v github.com/glebarez/cero@latest 2>/dev/null
       #cloudfox
       cd $(mktemp -d) && git clone https://github.com/BishopFox/cloudfox && cd ./cloudfox && go build . && mv cloudfox $HOME/go/bin/cloudfox 
       #cook
       go install -v github.com/glitchedgitz/cook/v2/cmd/cook@latest && cook 2>/dev/null
       #creds
          pip3 install "git+https://github.com/ihebski/DefaultCreds-cheat-sheet.git"
         #pipx install -f "git+https://github.com/ihebski/DefaultCreds-cheat-sheet.git" --include-deps 2>/dev/null
       #crlFuzz
       GO111MODULE=on go install -v github.com/dwisiswant0/crlfuzz/cmd/crlfuzz@latest 2>/dev/null
       #croc
       go install -v github.com/schollz/croc/v9@latest
       #crt
       go install -v github.com/cemulus/crt@latest 2>/dev/null
       #dalfox
       go install -v github.com/hahwul/dalfox/v2@latest 2>/dev/null
       #dmut
       go install -v github.com/bp0lr/dmut@latest 2>/dev/null
       #dnsReaper
       cd $HOME/Tools && git clone https://github.com/punk-security/dnsReaper 2>/dev/null
       cd $HOME/Tools/dnsReaper && pip3 install -r requirements.txt 2>/dev/null
       #dsieve
       go install -v github.com/trickest/dsieve@latest 2>/dev/null
       #edirb
       go install -v github.com/NitescuLucian/hacks/edirb@latest 2>/dev/null
       #enumrepo
       go install -v github.com/trickest/enumerepo@latest 2>/dev/null
       #eefjsf
       go install -v github.com/edoardottt/lit-bb-hack-tools/eefjsf@main
       #Favirecon
       go install -v github.com/edoardottt/favirecon/cmd/favirecon@latest 2>/dev/null
       #fingerprintX
       go install github.com/praetorian-inc/fingerprintx/cmd/fingerprintx@latest 2>/dev/null
       sudo su -c "go install github.com/praetorian-inc/fingerprintx/cmd/fingerprintx@latest" 2>/dev/null
       #fireprox-ng
       pip3 install "git+https://github.com/Sprocket-Security/fireproxng.git"
         #pipx install -f "git+https://github.com/Sprocket-Security/fireproxng.git" --include-deps 2>/dev/null
       #fff
       go get -u github.com/tomnomnom/fff 2>/dev/null
       #ffuf
       go install github.com/ffuf/ffuf/v2@latest 2>/dev/null
       #fGet
       go get -u -v github.com/bp0lr/fget 2>/dev/null
       #gau
       go install -v github.com/lc/gau/v2/cmd/gau@latest 2>/dev/null
       #gauplus
       go install -v github.com/bp0lr/gauplus@latest 2>/dev/null
       #galer
       GO111MODULE=on go get github.com/dwisiswant0/galer 2>/dev/null
       #gf
       go install github.com/tomnomnom/gf@latest 2>/dev/null
       #Also Setup gf-patterns
       cd $(mktemp -d) && git clone https://github.com/NitinYadav00/gf-patterns 2>/dev/null && cd ./gf-patterns && mv *.json $HOME/.gf 2>/dev/null && cd -
       #gfX  
       go install github.com/dwisiswant0/gfx@latest 2>/dev/null
       #Gotator
       go install github.com/Josue87/gotator@latest 2>/dev/null
       #getJS
       go install github.com/003random/getJS@latest 2>/dev/null
       #https://github.com/sdushantha/gitdir
       pip3 install gitdir 2>/dev/null
       #gitlab-subdomains
       go install -v github.com/gwen001/gitlab-subdomains@latest 2>/dev/null
       #goDeclutter
       go install -v github.com/c3l3si4n/godeclutter@main 2>/dev/null
       #goFireprox
       go install -v github.com/mr-pmillz/gofireprox/cmd/gofireprox@latest 2>/dev/null
       #goverview
       GO111MODULE=on go get github.com/j3ssie/goverview 2>/dev/null
       #GoWitness
       go install github.com/sensepost/gowitness@latest 2>/dev/null
       sudo su -c "go install github.com/sensepost/gowitness@latest" 2>/dev/null
       #HakrevDNS
       go install -v github.com/hakluke/hakrevdns@latest 2>/dev/null
       #Hakrawler
       go install github.com/hakluke/hakrawler@latest 2>/dev/null
       #Inscope
       go install -v github.com/tomnomnom/hacks/inscope@master 2>/dev/null
       #InterLace
       pip3 install "git+https://github.com/codingo/Interlace.git" 
         #pipx install -f "git+https://github.com/codingo/Interlace.git" --include-deps 2>/dev/null
       #ipCDN
       go install -v github.com/six2dez/ipcdn@latest  2>/dev/null
       #Jaeles
       go install -v github.com/jaeles-project/jaeles@latest 2>/dev/null
       #Jeeves
       go install -v github.com/ferreiraklet/Jeeves@latest 2>/dev/null
       #Js-Beautify
       sudo npm -g install js-beautify 2>/dev/null
       #JSA
       cd $HOME/Tools && git clone https://github.com/w9w/JSA.git 2>/dev/null
       cd $HOME/Tools/JSA && pip3 install -r requirements.txt 2>/dev/null
       #linky
       sudo wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/linky/linky.sh -O /usr/local/bin/linky && sudo chmod +xwr /usr/local/bin/linky && linky --init && clear 
       #Logsensor
       cd $HOME/Tools && git clone https://github.com/Mr-Robert0/Logsensor 2>/dev/null
       cd $HOME/Tools/Logsensor && pip3 install -r requirements.txt 2>/dev/null
       #logtimer
       go install -v github.com/Eun/logtimer/cmd/logtimer@latest 2>/dev/null
       #mgwls
       go install -v github.com/trickest/mgwls@latest 2>/dev/null
       #mkpath
       go install -v github.com/trickest/mkpath@latest 2>/dev/null
       #mksub
       go install -v github.com/trickest/mksub@latest 2>/dev/null
       #mubeng
       cd $(mktemp -d) && git clone https://github.com/kitabisa/mubeng && cd ./mubeng && make build && sudo mv ./bin/mubeng /usr/local/bin && sudo chmod +xwr /usr/local/bin/mubeng && cd -
       #nmap formatter
       go install github.com/vdjagilev/nmap-formatter/v2@latest
       #nrich, do check for latest: [https://gitlab.com/shodan-public/nrich/-/releases]
       sudo rm $(which nrich) 2>/dev/null 
       sudo wget https://gitlab.com/api/v4/projects/33695681/packages/generic/nrich/0.4.1/nrich-linux-amd64 -O /usr/local/bin/nrich && clear && sudo chmod +xwr /usr/local/bin/nrich  2>/dev/null
       #Parth
       pip3 install parth 2>/dev/null
       #ProxyBroker2
       pip3 install "git+https://github.com/bluet/proxybroker2.git"
          #pipx install -f "git+https://github.com/bluet/proxybroker2.git" --include-deps 2>/dev/null
       #PureDns
       go install github.com/d3mondev/puredns/v2@latest 2>/dev/null
       #qsreplace
       go install -v github.com/tomnomnom/qsreplace@latest 2>/dev/null
       #qsinject
       go install -v github.com/ameenmaali/qsinject@latest 2>/dev/null
       #RoboXtractor
       go env -w GO111MODULE="auto" 2>/dev/null
       go get -u github.com/Josue87/roboxtractor 2>/dev/null
       #scopegen
       go install -v github.com/Azathothas/BugGPT-Tools/scopegen@main 2>/dev/null
       #scopeview
       sudo wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/scopeview/scopeview.sh -O /usr/local/bin/scopeview && sudo chmod +xwr /usr/local/bin/scopeview 2>/dev/null
       #Spk
       go install -v github.com/dhn/spk@latest 2>/dev/null
       #sshkeys
       go install -v github.com/Eun/sshkeys/cmd/sshkeys@latest
       #SubXtract
       sudo wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/subxtract/subxtract.sh -O /usr/local/bin/subxtract && sudo chmod +xwr /usr/local/bin/subxtract 2>/dev/null
       #SubZuf 
       pip3 install "git+https://github.com/elceef/subzuf.git"
          #pipx install -f "git+https://github.com/elceef/subzuf.git" 2>/dev/null
       #SQLiDetector
       cd $HOME/Tools && git clone https://github.com/eslam3kl/SQLiDetector/ 2>/dev/null
       cd $HOME/Tools/SQLiDetector && pip3 install -r requirements.txt 2>/dev/null
       #TldBrute
       cd $(mktemp -d) && git clone https://github.com/Sybil-Scan/tldbrute && cd tldbrute && pip install . && cd -
       #TOK
       go install github.com/tomnomnom/hacks/tok@master 2>/dev/null
       #TruffleHog
       sudo rm $(which trufflehog) 2>/dev/null
       #eget trufflesecurity/trufflehog --to $truffle_tmp/trufflehog && sudo mv $truffle_tmp/trufflehog /usr/local/bin/trufflehog && sudo chmod +xwr /usr/local/bin/trufflehog
       cd $(mktemp -d) && git clone https://github.com/trufflesecurity/trufflehog.git 2>/dev/null && cd ./trufflehog && go install -v 2>/dev/null && trufflehog --version && cd -
       #unfurl
       go install -v github.com/tomnomnom/unfurl@latest 2>/dev/null
       #urless
       cd $HOME/Tools && git clone https://github.com/xnl-h4ck3r/urless 2>/dev/null
       cd $HOME/Tools/urless && pip3 install -r requirements.txt 2>/dev/null
       cd $HOME/Tools/urless && python3 setup.py install 2>/dev/null
       #uro
       pip3 install uro 2>/dev/null
       #VhostFinder
       go install -v github.com/wdahlenburg/VhostFinder@latest 2>/dev/null
       #wadlDumper
       go get github.com/dwisiswant0/wadl-dumper 2>/dev/null
       #WAFme0w
       go install -v github.com/Lu1sDV/wafme0w/cmd/wafme0w@latest 2>/dev/null
       #WaybackUrls
       go install github.com/tomnomnom/waybackurls@latest 2>/dev/null
       #Waymore
       cd $HOME/Tools && git clone https://github.com/xnl-h4ck3r/waymore.git && cd $HOME/Tools/waymore 2>/dev/null
       pip3 install -r requirements.txt 2>/dev/null
       python3 setup.py install 2>/dev/null
       #weebu
       sudo wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/weebu/weebu.sh -O /usr/local/bin/weebu && sudo chmod +xwr /usr/local/bin/weebu && weebu --init 2>/dev/null
       #wl
       go install -v github.com/s0md3v/wl/cmd/wl@latest 2>/dev/null
       #Wordium
       sudo wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/wordium/wordium.sh -O /usr/local/bin/wordium && sudo chmod +xwr /usr/local/bin/wordium 2>/dev/null
       #XnLinkfinder
       cd $HOME/Tools && git clone https://github.com/xnl-h4ck3r/xnLinkFinder.git && cd $HOME/Tools/xnLinkFinder 2>/dev/null
       sudo python setup.py install 2>/dev/null
       #Yataf
       go install github.com/Damian89/yataf@master 2>/dev/null
    #PDTM is buggy
       #aix
       go install -v github.com/projectdiscovery/aix/cmd/aix@latest 2>/dev/null
       #alterx
       go install -v github.com/projectdiscovery/alterx/cmd/alterx@latest 2>/dev/null
       #asnmap 
       go install -v github.com/projectdiscovery/asnmap/cmd/asnmap@latest 2>/dev/null
       #ChaosClient
       go install -v github.com/projectdiscovery/chaos-client/cmd/chaos@latest 2>/dev/null
       #Cloudlist
       go install -v github.com/projectdiscovery/cloudlist/cmd/cloudlist@latest 2>/dev/null
       #dnsX
       go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest 2>/dev/null
       #HttpX
       go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest 2>/dev/null
       #Interact-Sh
       go install -v github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest 2>/dev/null
       #Katana 
       go install github.com/projectdiscovery/katana/cmd/katana@latest 2>/dev/null
       #mapcidr
       go install -v github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest 2>/dev/null
       #Naabu
       #libpcap-dev
       if command -v aptitude &> /dev/null 2>&1; then
          echo -e "${GREEN}Installing${NC} || ${BLUE}Updating${NC} : ${PURPLE}Naabu${NC}\n" 
            if sudo aptitude install libpcap-dev -y ; then         
               go install -v  github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
            else
               echo -e "${PINK}Naabu${NC} ➼ ${RED}Installation failed!${NC}"
               echo -e "${PINK}libpcap-dev${NC} ➼ ${RED}Installation failed${NC}.\n Try manually: ${BLUE}https://github.com/projectdiscovery/naabu#prerequisite${NC}"
               echo -e "${YELLOW}Or Use${NC}: ${PURPLE}aptitude install libpcap-dev${NC}"
            fi
       elif sudo apt-get update && sudo apt-get install aptitude -y; then
            if sudo aptitude install libpcap-dev -y ; then         
               go install -v  github.com/projectdiscovery/naabu/v2/cmd/naabu@latest 
            else
               echo -e "${PINK}Naabu${NC} ➼ ${RED}Installation failed!${NC}"
               echo -e "${PINK}libpcap-dev${NC} ➼ ${RED}Installation failed${NC}.\n Try manually: ${BLUE}https://github.com/projectdiscovery/naabu#prerequisite${NC}"
               echo -e "${YELLOW}Or Use${NC}: ${PURPLE}aptitude install libpcap-dev${NC}"
            fi
        fi       
       #Notify
       go install -v github.com/projectdiscovery/notify/cmd/notify@latest 2>/dev/null
       #Nuclei
       go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest 2>/dev/null
       #Openrisk
       go install -v github.com/projectdiscovery/openrisk@latest 2>/dev/null
       #Proxify 
       go install -v github.com/projectdiscovery/proxify/cmd/proxify@latest 2>/dev/null
       #Shuffledns
       go install -v github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest 2>/dev/null
       #Subfinder
       go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest 2>/dev/null
       #TlsX
       go install github.com/projectdiscovery/tlsx/cmd/tlsx@latest 2>/dev/null
       #Uncover
       go install -v github.com/projectdiscovery/uncover/cmd/uncover@latest 2>/dev/null
       #Wappalyzer-Go
       go install -v github.com/projectdiscovery/wappalyzergo/cmd/update-fingerprints@latest 2>/dev/null
#-------------------------------------------------------------------------#
  ##End && Clean
      sudo DEBIAN_FRONTEND=noninteractive sudo apt-get update -y && sudo apt-get install aptitude -y
      sudo DEBIAN_FRONTEND=noninteractive sudo apt-get update -y
      sudo DEBIAN_FRONTEND=noninteractive sudo aptitude clean -y && sudo aptitude autoclean -y && clear
      sudo DEBIAN_FRONTEND=noninteractive sudo apt autoremove -y
      sudo apt-get update -y && sudo apt autoremove -y && clear
    #Fix Broken
      sudo DEBIAN_FRONTEND=noninteractive sudo dpkg --configure -a 
      sudo DEBIAN_FRONTEND=noninteractive sudo sudo apt --fix-broken install -y
      sudo DEBIAN_FRONTEND=noninteractive sudo apt autoremove -y
    #archey fetch
    sudo pip3 install archey4  
    archey
#-------------------------------------------------------------------------#
#EOF 
