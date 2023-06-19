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
> echo -e "\nOS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | sed 's/"//g') ($(cat /etc/os-release | grep ID_LIKE | cut -d= -f2 | sed 's/"//g'))\nKernel: $(uname -r)\nCPU: $(grep -c ^processor /proc/cpuinfo) x $(grep -m1 "model name" /proc/cpuinfo | cut -d: -f2 ) @ $(grep -m1 "cpu MHz" /proc/cpuinfo | cut -d: -f2 | tr -d '[:space:]') MHz\nRAM: $(free -h | awk '/^Mem:/ {print $3 "/" $2}')\nDisk: $(df -h / | awk '/^\/dev\// {print $3 "/" $2 " (" $5 " used)"}')\n"
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
