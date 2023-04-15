 ```bash
       ╭╮
╭┳┳┳━┳━┫╰┳┳╮
┃>W┃e┫e┫b┃u┃ : Attack Surface Discovery >> whois || whatis || whereis  
╰━━┻━┻━┻━┻━╯
```
### About:
A Fancy Wrapper around [**ASN**](https://github.com/nitefood/asn) | [**whris**](https://github.com/harakeishi/whris) | [**wtfis**](https://github.com/pirxthepilot/wtfis) | [**Humble**](https://github.com/rfc-st/humble) | [**DNSdumpster**](https://github.com/nmmapper/dnsdumpster) | [**nmap**](https://github.com/nmap/nmap) | [**linky**](https://github.com/Azathothas/BugGPT-Tools/tree/main/linky) & more to find as much Info & Data as possible on a single `$DOMAIN`.

### **Installation**:
 - **Bash**: 
```bash 
sudo wget https://github.com/Azathothas/BugGPT-Tools/blob/main/weebu/weebu.sh -O /usr/local/bin/weebu && sudo chmod +xwr /usr/local/bin/weebu && weebu --init
``` 

### Configuration:
 1. [Configure](https://github.com/owasp-amass/amass/blob/master/examples/config.ini) your **Passive Total** , **Shodan** & **VirusTotal** **`API KEYS`** in `$HOME/.config/amass/config.ini`
 2. Add your [**`Github Tokens`**](https://docs.github.com/en/enterprise-server@3.4/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) in `$HOME/.config/.github_tokens` [1 per line]
 3. After running **`weebu --init`**, your `$HOME/.env.wtfis` should be populated like shown below:
    > Just add **`IP2WHOIS_API_KEY`** and run `sudo chmod +xwr $HOME/.env.wtfis`
    ```bash
    # Example $HOME/.env.wtfis file
    # Don't forget to chmod 400!
     IP2WHOIS_API_KEY=#https://www.ip2whois.com --> https://www.ip2location.io/sign-up -->#API Key --> https://www.ip2location.io/dashboard
     SHODAN_API_KEY=#Auto added from $HOME/.config/amass/config.ini
     VT_API_KEY=#Auto added from $HOME/.config/amass/config.ini
     PT_API_KEY=#Auto added from $HOME/.config/amass/config.ini
     PT_API_USER=#Auto added from $HOME/.config/amass/config.ini
     #Uses shodan, no colors and print results in 1 column
     WTFIS_DEFAULTS=-s -1 -n
    ```
### Usage:
`weebu --help`
```bash
       ╭╮
╭┳┳┳━┳━┫╰┳┳╮
┃>W┃e┫e┫b┃u┃
╰━━┻━┻━┻━┻━╯

➼ Usage: weebu -u <url or (-d <domain>)> -o /path/to/outputdir <other-options, see --help>

Extended Help
-u,       --url              Specify the URL (Required else specify domain (--domain))
-d,       --domain           Specify the domain/subdomain (without http|https)
-o,       --output           Specify the directory to save the output files (Required)
-tu,      --tcp-udp          Use nmap (TCP + UDP) super slow
-linky,   --linky            Runs linky (https://github.com/Azathothas/BugGPT-Tools/tree/main/linky)
-wl,      --wildcard-scope   Use wildcard (.*) scope to not miss anything
-h,       --headers          Specify additional headers or cookies (use "", optional)
-up,      --update           Update weebu

(Not Required if not running --linky)
 or if $HOME/.config/.github_tokens exists
-gh,      --github_token     Specify manually: ghp_xxx

(Only run on a fresh Install)
-init,    --init             Initialize ➼ weebu by dry-running it against example.com

Example Usage: 
Basic: 
weebu --url https://example.com --output /path/to/outputdir --linky --wildcard-scope

Extensive: 
weebu --url https://example.com --output /path/to/outputdir --github_token ghp_xyz --headers "Authorization: Bearer token; Cookie: cookie_value" --linky --wildcard-scope --tcp_udp

Tips: 
➼ Specify VirusTotal , PassiveTotal & Shodan API KEYS in $HOME/.config/amass/config.ini if you haven't already!
➼ Include IP2WHOIS_API_KEY in $HOME/.env.wtfis to find more info
➼ Include multiple github_tokens in $HOME/.config/.github_tokens to avoid rate limits
➼ Don't Worry if your Terminal Hangs for a bit.. It's a feature not a bug
```
