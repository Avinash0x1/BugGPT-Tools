#!/usr/bin/env bash

#-------------------------------------------------------------------------#
#Google monitors what you run on Colab, and will often warn you#
#Pulling a Foreign Script and piping to bash, solves a lot of problems#
#-------------------------------------------------------------------------#
#aptitude clean cache
aptitude_clean()
{    
     sudo apt-get update && sudo apt-get install aptitude -y
     sudo apt-get update -y
     sudo aptitude clean -y && sudo aptitude autoclean -y && clear
}
#-------------------------------------------------------------------------#
#Core + misc apt Tools
core_deps() 
{
     sudo apt-get update && sudo apt-get install aptitude -y
     clear && echo -e "➼${GREEN} Initializing ${PURPLE}Core${NC} Dependencies${NC}\n"
     sudo aptitude install apache2 apt-transport-https autoconf awscli build-essential bzip2 ca-certificates ccze chromium colordiff composer curl dconf-cli dnsutils dos2unix doxygen freeglut3-dev gh git gnupg-agent gunicorn java-common java-compiler java-runtime java-sdk jq libao-dev libbz2-dev libcurl4-openssl-dev libffi-dev libfontconfig1-dev libfreetype6-dev libglew-dev libglfw3-dev libglm-dev libglu1-mesa-dev libjpeg-dev liblzma-dev libmpg123-dev libncurses5-dev libncurses-dev libncursesw5-dev libopenjp2-7 libpcap-dev libpq-dev libreadline-dev libsqlite3-dev libssl-dev libarchive-dev libtiff5 libturbojpeg0-dev libxcb1-dev libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev libxcursor-dev libxi-dev libxinerama-dev libxkbcommon-dev libxml2-dev libxmlsec1-dev llvm locate lzma make massdns mesa-common-dev mesa-utils moreutils net-tools nikto nim nmap nodejs npm openssh-server payloadsallthethings perl php php-cli pkg-config pv postgresql-all python3-bz2file python3-openssl python3-venv readline-common ruby seclists software-properties-common sqlite3 sqlmap ssh ssh-tools sudo tig tk tk-dev unzip uuid-runtime wfuzz wget xsltproc xz-utils zip zlib1g-dev -y
     echo -e "\n${PURPLE}Indexing Files${NC}....\n${BLUE}Be Patient${NC}"
     #Configure ssh
     #Already pre runs a tailscale instance for ssh
     #sudo service ssh start
     sudo updatedb --prunepaths=/media 2>/dev/null
}    
#Install zsh, for ~/.zshrc
setup_zsh()
{
     sudo apt-get update && sudo apt-get install aptitude -y
     clear && echo -e "➼${GREEN} Installng  ${PURPLE}zsh${NC}\n"
   #zsh 
     sudo aptitude install zsh zsh-syntax-highlighting zsh-autosuggestions -y
   #fzf  
     eget sharkdp/fd --to ./fdfind --asset ^gnu && sudo mv ./fdfind /usr/local/bn/fdfind && sudo chmod +xwr /usr/local/bn/fdfind
     eget sharkdp/bat --to ./batcat --asset ^gnu && sudo mv ./batcat /usr/local/bn/batcat && sudo chmod +xwr /usr/local/bn/batcat
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
}
setup_zsh
#-------------------------------------------------------------------------#
#Docker
install_docker()
{
  curl -qfskSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
  #$(lsb_release --codename | cut -f2) lists ara (Parrot Specific)
  #Supported: https://download.docker.com/linux/debian/dists/
  #Current Stable Debian Release: bullseye (Debian 11)
  #Soon tbr: bookworm 
  echo "deb [arch=amd64] https://download.docker.com/linux/debian bullseye stable" | sudo tee /etc/apt/sources.list.d/docker-engine.list
  sudo apt-get update -y && sudo apt-get install -y docker-ce
  sudo systemctl start docker && sudo systemctl enable docker
  #Passwordless for docker
  sudo gpasswd -a "${USER}" docker
  #Docker Compose
  eget docker/compose --to ./docker-compose && sudo mv ./docker-compose /usr/local/bin && sudo chmod +xwr /usr/local/bin/docker-compose
       if command -v docker-compose &> /dev/null 2>&1; then
             sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
       fi 
  #Requires a system restart to work
}
#-------------------------------------------------------------------------#
#GoLang  
install_update_go()
{
    echo -e "➼ ${GREEN}Installing${NC} || ${BLUE}Updating ${PURPLE}golang${NC}..."
    udhos_golang=$(mktemp)
    cd $udhos_golang && git clone https://github.com/udhos/update-golang  && cd $udhos_golang/update-golang && sudo ./update-golang.sh
    source /etc/profile.d/golang_path.sh
    sudo su -c "source /etc/profile.d/golang_path.sh"
    sudo su -c "bash <(curl -sL https://git.io/go-installer)"
    #Eget for binaries
    go install -v github.com/zyedidia/eget@latest
    sudo su -c "go install -v github.com/zyedidia/eget@latest >/dev/null"
    if command -v go &> /dev/null 2>&1; then
        GO_VERSION=$(go version | awk '{print $3}')
        if [[ "$(printf '%s\n' "1.20.0" "$(echo "$GO_VERSION" | sed 's/go//')" | sort -V | head -n1)" != "1.20.0" ]]; then
           echo "➼ golang version 1.20.0 or greater is not installed. Installing..."
           cd $udhos_golang && git clone https://github.com/udhos/update-golang  && cd $udhos_golang/update-golang && sudo ./update-golang.sh
           source /etc/profile.d/golang_path.sh
           sudo su -c "bash <(curl -sL https://git.io/go-installer)"
        fi 
    fi
    rm -rf "$udhos_golang" 2>/dev/null     
}
#-------------------------------------------------------------------------#
#Go Binaries || Tools updater
update_go_binaries()
{
  if command -v go &> /dev/null 2>&1; then
    if ! command -v gup >/dev/null 2>&1; then
         clear && echo -e "➼ ${PURPLE}gup${NC} is ${RED}not installed${NC}! ${GREEN}Installing${NC}..."
         go install -v github.com/nao1215/gup@latest && clear
         gup completion
         source $(echo $SHELL)
         echo -e "➼ ${GREEN}Updating${NC} all your go tools..\n${BLUE}keep patience${NC}...\n"
         gup update 2>/dev/null
    else         
         clear && echo -e "➼ ${GREEN}Updating${NC} all your go tools..\n${BLUE}keep patience${NC}...\n"
         gup update 2>/dev/null && clear            
    fi 
  else
      install_update_go    
  fi
}
#-------------------------------------------------------------------------#
#Python3: Pip+pipx+pyenv
python3_deps()
{
     sudo apt-get update -y
     clear && echo -e "➼${GREEN} Initializing ${PURPLE}Python${NC} Dependencies${NC}\n"
     sudo aptitude install python3 python3-pip python3-aiohttp python3-certbot-apache python3-requests python3-matplotlib python3-keras python3-opencv python3-django python3-flask -y && clear
     if command -v python3 &> /dev/null 2>&1; then
     #Setup Pyenv, Not needed
#        setup_pyenv()
#        {
#           curl -qsk https://pyenv.run | bash 2>/dev/null
#               echo 'export PYENV_ROOT="$HOME/.pyenv"' >>  $HOME/.zshrc
#               echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >>  $HOME/.zshrc && source  $HOME/.zshrc
#               echo 'eval "$(pyenv init -)"' >>  $HOME/.zshrc
#               source  $HOME/.zshrc
#               #set pyenv global vars
#               pyenv install 3.11.2
#               pyenv global 3.11.2          
#        } 
#        setup_pyenv
     #python3_pipx
       python3_pipx()
       {
           if ! command -v pipx >/dev/null 2>&1; then
              echo -e "➼ ${PINK}pipx${NC} is ${RED}not installed${NC}. ${GREEN}Installing...${NC}"
              python3 -m pip install pipx && python3 -m pipx ensurepath && clear
                if ! command -v pipx >/dev/null 2>&1; then
                    echo -e "${PINK}pipx${NC} ➼ ${RED}Installation failed${NC}.\n Try manually: ${BLUE}https://pypa.github.io/pipx/installation/${NC}"
                  exit 1
                fi
           fi
       }
       python3_pipx 
       #pip3 deps
       pip3 install dbus-python PyQt5 db-sqlite3 psycopg2-binary readline whitenoise --upgrade 
       pip3 install --upgrade pip
     fi
}
#-------------------------------------------------------------------------#
#Rustlang
install_update_rust()
{
  rust_sh=(mktemp)
  wget --quiet https://sh.rustup.rs -O $rust_sh
  bash $rust_sh -y
  source "$HOME/.cargo/env" && clear
  #root user
  sudo su -c "bash $rust_sh -y"
  sudo su -c 'source "$HOME/.cargo/env"' && clear
}
#-------------------------------------------------------------------------#
#Misc Requirements
#yq, for parsing yaml
install_yq()
{
if ! command -v yq >/dev/null 2>&1; then
    echo -e "➼ ${PINK}yq${NC} is ${RED}not installed${NC}. ${GREEN}Installing...${NC}"
    sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq && sudo chmod +xwr /usr/local/bin/yq && clear
      if ! command -v yq >/dev/null 2>&1; then
        echo -e "${PINK}yq${NC} ➼ ${RED}Installation failed${NC}.\n Try manually: ${BLUE}https://github.com/mikefarah/yq#install${NC}"
        exit 1
     fi
fi
}
#-------------------------------------------------------------------------#
#-------------------------------------------------------------------------#
##Main
#Init Install
#aptitude
  if command -v aptitude &> /dev/null 2>&1; then
     core_deps
     python3_deps
     aptitude_clean
     install_update_go
     install_docker
     install_update_rust
  else #Install aptitude
     if sudo apt-get update && sudo apt-get install aptitude -y; then
        core_deps
        python3_deps
        aptitude_clean 
        install_update_go
        install_docker
        install_update_rust    
     else #Fail & exit
        echo -e "${RED}\u2717 Fatal${NC}: ${RED}Failed${NC} to ${YELLOW}Install ${PINK}aptitude${NC}\n"
        echo -e "${YELLOW}Try Manually${NC}"
        exit 1
     fi   
  fi
#-------------------------------------------------------------------------#
##End && Clean
aptitude_clean 
#-------------------------------------------------------------------------#
#EOF
