#!/usr/bin/env bash

#Check if github is accessable: 
if ! ping -c 2 github.com > /dev/null; then
  echo "Github.com is Inaccessible"
exit 1
fi

#Env variables
export GITHUB_USER="Azathothas" #Github Username, this is CaseSensitive
export GITHUB_EMAIL="AjamX101@gmail.com"
export GITHUB_REPO="Azathothas/GoogleVPS" #Your Gcloud Repo
export GITHUB_TOKEN="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" # Change this to "$Token_of_Your_Github_Repo"
export GITDIR="$HOME/GoogleVPS" # The main sync directory, usually, just $HOME/REPO, DO NOT INCLUDE USERNAME
export current_dir=$(pwd) #DO NOT CHANGE THIS

#Deps
go install -v github.com/tomnomnom/anew@latest 2>/dev/null

#Set Git configs
cd "$GITDIR"
git config --global user.name "$GITHUB_USER"
git config --global user.email "$GITHUB_EMAIL"
#Mark Safe
git config --global --add safe.directory "$GITDIR"
#Set Repo
git remote set-url origin "https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_REPO.git"
#Pull changes and Reset HEAD
cd "$HOME/$GITDIR" && git fetch --all >/dev/null 2>&1 && git reset --hard origin/main >/dev/null 2>&1 && git clean -fd >/dev/null 2>&1 && git pull --force origin main >/dev/null 2>&1
#Set Dirs
mkdir -p "$GITDIR/HOME/"
#Copy Configs
cp -r "$HOME/.config" "$GITDIR/HOME/"
#Copy DotFiles
find "$HOME" -maxdepth 1 -type f -name ".*" -exec cp {} "$GITDIR/HOME/" \;
#Check if any large files:
find "$GITDIR" -type f -size +90M | sed 's|^./||' | anew -q "$GITDIR/.gitignore"
#Push gitignore
git add "$GITDIR/.gitignore" && git commit -m "Ignore Large Files [gSync]" && git push --force -u origin main
#Update README.md
echo -e "$(uname -a) : [Last: $(date)]" > "$GITDIR/README.md"
#Push Eeverything Else
git add --all --verbose && git commit -m "Gcloud [Git-Push]" && git push --force -u origin main
#EOF
