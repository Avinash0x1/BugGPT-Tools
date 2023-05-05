#### About: Stand alone Scripts to quickly verify only select keys 
---
- [**Gitty**](https://github.com/Azathothas/BugGPT-Tools/blob/main/aki/Scripts/gitty.sh) : Verify **GitHub** || **Gitlab** **`tokens`**
> - **Install**: 
> ```bash
> sudo wget --quiet "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/aki/Scripts/gitty.sh" -O /usr/local/bin/gitty && sudo chmod +xwr /usr/local/bin/gitty
> ```
> - Format:
> > - (1 per line) : Example
> > ```bash
> > !## Direct from $HOME/.config/amass/config.ini
> > !#Github
> > awk '/data_sources.GitHub.accountname/{flag=1;next} /^\[/{flag=0} flag && /apikey/{print $3}' "$HOME/.config/amass/config.ini"
> > !#Gitlab
> > awk '/data_sources.GitLab.accountname/{flag=1;next} /^\[/{flag=0} flag && /apikey/{print $3}' "$HOME/.config/amass/config.ini"
> > !##Or from $HOME/.config/subfinder/provider-config.yaml
> > !#Github
> > yq eval '.github[]' "$HOME/.config/subfinder/provider-config.yaml"
> > !#Gitlab
> > yq eval '.gitlab[]' "$HOME/.config/subfinder/provider-config.yaml"
> > !#Or from a file:
> > cat github.tokens
> > ghp_072322d5fdfdfsaojdwqpdf0wefcsfafaffp
> > ghp_P4cWroYWsfasferoiefosN6pPIj4f73T2SOv
> > ghp_Y0ACjgJac0cF8a1WWsfde698edfsdafefeb7
> > ghp_XCssdqwefsafdfewfewfewgewgewsadMTKIj
> > ghp_VFosafeewrdafadffewffasfsafeffaaIiMG
> > ghp_V7BsfeefefafefafdsafafasdfafafaEY6T4
> > ```
> - **Usage**: 
> ```bash
>gitty -gh /your/github/tokens/file
>gitty -gl /your/gitlab/tokens/file
>```
> - AutoVerify Gitlab tokens & Save:
> ```bash
> export gitlab_file=/your/gitlab/file
> grep -v -f <(gitty -gl $gitlab_file | ansi2txt | grep glpat | awk '{print $6}' | sort -u) $gitlab_file | tee $gitlab_file-valid
> !# Bit Fancy
> grep -v -f <(gitty -gl $gitlab_file | ansi2txt | grep glpat | awk '{print $6}' | sort -u) $gitlab_file | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//' | sed '/^$/d' | grep "^glpat" | tee $gitlab_file-valid && codium $gitlab_file-valid
> ```
> - Prompt for GiHub tokens, verify and auto save:
> ```bash
> export github_file=/your/github/file
> grep -v -f <(gitty -gh $github_file | ansi2txt | grep ghp | awk '{print $6}' | sort -u) $github_file | tee $github_file-valid
> !# Bit Fancy 
> grep -v -f <(gitty -gh $github_file | ansi2txt | grep ghp | awk '{print $6}' | sort -u) $github_file | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//' | sed '/^$/d' | grep "^glpat" | tee $github_file-valid && codium $github_file-valid
> ```
---
- [**Vshodan**](https://github.com/Azathothas/BugGPT-Tools/blob/main/aki/Scripts/vshodan.sh) : Verify & Print **Quota usage** for **Shodan** **`API Keys`**
> - **Install**: 
> ```bash
> sudo wget --quiet "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/aki/Scripts/vshodan.sh" -O /usr/local/bin/Vshodan && sudo chmod +xwr /usr/local/bin/Vshodan
> ```
> - Format:
> > - (1 per line) : Example
> > ```bash
> > !##Direct from $HOME/.config/amass/config.ini
> > awk '/data_sources.Shodan.Credentials/{flag=1;next} /^\[/{flag=0} flag && /apikey/{print $3}' "$HOME/.config/amass/config.ini"
> > !##Or from $HOME/.config/subfinder/provider-config.yaml
> > yq eval '.shodan[]' "$HOME/.config/subfinder/provider-config.yaml"
> > !##Or from a file:
> > cat shodan.keys
> > GIbxsdsdd9d496dwede9wedsdasdaWSd
> > gvmasewRJHe1337SdWew69sdsGtp3aS8
> > vmTqewsadsadweqwdsadsadsaftp3aS8
> > cHtPsqwewdsadweqJoDwwqdwsBxedQIw
> > GIbxsdsdd9d496dwede9wedsdasdaWSd
> > ```
> - **Usage**: 
> ```bash
>Vshodan /your/shodan/apikeys/file
># -q --> Show Quota
>Vshodan -s /your/shodan/apikeys/file -q
>```
