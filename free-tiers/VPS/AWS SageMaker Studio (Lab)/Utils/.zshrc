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

#PATHS
export PATH=$HOME/.conda/envs/studiolab/bin:$HOME/.local/bin:/opt/conda/condabin:/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.cargo/bin:$HOME/go:$HOME/go/bin:$HOME/.go:$HOME/.go/bin:$HOME/bin/:$PATH


#Env variables
export GITHUB_USER="Azathothas" #Github Username, this is CaseSensitive
export GITHUB_REPO="Azathothas/Sagemaker" #Your Sagemaker Repo
export GITDIR="$HOME/Sagemaker" # The main sync directory, usually, just $HOME/REPO, DO NOT INCLUDE USERNAME
export SCRIPTS="$GITDIR/.scripts" # Misc Scripts, is backed up
export Tools="$HOME/Tools" # Not backed up
export tools="$HOME/Tools"
export TOOLS="$HOME/Tools"
export WORDLIST="$HOME/.wordlists" # Also not backed up
export SHELL=zsh #have to manually do this
current_dir=$(pwd)

#aliases
alias bat='batcat'
alias dir='dir --color=auto'
alias esort='for file in ./* ; do sort -u "$file" -o "$file"; done'
alias egrep='egrep --color=auto'
alias fdfind='fd'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ls='ls -lh --color=auto'
alias scb='xclip -selection c'
alias tree='br -sdp'
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
source $HOME/.local/share/zsh-autosuggestions.zsh
source $HOME/.local/share/zsh-autocomplete.plugin.zsh
source $HOME/.local/share/zsh-syntax-highlighting.zsh
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
#Prompt
eval "$(starship init zsh)"
# Set prompt
starship preset pure-preset -o ~/.config/starship.toml
cd $current_dir && clear
###
#EOF
