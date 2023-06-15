#----------------------------------------------------------------------#
# | apt | root | su --> Disabled
# pkgs are installed via conda | pip | eget
# Reference : https://github.com/aws/studio-lab-examples/issues/118
# Alt `/bin` to source: /home/studio-lab-user/.local/share/
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
#ENVS (for Reference ONLY)
# export PATH=/home/studio-lab-user/.conda/envs/studiolab/bin:/opt/conda/condabin:/opt/conda/bin:/usr/local/sbin:$HOME/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/studio-lab-user/.go/bin:/home/studio-lab-user/go/bin:/home/studio-lab-user/.go/bin:/home/studio-lab-user/go/bin:/home/studio-lab-user/.go/bin:/home/studio-lab-user/go/bin:$PATH
#USER=studio-lab-user
#HOME=/home/studio-lab-user
#USER/BIN=/home/studio-lab-user/bin
#Golang#
#GOPATH=/home/studio-lab-user/go
#GOROOT=/home/studio-lab-user/.go
#GOBIN=/home/studio-lab-user/go/bin/
#python/pip#
#BIN=/home/studio-lab-user/.conda/envs/studiolab/bin/
#Rust#
#CARGO_PATH=/home/studio-lab-user/.cargo
#CARGO_BIN=/home/studio-lab-user/.cargo/bin
#----------------------------------------------------------------------#
export origin=$(pwd)
#----------------------------------------------------------------------#
#Primaries:
#---------#
#Setup base
mkdir -p $HOME/{bin,.fonts,.local/bin,.local/share,Tools,tmp,.zsh} >/dev/null 2>&1
#Install golang
bash <(curl -qfsSL https://git.io/go-installer)
rm $HOME/go*.gz 
export PATH=$HOME/go/bin:$PATH  
# source /home/studio-lab-user/.zshrc
#Install rust
conda install -c conda-forge rust -y 
#eget
go install github.com/zyedidia/eget@latest
# curl -qfsSL "https://zyedidia.github.io/eget.sh" | bash && mv ./eget /home/studio-lab-user/go/bin/eget
#Binaries
#GNU bc (Basic Calculator)
curl -qfsSL "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/free-tiers/VPS/.binaries/bc_x86_64_ELF_LSB_Linux" -o "$HOME/bin/bc" && chmod +x "$HOME/bin/bc"
export PATH=$HOME/bin:$PATH  
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
#Addons & Essentials:
#---------# 
#From main conda forges
#Update base
conda update -n base conda -y
# DO NOT USE One-Liner (pkgs are skipped for UNKNOWN Reason)
conda install -c conda-forge --all -y
conda install -c conda-forge aria2 --all -y
conda install -c conda-forge autoconf --all -y
conda install -c conda-forge broot --all -y
conda install -c conda-forge bzip2 --all -y
conda install -c conda-forge ca-certificates --all -y
conda install -c conda-forge cmake --all -y
conda install -c conda-forge coreutils --all -y
conda install -c conda-forge curl --all -y
conda install -c conda-forge dnspython --all -y
conda install -c conda-forge dos2unix --all -y
conda install -c conda-forge doxygen --all -y
conda install -c conda-forge dbus --all -y
conda install -c conda-forge fontconfig --all -y
conda install -c conda-forge fzf --all -y
conda install -c conda-forge git --all -y
conda install -c conda-forge gnupg --all -y
conda install -c conda-forge htop --all -y
conda install -c conda-forge inotify-tools --all -y
conda install -c conda-forge iperf --all -y
conda install -c conda-forge jq --all -y
conda install -c conda-forge libpcap --all -y
conda install -c conda-forge libcurl --all -y
conda install -c conda-forge libsqlite --all -y
conda install -c conda-forge libwebsockets --all -y
conda install -c conda-forge xorg-libx11 --all -y
conda install -c conda-forge ld_impl_linux-64 --all -y
conda install -c conda-forge llvm11 --all -y
conda install -c conda-forge make --all -y
conda install -c conda-forge nim --all -y
conda install -c conda-forge ncurses --all -y
conda install -c conda-forge nodejs --all -y
conda install -c conda-forge openssh --all -y
conda install -c conda-forge openssl --all -y
conda install -c conda-forge pango --all -y
conda install -c conda-forge perl --all -y
conda install -c conda-forge php --all -y
conda install -c conda-forge pipx --all -y
conda install -c conda-forge pkg-config --all -y
conda install -c conda-forge pnpm --all -y
conda install -c conda-forge powerline-status --all -y
conda install -c conda-forge psycopg2 --all -y
conda install -c conda-forge psycopg2-binary --all -y
conda install -c conda-forge pulseaudio --all -y
conda install -c conda-forge pyqt --all -y
conda install -c conda-forge pyqt5-sip --all -y
conda install -c conda-forge readline --all -y
conda install -c conda-forge sshtunnel --all -y
conda install -c conda-forge sshpubkeys --all -y
conda install -c conda-forge sqlite --all -y
conda install -c conda-forge sshfs --all -y
conda install -c conda-forge starship --all -y
conda install -c conda-forge tk --all -y
conda install -c conda-forge tmux --all -y
conda install -c conda-forge wget --all -y
conda install -c conda-forge whitenoise --all -y
conda install -c conda-forge xorg-libxau --all -y
conda install -c conda-forge xorg-libx11 --all -y
conda install -c conda-forge websockets --all -y
conda install -c conda-forge websocket-client --all -y
conda install -c conda-forge zlib --all -y
conda install -c conda-forge zsh --all -y
#From alt conda forges
conda install -c dnachun neofetch --all -y
conda install -c dnachun xclip --all -y 

#fzf deps
eget sharkdp/fd --to "$HOME/bin/fdfind" --asset gnu && chmod +xwr "$HOME/bin/fdfind"
eget sharkdp/bat --to "$HOME/bin/batcat" --asset gnu && chmod +xwr "$HOME/bin/batcat"
#Tmux Plugins
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
   mkdir -p "$HOME/.tmux"
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm >/dev/null 2>&1
fi
#.tmux.conf
conda install -c conda-forge tmux --all -y
curl -qfsSL "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/free-tiers/VPS/.scripts/.tmux.conf" -o "$HOME/.tmux.conf"
tmux source-file "$HOME/.tmux.conf" >/dev/null 2>&1
#zsh configs
#.zshrc
conda install -c conda-forge zsh --all -y
curl -qfsSL "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/free-tiers/VPS/AWS%20SageMaker%20Studio%20(Lab)/Utils/.zshrc" -o "$HOME/.zshrc"
dos2unix --quiet "$HOME/.zshrc" >/dev/null 2>&1 && sed -e '/^$/d' -e 's/[[:space:]]*$//' -i "$HOME/.zshrc" >/dev/null 2>&1
#Plugins
mkdir -p "$HOME/.zsh" && cd "$HOME/.zsh"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git >/dev/null 2>&1
git clone https://github.com/zsh-users/zsh-autosuggestions.git >/dev/null 2>&1
git clone https://github.com/marlonrichert/zsh-autocomplete.git >/dev/null 2>&1
cd ~
#Starship deps
mkdir "$HOME/.fonts"
conda install -c conda-forge starship --all -y
# Font directories:
#         /home/studio-lab-user/.conda/envs/studiolab/fonts 
#         /home/studio-lab-user/.local/share/fonts
#         /usr/local/share/fonts # No Perm
#         /usr/share/fonts # No Perm
#         /home/studio-lab-user/.fonts
cd $(mktemp -d) && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/FiraCode.zip && unzip -o FiraCode.zip -d "$HOME/.fonts" && fc-cache -f -v && cd - && clear 
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
#Extras:
#------#
#eget (mostly for rust binaries, as compile time is too long)
 eget epi052/feroxbuster --asset 64-linux-feroxbuster.zip --to "$HOME/.cargo/bin/feroxbuster" && chmod +x "$HOME/.cargo/bin/feroxbuster"
#gping: https://github.com/orf/gping
 eget orf/gping --asset Linux --asset 64 --to "$HOME/.cargo/bin/gping" && chmod +x "$HOME/.cargo/bin/gping"
#HaylXon
 eget pwnwriter/haylxon --to "$HOME/.cargo/bin/hxn" && chmod +x "$HOME/.cargo/bin/hxn"
#jless
 eget PaulJuliusMartinez/jless --to "$HOME/bin/jless" && chmod +x "$HOME/bin/jless"
#pping [Another Alt : https://github.com/r12f/rnp (rustlang)]
 eget wzv5/pping "$HOME/bin/pping" && chmod +x "$HOME/bin/pping"
#Speedtest-go
 eget showwin/speedtest-go --to "$HOME/bin/speedtest-go" && chmod +x "$HOME/bin/speedtest-go"
#tere (Terminal Dir Navigator)
 eget mgunyho/tere --asset gnu --to "$HOME/.cargo/bin/tere" && chmod +x "$HOME/.cargo/bin/tere"
#xh
 eget ducaale/xh --to "$HOME/.cargo/bin/xh" && chmod +x "$HOME/.cargo/bin/xh"
#x8
 eget Sh1Yo/x8 --to "$HOME/.cargo/bin/x8" && chmod +x "$HOME/.cargo/bin/x8"
#YQ
 eget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 --to "$HOME/bin/yq" && chmod +xwr "$HOME/bin/yq"  
#go install
export PATH=$HOME/go/bin:$PATH
go install -v github.com/owasp-amass/amass/v3/...@master
go install -v github.com/tomnomnom/anew@latest 2>/dev/null 
go install -v github.com/projectdiscovery/asnmap/cmd/asnmap@latest 2>/dev/null
go install -v github.com/projectdiscovery/cloudlist/cmd/cloudlist@latest 2>/dev/null
go install -v github.com/schollz/croc/v9@latest 2>/dev/null
go install -v github.com/cemulus/crt@latest 2>/dev/null
go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest 2>/dev/null
go install -v github.com/ffuf/ffuf/v2@latest 2>/dev/null
go install -v github.com/antonmedv/fx@latest 2>/dev/null
go install github.com/Josue87/gotator@latest 2>/dev/null
go install github.com/nao1215/gup@latest 2>/dev/null
go install -v github.com/hakluke/hakrevdns@latest 2>/dev/null
go install github.com/hakluke/hakrawler@latest 2>/dev/null
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest 2>/dev/null
go install -v github.com/tomnomnom/hacks/inscope@master 2>/dev/null
go install -v github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest 2>/dev/null
go install github.com/projectdiscovery/katana/cmd/katana@latest 2>/dev/null
go install -v github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest 2>/dev/null
go install -v github.com/trickest/mgwls@latest 2>/dev/null
go install -v github.com/trickest/mkpath@latest 2>/dev/null
go install -v github.com/trickest/mksub@latest 2>/dev/null
cd $(mktemp -d) && git clone https://github.com/kitabisa/mubeng && cd ./mubeng && make build && mv ./bin/mubeng $HOME/go/bin/mubeng && chmod +xwr $HOME/go/bin/mubeng && cd ~
go install -v  github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
go install -v github.com/projectdiscovery/notify/cmd/notify@latest 2>/dev/null
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest 2>/dev/null
go install -v github.com/projectdiscovery/proxify/cmd/proxify@latest 2>/dev/null
go install -v github.com/d3mondev/puredns/v2@latest 2>/dev/null
go install -v github.com/dhn/spk@latest 2>/dev/null
go install -v github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest 2>/dev/null
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest 2>/dev/null
go install -v github.com/pouriyajamshidi/tcping@latest 2>/dev/null
go install -v github.com/projectdiscovery/tlsx/cmd/tlsx@latest 2>/dev/null
go install -v github.com/tomnomnom/hacks/tok@master 2>/dev/null
go install -v github.com/netrixone/udig/cmd/udig@master 2>/dev/null
go install -v github.com/tomnomnom/unfurl@latest 2>/dev/null
go install -v github.com/projectdiscovery/uncover/cmd/uncover@latest 2>/dev/null
go install -v github.com/projectdiscovery/wappalyzergo/cmd/update-fingerprints@latest 2>/dev/null
go install -v github.com/wdahlenburg/VhostFinder@latest 2>/dev/null
go install -v github.com/harakeishi/whris@latest
go install github.com/sibprogrammer/xq@latest
#pip3
pip3 install ansi2html 2>/dev/null
pip3 install ansi2txt 2>/dev/null
pip3 install archey4 2>/dev/null
pip3 install "git+https://github.com/Sprocket-Security/fireproxng.git"
pip3 install gitdir 2>/dev/null
pip3 install "git+https://github.com/codingo/Interlace.git" 
pip3 install "git+https://github.com/bluet/proxybroker2.git"
pip3 install "git+https://github.com/elceef/subzuf.git"
#----------------------------------------------------------------------#
cd "$origin"
#----------------------------------------------------------------------#
#Source ~/.zshrc
echo "$(which zsh)" | $HOME/go/bin/anew -q "$HOME/.bashrc"
echo "$(which zsh)" | $HOME/go/bin/anew -q "$HOME/.profile"
source "$HOME/.bashrc"
#EOF
