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

# Prompt
PROMPT="%F{red}┌[%f%F{cyan}%m%f%F{red}]─[%f%F{yellow}%D{%H:%M-%d/%m}%f%F{red}]─[%f%F{magenta}%d%f%F{red}]%f"$'\n'"%F{red}└╼%f%F{green}$USER%f%F{yellow}$%f"

#Env variables
export GITHUB_USER="Azathothas" #Github Username, this is CaseSensitive
export GITHUB_REPO="Azathothas/GoogleVPS" #Your Gcloud Repo
export GITDIR="$HOME/GoogleVPS" # The main sync directory, usually, just $HOME/REPO, DO NOT INCLUDE USERNAME
export SCRIPTS="$HOME/.scripts"
export Tools="$HOME/Tools"
export tools="$HOME/Tools"
export TOOLS="$HOME/Tools"
export WORDLIST="$HOME/.wordlists"
current_dir=$(pwd)

#aliases
alias dir='dir --color=auto'
alias esort='for file in ./* ; do sort -u "$file" -o "$file"; done'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ls='ls -lh --color=auto'
alias osupdate='sudo apt-get update && sudo apt-get upgrade -y'
alias scb='xclip -selection c'
alias updatedb='sudo apt-get update >/dev/null 2>&1 && sudo apt-get install locate -y >/dev/null 2>&1 && sudo updatedb >/dev/null 2>&1'
alias vdir='vdir --color=auto'

#functions
#Donwload binaries from Github Releases
eget_dl()
{
   REPO=$(echo $1 | sed -e '/^$/d' -e 's/[[:space:]]*$//' | sed 's|https://github.com/||; s|\?.*||')
   BIN=$(echo $1 | sed -e '/^$/d' -e 's/[[:space:]]*$//' | sed 's|https://github.com/||; s|\?.*||' | awk -F '/' '{print $2}')

   #Option Args
      case "$2" in
      -g | -go | --go)
         sudo "$HOME/gopath/bin/eget" "$REPO/$BIN" --to "$HOME/gopath/bin/$BIN" && sudo chmod +xwr "$HOME/gopath/bin/$BIN"
         ;;
      -b | -bin | --bin)
         sudo "$HOME/gopath/bin/eget" "$REPO/$BIN" --to "/usr/local/bin/$BIN" && sudo chmod +xwr "/usr/local/bin/$BIN"
         ;;
      *)
         echo "Invalid option. Usage: eget_dl <repository-url> <-g/--go|-b/--bin>"
         ;;
   esac
}

#FZF Config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_BASE=$HOME/fzf
export FZF_DEFAULT_PATH="$HOME"
export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git'
#export FZF_DEFAULT_OPTS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'batcat --color=always --line-range :50 {}'"
export FZF_ALT_C_COMMAND='fdfind --type d . --hidden --exclude .git'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"

#zsh-interactive-cd [fzf + cd]
#source $HOME/.oh-my-zsh/plugins/zsh-interactive-cd
#zsh config
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Select all suggestion instead of top on result only
zstyle ':autocomplete:tab:*' insert-unambiguous yes
zstyle ':autocomplete:tab:*' widget-style menu-select
zstyle ':autocomplete:*' min-input 2
bindkey $key[Up] up-line-or-history
bindkey $key[Down] down-line-or-history
# Save type history for completion and easier life
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

#Some Custom QOL Changes
#GitSync, 
set +m
source "$HOME/.scripts/gsync.sh" >/dev/null 2>&1 &
cd $current_dir && clear
###
#EOF
