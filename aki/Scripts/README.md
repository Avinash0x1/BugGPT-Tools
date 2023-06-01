#### About: Stand alone Scripts to quickly verify only select keys 
---
- [**aki-amass**](https://github.com/Azathothas/BugGPT-Tools/blob/main/aki/Scripts/aki-amass.sh) : ***Cut*** & ***Pasted*** fragment for `amass only`
> - **Install**: 
> ```bash
> sudo wget --quiet "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/aki/Scripts/aki-amass.sh" -O /usr/local/bin/aki-amass && sudo chmod +xwr /usr/local/bin/aki-amass
> ```
> - **Usage**
> ```bash
> !# Use how you normally use aki
> aki-amass -a <your/amass/config.ini> 
> If you do not provide any options, By default $HOME/.config/amass/config.ini will be used
>  To change it use:
>                   -a,  --amass     <your/amass/config.ini>
> Optional Flags:
>  -q,   --quota       Shows Usage Quota [https://github.com/the-valluvarsploit/APIkeyBeast] (Limited)                     
> ```
---
- [**aki-subfinder**](https://github.com/Azathothas/BugGPT-Tools/blob/main/aki/Scripts/aki-subfinder.sh) : ***Cut*** & ***Pasted*** fragment for `subfinder only`
> - **Install**: 
> ```bash
> sudo wget --quiet "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/aki/Scripts/aki-subfinder.sh" -O /usr/local/bin/aki-subfinder && sudo chmod +xwr /usr/local/bin/aki-subfinder
> ```
> - **Usage**
> ```bash
> !# Use how you normally use aki
> aki-subfinder -s <your/subfinder/provider-config.yaml> 
> If you do not provide any options, By default $HOME/.config/subfinder/provider-config.yaml will be used
> To change it use:
>                   -s,  --subfinder     <your/subfinder/provider-config.yaml>
> Optional Flags:
>  -q,   --quota       Shows Usage Quota [https://github.com/the-valluvarsploit/APIkeyBeast] (Limited)                  
> ```
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
> > tmpfile=$(mktemp /tmp/github.XXXXXX) && awk '/data_sources.GitHub.accountname/{flag=1;next} /^\[/{flag=0} flag && /apikey/{print $3}' "$HOME/.config/amass/config.ini" > "$tmpfile" && gitty -gh "$tmpfile" && rm "$tmpfile"
> > !#Gitlab
> > tmpfile=$(mktemp /tmp/gitlab.XXXXXX) && awk '/data_sources.GitLab.accountname/{flag=1;next} /^\[/{flag=0} flag && /apikey/{print $3}' "$HOME/.config/amass/config.ini" > "$tmpfile" && gitty -gl "$tmpfile" && rm "$tmpfile"
> > !##Or from $HOME/.config/subfinder/provider-config.yaml
> > !#Github
> > tmpfile=$(mktemp /tmp/github.XXXXXX) && yq eval '.github[]' "$HOME/.config/subfinder/provider-config.yaml" > "$tmpfile" && gitty -gh "$tmpfile" && rm "$tmpfile"
> > !#Gitlab
> > tmpfile=$(mktemp /tmp/gitlab.XXXXXX) && yq eval '.gitlab[]' "$HOME/.config/subfinder/provider-config.yaml" > "$tmpfile" && gitty -gh "$tmpfile" && rm "$tmpfile"
> > !#Or from a file:
> > gitty -gh github.tokens
> > !# cat github.tokens [1 per line]
> > ghp_072322d5fdfdfsaojdwqpdf0wefcsfafaffp
> > ghp_P4cWroYWsfasferoiefosN6pPIj4f73T2SOv
> > ghp_Y0ACjgJac0cF8a1WWsfde698edfsdafefeb7
> > ghp_XCssdqwefsafdfewfewfewgewgewsadMTKIj
> > ghp_VFosafeewrdafadffewffasfsafeffaaIiMG
> > ghp_V7BsfeefefafefafdsafafasdfafafaEY6T4
> > ```
> - **Usage**: 
> ```bash
> -gh,  --github           File containing Github Tokens [1 per line]
> -gl,  --gitlab           File containing Gitlab Tokens [1 per line]
> -o,   --output           Output dir/file
> -r,   --remove           Removes Invalid tokens & rewrite original
> !#Examples: 
>gitty -gh /your/github/tokens/file
>gitty -gl /your/gitlab/tokens/file
>```
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
> > Vshodan -s <(awk '/data_sources.Shodan.Credentials/{flag=1;next} /^\[/{flag=0} flag && /apikey/{print $3}' "$HOME/.config/amass/config.ini")
> > !##Or from $HOME/.config/subfinder/provider-config.yaml
> > Vshodan -s <(yq eval '.shodan[]' "$HOME/.config/subfinder/provider-config.yaml")
> > !##Or from a file:
> > Vshodan -s shodan.keys
> > !# cat shodan.keys [1 per line]
> > GIbxsdsdd9d496dwede9wedsdasdaWSd
> > gvmasewRJHe1337SdWew69sdsGtp3aS8
> > vmTqewsadsadweqwdsadsadsaftp3aS8
> > cHtPsqwewdsadweqJoDwwqdwsBxedQIw
> > GIbxsdsdd9d496dwede9wedsdasdaWSd
> > ```
> - **Usage**: 
> ```bash
> -s,  --shodan           File containing Shodan API Keys [1 per line]
> -q,  --quota            Check Quota || Usage
>
> !#Examples:
> Vshodan /your/shodan/apikeys/file
> !# -q --> Show Quota
> Vshodan -s /your/shodan/apikeys/file -q
>```
