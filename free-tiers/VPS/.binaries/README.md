#### Enumerate Info :
> ```bash
> !# Get Model Arch 
> !# x86_64 (i386) || amd_64 etc
>  uname -m
>
> !# OS Info
>  cat /etc/os-release 
>
> !# Pure bash neofetch
> echo -e "\nHostname: $(hostname)\nUser: $(whoami) $([ "$EUID" -ne 0 ] && echo '(NOT root)' || echo '(root)')\nRoot: $(grep "^root:" /etc/passwd | cut -d: -f1 2>/dev/null && echo '#Exists in /etc/passwd')\nSudo: $(command -v sudo >/dev/null 2>&1 && echo 'Yes' $(sudo grep -E '^\s*[^#]*\s+ALL\s*=\s*\(\s*ALL\s*\)\s+NOPASSWD:' /etc/sudoers >/dev/null 2>&1 && echo '(Passwordless)') || echo 'Not Installed/Available')\nUptime: $(uptime -p 2>/dev/null || uptime | awk '{sub(/,$/, "", $3); print $3}')\nOS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | sed 's/"//g') ($(cat /etc/os-release | grep ID_LIKE | cut -d= -f2 | sed 's/"//g'))\nArchitecture: $(uname -m)\nKernel: $(uname -r)\nPackage Manager: $(cmds=$(for cmd in apk apt brew conda dnf emerge eopkg flatpak guix installer nix pacman pacman4 pisi pkg pkgutil port snap swupd tdnf xbps yum zypper; do command -v "$cmd" >/dev/null && printf "%s," "$cmd"; done) ; echo "${cmds%,}")\nSystem: $(ps -p 1 -o comm=)\nShell: $(echo "$SHELL")\nCPU: $(grep -c ^processor /proc/cpuinfo) x $(grep -m1 "model name" /proc/cpuinfo | cut -d: -f2 ) @ $(grep -m1 "cpu MHz" /proc/cpuinfo | cut -d: -f2 | tr -d '[:space:]') MHz\nRAM: $(free -h | awk '/^Mem:/ {print $3 "/" $2}')\nDisk: $(df -h 2>/dev/null | awk '/^\/dev\// {if (line) line = line " | "; line = line $1"("$6")" " " $3 "/" $2 " (" $5 " used)"} END {print line}')\nIPv4: $(curl -qfsSL "http://ipv4.whatismyip.akamai.com" 2>/dev/null || echo 'Failed, Maybe no Curl?')\nIPv6: $(curl -qfsSL --ipv6 "http://ipv6.whatismyip.akamai.com" 2>/dev/null || echo 'Failed to Connect')\nCurl: $(command -v curl >/dev/null 2>&1 && which curl || echo '(Not Installed)')\nWget: $(command -v wget >/dev/null 2>&1 && which wget || echo '(Not Installed)')\nGoLang: $(command -v go >/dev/null 2>&1 && go version || echo '(Not Installed)')\nPython(pip): $(command -v pip >/dev/null 2>&1 && pip -V || echo '(Not Installed, maybe try pip3)')\nRust(Cargo): $(command -v cargo >/dev/null 2>&1 && cargo -V || echo '(Not Installed)')\n"
> ```


