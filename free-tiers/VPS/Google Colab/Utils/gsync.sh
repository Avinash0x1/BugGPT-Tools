#!/usr/bin/env bash

#--------------------------------------------------#
###THIS IS EXAMPLE ONLY###
###MAKE YOUR OWN CHANGES##
#--------------------------------------------------#

#Check if github is accessable: 
if ! ping -c 2 github.com > /dev/null; then
  echo "Github.com is Inaccessible"
exit 1
fi

#Env variables
HOME_USER=$(ls -d /home/*/) && export HOME_USER="$HOME_USER" #Do NOT EDIT THIS
export GITHUB_USER="Azathothas" #Github Username, this is CaseSensitive
export GITHUB_EMAIL="AjamX101@gmail.com"
export GITHUB_REPO="Azathothas/GoogleColab" #Your Gcolab Repo
export GITHUB_TOKEN="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" # Change this to "$Token_of_Your_Github_Repo"
export GITDIR="$HOME_USER/GoogleColab" # The main sync directory, usually, just $HOME/REPO, DO NOT INCLUDE USERNAME
export current_dir=$(pwd) #DO NOT CHANGE THIS

#Deps
go install -v github.com/tomnomnom/anew@latest 2>/dev/null
cp $(which anew) /usr/local/bin/anew 

#Set Git configs
cd "$GITDIR"
git config --global user.name "$GITHUB_USER"
git config --global user.email "$GITHUB_EMAIL"
#Mark Safe
git config --global --add safe.directory "$GITDIR"
#Set Repo
git remote set-url origin "https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_REPO.git"
#Pull changes and Reset HEAD
cd "$HOME_USER/$GITDIR" && git fetch --all >/dev/null 2>&1 && git reset --hard origin/main >/dev/null 2>&1 && git clean -fd >/dev/null 2>&1 && git pull --force origin main >/dev/null 2>&1
#Set Dirs
mkdir -p "$GITDIR/HOME/"
#Copy Configs
cp -r "$HOME_USER/.config" "$GITDIR/HOME/"
#Copy & Merge DotFiles
cat "$HOME_USER/.bash_hsitory" | anew -q "$GITDIR/.bash_hsitory" && cat "$GITDIR/.bash_hsitory" | anew -q "$HOME_USER/.bash_hsitory"
sudo cat /root/.bash_hsitory | sudo tee -a "$GITDIR/.bash_hsitory"
cat "$HOME_USER/.zsh_hsitory"  | anew -q "$GITDIR/.zsh_hsitory" && cat "$GITDIR/.zsh_hsitory" | anew -q "$HOME_USER/.zsh_hsitory"
sudo cat /root/.bash_hsitory | anew -q "$HOME_USER/.zsh_hsitory"
#Current
history | awk '{$1=""; print substr($0,2)}' | anew -q "$HOME_USER/.shell_history" 
cat "$HOME_USER/.shell_history" | anew -q "$HOME_USER/.bash_hsitory"
cat "$HOME_USER/.shell_history" | sudo tee -a "/root/.bash_hsitory"
cat "$HOME_USER/.shell_history" | anew -q "$HOME_USER/.zsh_hsitory"
cat "$HOME_USER/.shell_history" | sudo tee -a -q "/root/.zsh_hsitory"
#Check if any large files:
find "$GITDIR" -type f -size +90M | sed 's|^./||' | anew -q "$GITDIR/.gitignore"
#Push gitignore
git add "$GITDIR/.gitignore" && git commit -m "Ignore Large Files [gSync]" && git push --force -u origin main
#Update README.md
echo -e "$(uname -a) : [Last: $(date)]" > "$GITDIR/README.md"
#Push Eeverything Else
git add --all --verbose && git commit -m "Gcloud [Git-Push]" && git push --force -u origin main
#EOF
