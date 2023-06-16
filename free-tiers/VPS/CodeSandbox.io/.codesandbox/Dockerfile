#----------------------------------------------------------------------#
# INFO:
#-----#
# CodeSandbox supports debian & ubuntu based images
# The project will be mounted in /workspace by default
# Every new shell will open inside the built container
# Pre-Installed : `zsh` (incl nerdfonts), `git` and `docker`
#ENVS (for Reference ONLY)
#------------------------#
# export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH
#USER=root
#HOME=/root
#Golang#
#GOPATH=/root/go
#GOROOT=/root/.go
#GOBIN=/root/go/bin/
#python/pip#
#BIN=/usr/local/bin/
#Rust#
#CARGO_PATH=/root/.cargo
#CARGO_BIN=/root/.cargo/bin
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Import Base
FROM ubuntu
# Update Core
RUN apt update -y && apt upgrade -y
RUN apt install doas sudo -y
RUN apt install systemd -y
# Install Deps (Bare Minimals)
# Golang
RUN curl -qfsSL "https://git.io/go-installer" | bash 
RUN rm $HOME/go*.gz >/dev/null 2>&1
# Python
RUN apt update && apt install -y python3 python3-pip
# Rust
RUN curl -qfsSL "https://sh.rustup.rs" | bash /dev/stdin -y
# Remove Bloatwares
#Uninstall_oh_my_zsh (Still leaves leftover crap)
#Better to just do this:
RUN rm -rf ~/.oh-my-zsh >/dev/null 2>&1
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Install Addons (Core)
#Core Utils
RUN apt install apt-transport-https autoconf bzip2 ca-certificates coreutils cron -y --ignore-missing
RUN apt install curl dconf-cli dkms dnsutils dos2unix htop moreutils net-tools -y --ignore-missing
RUN apt install iputils-ping iputils-arping iputils-clockdiff iputils-tracepath -y --ignore-missing
RUN apt install openssh-client openssh-server ssh ssh-tools software-properties-common -y --ignore-missing
RUN apt install jq locate nano nmap unzip uuid-runtime wget xclip xsltproc xz-utils zip -y --ignore-missing
RUN apt install libpcap-dev -y
#Addons
#eget
RUN /root/.go/bin/go install github.com/zyedidia/eget@latest
#Script
RUN curl -qfsSL "test" -o /tmp/setup_main.sh
#TailScale
RUN curl -qfsSL "https://tailscale.com/install.sh" | bash
RUN tailscaled --tun=userspace-networking --socks5-server=localhost:1055 -- tailscaled --tun=userspace-networking --socks5-server=localhost:1055 --outbound-http-proxy-listen=localhost:1055 -no-logs-no-support -no-logs-no-support >/dev/null 2>&1 &
# ONLY INCLUDE EPHEMERAL Auth_key [Settings >> Keys >> Generate Auth Key >> Ephemeral (enabled)]
# Keys :  https://login.tailscale.com/admin/settings/keys
# DO NOT INCLUDE REUSABLE KEYS
# CodeSandboxes are PUBLIC
RUN tailscale up --ssh --hostname="codesandbox-debian-11-minimal" --authkey=tskey-auth-kfo1NE3CNTRL-Kv3Bqy9NzuP9cBknsCt7uPHLi6kZpBkuQ
#----------------------------------------------------------------------#