#### Scenarios :
> - **ROOT Access**
> > **Assumptions**
> > > 1. You can **run** **`apt`** or ***equivalent pkg managers***
> > > 2. You can **edit** **`/etc/apt/sources.list`** or ***equivalent***
> ---
> - ##### **Debian**
> ```bash
> !# Use/append sudo if passwordless sudo is not configured
> !# Add Parrot's Sources.list : https://github.com/Azathothas/BugGPT-Tools/blob/main/free-tiers/VPS/.scripts/debian_parrot_sources.list
> !# The main sources.list is enough 
>  echo 'deb [trusted=yes] https://deb.parrot.sh/parrot parrot main contrib non-free' >> /etc/apt/sources.list 
> !# Update apt
>  apt update --allow-unauthenticated
> !# Install curl, gnupg, openssl & wget (Requirements for Pretty much everything else)
>  apt install apt-transport-https -y --allow-unauthenticated
>  apt install ca-certificates -y --allow-unauthenticated
>  apt install curl -y --allow-unauthenticated
>  apt install gnupg -y --allow-unauthenticated
>  apt install openssl -y --allow-unauthenticated
>  apt install wget -y --allow-unauthenticated
> !# Optionally also Install sudo, if it's not
>  apt install sudo -y --allow-unauthenticated
>
> !# At this point you can Install & Use:
> !# Tunshell : https://tunshell.com/
> !# TailScale : https://github.com/Azathothas/BugGPT-Tools/tree/main/free-tiers/VPN%20(Tunnels%20%26%20Proxies)/Tailscale#1-create-a-tailscale-account--httpslogintailscalecomstart 
> !# Make sure to use --tun=userspace-networking when running TailScale on VMS
>
> !# Optionally Install Addons
>  apt install bzip2 coreutils colordiff cron dnsutils dos2unix iputils-arping iputils-clockdiff iputils-tracepath jq locate net-tools moreutils nano openssh-client openssh-server pkg-config readline-common software-properties-common ssh ssh-tools tree xsltproc zip -y --ignore-missing --allow-unauthenticated
> !# Optionally Resolve Broken Pkgs
>  dpkg --configure -a
>  apt --fix-broken install -y
>  apt autoremove -y
> 
> !# This is completetly Optional, as you now can use Curl for anything anyway
> !# Using curl, fetch and append all Parrot's sources 
> !# Will also remove the need to use `--allow-unauthenticated`
>  curl -qfsSL "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/free-tiers/VPS/.scripts/debian_add_parrot_sources.list.sh" | bash
>
> !# Install Python3: Pip+pipx+pyenv
>  apt install python3 python3-pip python3-aiohttp python3-certbot-apache python3-requests python3-matplotlib python3-keras python3-opencv python3-django python3-flask -y --ignore-missing --allow-unauthenticated
>  python3 -m pip install pipx 
>  pip3 install dbus-python PyQt5 db-sqlite3 psycopg2-binary readline whitenoise --upgrade
>  pip3 install --upgrade pip
>
> !# Install Golang
>  bash <(curl -qfsSL https://git.io/go-installer)
>  find $HOME -maxdepth 1 -name "go*.gz" -type f -delete
>  export PATH=$HOME/.go/bin:$PATH
>  export PATH=$HOME/go/bin:$PATH  
>  $HOME/.go/bin/go install github.com/zyedidia/eget@latest
>  # This is an alt: curl -qfsSL "https://zyedidia.github.io/eget.sh" | bash && mv ./eget /usr/local/bin/eget
> 
> !# Install rust
>  curl -qfsSL "https://sh.rustup.rs" | bash /dev/stdin -y 
>  export PATH=$HOME/.cargo/bin:$PATH
>  export PATH=$HOME/.cargo/env:$PATH
>
> !# Some BenchMarks (Caution: May get Banned)
>  # speedtest-go : https://github.com/showwin/speedtest-go
>  eget showwin/speedtest-go --to /usr/local/bin/speedtest-go && chmod +x /usr/local/bin/speedtest-go
>  speedtest-go
>  # speedtest-cli : https://github.com/sivel/speedtest-cli
>  pip3 install speedtest-cli
>  speedtest-cli
>  # Sys Benchmarks (Quick)
>  curl -qfsSL "https://bench.sh" | bash
>  # Sys Benchmarks (Extensive)
>  curl -qfsSL "https://raw.githubusercontent.com/masonr/yet-another-bench-script/master/yabs.sh" | bash -s -- -i
> ```
> ---
> 
> You are in a very limited environment with limited access (either no root, or default `apt install xyz` doesn't do it)

> 1. Via pip (python)
```bash
```
**`curl`** : https://github.com/moparisthebest/static-curl/releases

**`Misc`** : https://github.com/ryanwoodsmall/static-binaries

---
> - #### References:
> > - https://github.com/slyfox1186/script-repo
