```bash
  ╔╗  ╔╗
╔╗╠╬═╦╣╠╦╦╗
║╚╣║║║║═╣║║ : Crawl >> Links || Discover >> Endopints >> Params || Scan >> JavaScript >> Secrets || Analyze >> Everything
╚═╩╩╩═╩╩╬╗║
        ╚═╝
```
### About:
Revamped Version of [**mux0x/cold.sh**](https://github.com/mux0x/cold.sh) ; A Fancy Wrapper around [**gau**](https://github.com/lc/gau), [**github-endpoints**](https://github.com/gwen001/github-search/blob/master/github-endpoints.py), [**gospider**](https://github.com/jaeles-project/gospider), [**hakrawler**](https://github.com/hakluke/hakrawler), [**JSA**](https://github.com/w9w/JSA), [**katana**](https://github.com/projectdiscovery/katana), [**subJS**](https://github.com/lc/subjs), [**waymore**](https://github.com/xnl-h4ck3r/waymore) & [**xnLinkFinder**](https://github.com/xnl-h4ck3r/xnLinkFinder) to find as much Links, Endpoints & Params as possible on a single `$URL`.

### **Installation**:
 - **Bash**: 
```bash
sudo wget https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/linky/linky.sh -O /usr/local/bin/linky && sudo chmod +xwr /usr/local/bin/linky && linky --help
``` 
### Configuration:
 1. First run to initialize linky (Installs & Sets up everything) : `linky --init` 
 2. [Configure](https://github.com/xnl-h4ck3r/waymore#configyml) your **URLSCAN_API_KEY** in `$HOME/Tools/waymore/config.yml`
 3. Add your [**`Github Tokens`**](https://docs.github.com/en/enterprise-server@3.4/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) in `$HOME/.config/.github_tokens` [1 per line]

### Usage:
`linky --help`
```bash

  ╔╗  ╔╗
╔╗╠╬═╦╣╠╦╦╗
║╚╣║║║║═╣║║
╚═╩╩╩═╩╩╬╗║
        ╚═╝

➼ Usage: linky -u <url> -o /path/to/outputdir -gh <github_token> <other-options, see --help

Extended Help
-u,       --url              Specify the URL  to scrape (Required )
-o,       --output_dir       Specify the directory to save the output files (Required)
-h,       --headers          Specify additional headers or cookies (use "", optional)
-d,       --deep             Specify if Gospider Hakrawler Katana & XnLinkfinder should run with depth 5.(Slow)
-ctmp,    --clean-tmp        Cleans /tmp/ files after run
-curls,   --clean-urls       Removes noisy junk urls (godeclutter | urless)
-params,  --discover-params  Runs Arjun for parameter discovery (Basic & Slow)
-fl,      --flex-scope       Run linky with normal scope but include CDNs
-wl,      --wildcard         Run linky with wildcard (.*) scope
-up,      --update           Update linky

(Not Required if $HOME/.config/.github_tokens exists)
-gh,      --github_token     Specify manually: ghp_xxx

(Uses Entropy Scanning : Massive Output, Resource-Intensive & Slow)
-secrets, --scan-secrets     Runs gf-secrets + TruffleHog

(Only run on a fresh Install)
-init,    --init             Initialize ➼ linky by dry-running it against example.com


Example Usage: 
Basic: 
linky --url https://example.com --output_dir /path/to/outputdir --github_token ghp_xyz

Extensive: 
linky --url https://example.com --output_dir /path/to/outputdir --github_token ghp_xyz --headers "Authorization: Bearer token; Cookie: cookie_value" --deep --discover-params --wildcard

Tips: 
➼ Include UrlScan API keys in $HOME/Tools/waymore/config.yml to find more links
➼ Include multiple github_tokens in $HOME/.config/.github_tokens to avoid rate limits
➼ --scan-secrets produces massive files (Several GBs). So TuffleHog is run by default. Best run with --deep
➼ Don't Worry if your Terminal Hangs for a bit.. It's a feature not a bug
```

### Afterthoughts:
 - **Linky** is desgned and coded to be used on a **single** **`$URL`** | **`$Domain`** at **one time**.
    > If for ***some reason*** (not much point, **you will be hit with rate limits, performance issues and more**) , you want linky to go brrrr....
     - Install [interlace](https://github.com/codingo/Interlace) and then: 
        ```bash
        #create a directory (for convenience)
        mkdir -p /tmp/linky
        #Don't change values for -u & -o, can change others. Linky go brrrrr
        interlace -tL ./many-urls.txt -c "linky -u _target_ -o /tmp/linky/_cleantarget_-linky <other-linky-options> 2>&1" -threads 69
        #If you really ever did do this, don't be surprised if it takes toooooooo long
        ```
