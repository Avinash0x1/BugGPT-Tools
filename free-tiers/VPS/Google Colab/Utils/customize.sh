#!/usr/bin/env bash

#----------------------------------------------------------------------#
home_user=$(ls -d /home/*/) && export home_user="$home_user"
export origin=$(pwd)
#----------------------------------------------------------------------#
#Primaries:
#---------#
#Setup base
mkdir -p $HOME/{bin,.fonts,.local/bin,.local/share,Tools,tmp,.zsh} >/dev/null 2>&1
#Install golang
bash <(curl -qfsSL https://git.io/go-installer)
rm $HOME/go*.gz 
export PATH=$HOME/.go/bin:$PATH
export PATH=$HOME/go/bin:$PATH  
#Install rust
curl -qfsSL "https://sh.rustup.rs" | bash /dev/stdin -y 
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.cargo/env:$PATH
#eget
$HOME/.go/bin/go install github.com/zyedidia/eget@latest
curl -qfsSL "https://zyedidia.github.io/eget.sh" | bash && sudo mv ./eget /usr/local/bin/eget
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
#Install Zsh
sudo DEBIAN_FRONTEND=noninteractive sudo apt-get install zsh zsh-syntax-highlighting zsh-autosuggestions -y
# Install nerdfonts
 cd $(mktemp -d) && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/FiraCode.zip && sudo unzip -o FiraCode.zip -d /usr/share/fonts && sudo fc-cache -f -v && clear
 cd -
#Install fzf
  if [ ! -d "$HOME/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf >/dev/null 2>&1
    ~/.fzf/install --all >/dev/null 2>&1
  fi
  cp -r ~/.fzf $home_user
#fzf deps
 sudo eget sharkdp/fd --asset gnu --to /usr/local/bin/fdfind && sudo chmod +xwr /usr/local/bin/fdfind
 sudo eget sharkdp/bat --asset gnu --to /usr/local/bin/batcat && sudo chmod +xwr /usr/local/bin/batcat
#Install Starship
 curl -sS https://starship.rs/install.sh | sudo sh -s -- -y >/dev/null 2>&1
#Install tmux
 sudo DEBIAN_FRONTEND=noninteractive sudo apt-get install tmux -y
#Tmux Plugins
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
   mkdir -p "$HOME/.tmux"
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm >/dev/null 2>&1
   sudo cp -r ~/.tmux $home_user
fi
#.tmux.conf
curl -qfsSL "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/free-tiers/VPS/.scripts/.tmux.conf" -o "$HOME/.tmux.conf"
cp "$HOME/.tmux.conf" $home_user/.tmux.conf
tmux source-file "$HOME/.tmux.conf" >/dev/null 2>&1
#zsh configs
#.zshrc
curl -qfsSL "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/free-tiers/VPS/Google%20Colab/Utils/.zshrc" -o "$HOME/.zshrc"
dos2unix --quiet "$HOME/.zshrc" >/dev/null 2>&1 && sed -e '/^$/d' -e 's/[[:space:]]*$//' -i "$HOME/.zshrc" >/dev/null 2>&1
sudo cp $HOME/.zshrc $home_user
touch ~/.zsh_history
touch $home_user/.zsh_history
#Plugins
mkdir -p "$HOME/.zsh" && cd "$HOME/.zsh"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git >/dev/null 2>&1
git clone https://github.com/zsh-users/zsh-autosuggestions.git >/dev/null 2>&1
git clone https://github.com/marlonrichert/zsh-autocomplete.git >/dev/null 2>&1
sudo cp -r $HOME/.zsh $home_user
cd ~
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
#Source ~/.zshrc
$HOME/.go/bin/go install github.com/tomnomnom/anew@latest
echo "$(which zsh)" | $HOME/go/bin/anew -q "$HOME/.bashrc"
echo "$(which zsh)" | $HOME/go/bin/anew -q "$HOME/.profile"
echo " . ~/.zshrc" | $HOME/go/bin/anew -q "$HOME/.profile"
sudo cp $HOME/.bashrc $home_user
sudo cp $HOME/.profile $home_user
#Perms:
sudo find $home_user -type f -exec sudo chmod a+rwx {} \;
sudo find $home_user -type d -exec sudo chmod a+rwx {} \;
sudo chmod g-w $home_user/.zsh/zsh-autocomplete/Completions
sudo chmod g-w $home_user/.zsh/zsh-autocomplete
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
#Some Addons for aliases
#btop (alias htop)
 sudo eget aristocratos/btop --to "usr/local/bin/btop" && sudo chmod +xwr "usr/local/bin/btop"
#broot (alias tree)
 $HOME/.cargo/bin/cargo install --locked broot 
 #sudo eget Canop/broot --to "usr/local/bin/broot" && sudo chmod +xwr "usr/local/bin/broot"
 $HOME/.cargo/bin/broot --install
#duf (alias df)
 $HOME/.go/bin/go install -v github.com/muesli/duf@latest
#dog (alias dig)
 $HOME/.cargo/bin/cargo install --git "https://github.com/ogham/dog" dog --force
#tere (alias tree)
 sudo eget mgunyho/tere --asset gnu --to "usr/local/bin/tere" && sudo chmod +x "usr/local/bin/tere"
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
#This is duplicated to ensure redundency
#Source ~/.zshrc
go install github.com/tomnomnom/anew@latest
echo "$(which zsh)" | $HOME/go/bin/anew -q "$HOME/.bashrc"
echo "$(which zsh)" | $HOME/go/bin/anew -q "$HOME/.profile"
echo " . ~/.zshrc" | $HOME/go/bin/anew -q "$HOME/.profile"
sudo cp $HOME/.bashrc $home_user
sudo cp $HOME/.profile $home_user
#Perms:
sudo find $home_user -type f -exec sudo chmod a+rwx {} \;
sudo find $home_user -type d -exec sudo chmod a+rwx {} \;
sudo chmod g-w $home_user/.zsh/zsh-autocomplete/Completions
sudo chmod g-w $home_user/.zsh/zsh-autocomplete
#----------------------------------------------------------------------#
#Source
source "$HOME/.bashrc"
#EOF
