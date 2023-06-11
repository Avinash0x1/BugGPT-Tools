- #### [Cloud Colab](https://colab.research.google.com)
> - [**BenchMarks**](https://github.com/Azathothas/BugGPT-Tools/tree/main/free-tiers/VPS/Google%20Colab#customization--qol-changes)
> - [**About**](https://github.com/Azathothas/BugGPT-Tools/tree/main/free-tiers/VPS/Google%20Colab#about-intro--setup)
> - [**Setup**](https://github.com/Azathothas/BugGPT-Tools/tree/main/free-tiers/VPS/Google%20Colab#setup)
> - [**Configuraton**](https://github.com/Azathothas/BugGPT-Tools/tree/main/free-tiers/VPS/Google%20Colab#customization--qol-changes)
> - [**SSH**](https://github.com/Azathothas/BugGPT-Tools/tree/main/free-tiers/VPS/Google%20Colab#ssh)
> - [**RDP**](https://github.com/Azathothas/BugGPT-Tools/blob/main/free-tiers/VPS/Google%20Colab/README.md#rdp)
---
> - #### About: [<img src="https://github.com/Azathothas/BugGPT-Tools/assets/58171889/7737d632-1cf6-46a0-8b3a-644482b9022d" width="30" height="30">**Intro** & **Setup**](https://www.youtube.com/watch?v=g0xu9DA4gDw)
> [![Google Colab Tutorial for Beginners](https://img.youtube.com/vi/g0xu9DA4gDw/maxresdefault.jpg)](https://www.youtube.com/watch?v=g0xu9DA4gDw)
> 
> - [**Legalities & Warnings**](https://research.google.com/colaboratory/faq.html)
> 
> ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/d37139c1-5f59-4613-a043-82839d39b5ee)
>
> > ➼ **Limits**
> > 
> > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/ff3c76fb-cad8-47a6-a6f0-1ad5b42d3b93)
> > 
> > ```yaml
> > Quota                           : Unlimited # You can just reset & run again 
> > Interactive Session Limit       : 12 Hr [Auto Terminates and Loses Persistance] # Interactive = You continously use the Shell Environment
> > Non Interactive Session Limit   : 20Mins ~ 1 Hr [Auto Terminates and Loses Persistance] # Non Interactive = You do nothing & Shell Environment is Idle
> > ```
> > ➼ **Specs**
> > 1. [<img src="https://github.com/Azathothas/BugGPT-Tools/assets/58171889/7737d632-1cf6-46a0-8b3a-644482b9022d" width="30" height="30">**No `Credit Card`** || **No `Free Trial`**](https://www.youtube.com/watch?v=g0xu9DA4gDw)
> > [![Limits & Comparision](https://img.youtube.com/vi/em9vpO-YS3Y/maxresdefault.jpg)](https://www.youtube.com/watch?v=em9vpO-YS3Y)
> > 
> > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/c99801e7-0db0-4936-8852-6bdcc545b6e9)
> > 
> > > ```YAML
> > > CPU                  : 2 Cores (Intel / AMD) ~ 2 GHZ
> > > GPU                  : Tesla T4 (~ 16 GB | If Lucky) /K80 (~ 12 GB If Unlucky) | tGPU  # Not Always Available (If Really unlucky): https://www.kaggle.com/general/251969
> > > RAM                  : 12 GB
> > > Init                 : docker-init # NOT Privileged (ps -p 1 -o comm=)
> > > Storage (Temp)       : ~ 150 GB # Everything is purged & deleted 
> > >   Usable             : ~ 80-90 GB # Allocated through different Partitions
> > > Networking           : Limited
> > >   IPv4               : Yes
> > >   IPv6               : No
> > >   Benchmarks         : See #Benchmarks Below
> > > Cron                 : Yes # Limited to the 12Hr Window ofc
> > > ```
> > > - **GPU**
> > > 
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/feb06f9e-db8f-4b1b-8b78-6b7fab0af049)
> > >
> > > - **Storage**
> > > 
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/9f1b634f-47d3-413c-bbd6-9f22e0be97e9)
> > > 
----
> - #### Setup:
> ![tailscale authenticate new page terminal](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/0c0eb3ac-83d3-498a-92fa-9fdf68a05d4a)
![tailscale authenticate new page browser](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/6df8d091-a7db-42ec-861b-cb50db0ae414)
![talscale sshed](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/b91295d3-8be7-44bb-87eb-970288dbfc52)

> > - #### **RDP**
> > > - [**Chrome Remote Desktop**](https://remotedesktop.google.com)
> > > > - Use `Chromium Based Browser` [`NOT FireFox`]
> > > > 1. **Right Click** [`Open In NewTab`] --> <a href="https://colab.research.google.com/github/Azathothas/BugGPT-Tools/blob/main/free-tiers/VPS/Google%20Colab/VPS.ipynb" target="_parent"><img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/></a>
> > > > 2. `RUN` **Create User** (If prompted, `RUN ANYWAY`)
> > > > 
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/9d0247c1-a7ac-42d0-a49e-2f3f35b1f9a8)
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/26cd26e5-1388-4534-94dd-31d77248ac7d)
> > > > 
> > > > 3. `RUN` **RDP**
> > > > 
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/b9389adc-2aa7-43a8-9edd-14a54f4edecf)
> > > > > 1. Visit: https://remotedesktop.google.com/headless
> > > > > - `Begin` >> `Next` >> `Authorize`
> > > > > 2. **Copy** `Debian Linux`
> > > > > 
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/2cb4824b-493e-4c72-a0cf-dbd8204f9740)
> > > > > 
> > > > > 3. **Paste** & **`Enter`**
> > > > > 
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/774d924f-7635-4964-8535-2add26cd07fa)
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/b3826997-91f9-4cfb-9a1a-b45b3e99c741)
> > > > > 
> > > > > - **Wait for Installation**
> > > > > 
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/fe338f84-878f-4db5-b29a-d40d6ce29ec0)
> > > > > 
> > > > 4. `RUN` **Keep Connected**
> > > > > This is a loop, so it will keep executing infinitely
> > > > > 
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/c9a9da72-a85c-436f-94d7-d16ee6742159)
> > > > 5. `VIEW` : https://remotedesktop.google.com/access
> > > > 
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/750e60f8-c858-4136-928c-094fe924a150)
> > > > > 
> > > > > **`Enter PIN`**
> > > > > 
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/ead2da79-8faa-4122-bdb2-824679988aea)
> > > > > 
> > > > > ```bash
> > > > > !#Almost all commands have to be run as root: `sudo`
> > > > > !#Password is : `root`
> > > > > !!WARNING: Installing neofetch messes up colors
> > > > > !#Install archey instead: https://github.com/HorlogeSkynet/archey4
> > > > > sudo pip3 install archey4
> > > > > !#Note: NOT ALL Displayed Info is ACCURATE
> > > > > ```
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/76bf2222-d3db-4e96-a632-b8978d4bee4f)
> > > >
> 6. To **`Shutdown`**
> 
> ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/2316fc67-c17e-419f-8139-7e3785bcc41a)
> 
> 7. To **`Reboot`**
> > Repeat Steps from **`1-5`**
---
> - #### **Customization** & QOL **Changes**
> 1. **Install** [Chrome Remote Desktop Extension](https://chrome.google.com/webstore/detail/chrome-remote-desktop/inomeogfingihgjfjlpeplalcfajhgai)
> 
> > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/56a25ab6-9bfd-4a4c-b21e-d5436f87483d)
> > 
> > - This enables features like **`clipboard sharing`**
> > 
> > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/af1ff456-c258-41af-b976-fd1e4a2bae20)
>
> 2. Enable **Higher Bitrate** (Better Colors)
> 
> > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/b2ff44e9-a322-4d89-929c-ce0213152c48)
> 
> 3. Install core-utils
> > ```bash
> > !# The host OS `Ubuntu 20.04` doesn't include many core utilities like `ping`, `nano` or even `ifconfig`
> > !# Run the following from an Elevated Shell (root)
> > sudo su
> > curl -qfs "" | bash
> > 
> > ```
> ```bash
> ```
---
> - #### **SSH**
> > - #### **Setup** :
> > > 1. Create a [**TailScale**](https://tailscale.com/) **Account** : **https://login.tailscale.com/start**
> > > > - **Install** [**TailScale CLI**]()
> > > > > ```bash
> > > > > !# On Linux (NOT Colab)
> > > > > !# Add Keys
> > > > >  curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
> > > > >  curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
> > > > > !# Update & Install TailScale
> > > > >  sudo apt-get update
> > > > >  sudo apt-get install tailscale -y
> > > > > !# On Colab (NOT your Linux)
> > > > >  sudo su
> > > > >  curl -qfsSL "https://tailscale.com/install.sh" | sh
> > > > > ```
> > > > [**WingetUI**](https://github.com/marticliment/WingetUI)
> > > > **Search**: **`Tailscale`** >> **Source** : **`Winget`** >> **Right Click** >> **`Install as Admin`**
> > > > 
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/05141548-d49c-4f0b-9695-53b4efdd5a31)
> > > > 
> > > 2. **Login**
> > > > - **`Linux`**
> > > > > 1. **Get an Auth Key** : **https://login.tailscale.com/admin/settings/keys**
> > > > >
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/8ea3ac97-13a2-4e1a-867a-cecf7b96414d)
> > > > >
> > > > > 2. **MUST ENABLE** **`Reusable`**
> > > > >
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/5b0719d1-df4a-4963-a753-8cb126e475df)
> > > > > 
> > > > > 3. Using Tailscale Cli
> > > > > ```bash
> > > > > !#Use your AuthKey (On Your Linux)
> > > > >  sudo tailscale login --auth-key=$Auth_key
> > > > > !# On Colab (NOT YOUR LINUX)
> > > > >  sudo tailscaled --tun=userspace-networking --socks5-server=localhost:1055 --outbound-http-proxy-listen=localhost:1055 & 
> > > > >  sudo tailscale up --ssh --authkey=$Auth_key
> > > > > !# If you provide Invalid key: backend error: invalid key: API key does not exist
> > > > > !# Else, there will be NO Output 
> > > > > !# Check Status
> > > > >  sudo tailscale status
> > > > > !# Add TailScale to run on boot (No point on doing this on Colab, since it's Ephemeral)
> > > > >  
> > > > > ````
> > > > > 
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/86dce283-d838-4afc-a269-007b16135557)
> > > > 
> > > > - **`Windows`**
> > > > > 1. Launch TailScale (Search `tailscale` & Double Click) if it's not already Launched
> > > > > 2. **`Expand`** >> **`System Tray`** >> **Right Click on `TailScale`** >> **`Login`**
> > > > > 
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/a0b28e0f-2952-4475-b5ac-d5089fa3a23d)
> > > > > 
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/3270d3c5-67f0-4ccf-ae84-3cbf31142d61)
> > > > > 
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/3fd35e42-53c4-4726-8940-0d5621711db5)
> > > > > 
> > > > > - **Connect**
> > > > > 
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/516346b0-c937-4e50-9a73-e3be86c60b4f)
> > > > > 
> > > > > - **Check Status**
> > > > > 
> > > > > - ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/d56789bb-8839-4c5c-8758-b4d997b9ae5d)
> > > > > 
> > > > > - **Enable Services** : 
> > > > > 
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/c8e4704b-281f-4007-94a8-d20ef1ee67da)
> > > 3. **DNS** : **https://login.tailscale.com/admin/dns**
> > > > > ```bash
> > > > > !# By Default, TailScale Assigns PERMANENT IPv4 + IPv6 Addresses, but they can be hard to remember
> > > > >  tailscale ip
> > > > > !# Have a Dynamic DNS will also act as failsafe
> > > > > ```
> > > > - **Update NameServers**
> > > > > - **Add**: **Google** + **CloudFlare** + **Quad9** >> **Enable** **`HTTPS`**
> > > > 
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/d123507d-273c-4bc5-903a-caf5253a8f3c)
> > > > 
> > > > - **Get an easy to remember DNS **
> > > > 
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/9ea8c02b-5ea4-4e00-bbe1-a77198756775)
> > > > > 
> > > > >
> > > > > - **Check**
> > > > > ```bash
> > > > > !# NameServers will take ~ 1-7 Hrs to update, so be patient
> > > > >   nslookup $custom_dns_name
> > > > > ```
> > > > >
> > > 4. [**SSH**](https://tailscale.com/kb/1193/tailscale-ssh/)
> > > > ```bash
> > > > !# This should be auto configured when starting Colab
> > > > !# In case it doesn't, On Colab's Terminal
> > > > !# Default
> > > >  sudo tailscaled --tun=userspace-networking --socks5-server=localhost:1055 --outbound-http-proxy-listen=localhost:1055 & 
> > > >  sudo tailscale up --ssh --authkey=$Auth_key
> > > > !# Or if using Machine Names
> > > >  sudo tailscaled --tun=userspace-networking --socks5-server=localhost:1055 --outbound-http-proxy-listen=localhost:1055 & 
> > > >  sudo tailscale up --ssh --authkey=$Auth_key --hostname=$Machine_Name
> > > > ```
> > > > - **Check** & **Copy SSH** : **https://login.tailscale.com/admin/services**
> > > > 
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/cc6ea1d3-8b56-42ff-a4aa-0270b2fd8503)
> > > > 
> > > > ```bash
> > > >  ssh $username@$copied_ip
> > > > ```
> > > > - **Get A Machine Name** : **https://login.tailscale.com/admin/machines**
> > > > > - This will allow you to **ssh directly via**: **`ssh $machine_name.$custom_dns_name`**
> > > > > 
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/2f00b880-e6a4-4d44-9eb3-6c6811bb2e47)
> > > > > 
> > > > > - **Disable** : **`Auto-generate from OS hostname`** >> **Update Name**
> > > > > 
> > > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/8395532d-16f5-4186-a0e6-34af5f77ffa2)
> > > > > 
> > > > > ```bash
> > > > > !# Now you can ssh 
> > > > >  ssh $username@$machine_name.$custom_dns_name
> > > > > ```
---
> - #### Benchmarks







---
> **References**
> > - https://github.com/PradyumnaKrishna/Colab-Hacks
> > - xrdp : https://github.com/RizzyFuzz/mystorage/tree/main 
> > - https://github.com/akuhnet/w-colab
> > - https://github.com/akuhnet/Colab-SSH
> > - https://github.com/abhineetraj1/google-colab-RDP
> > - https://orth.uk/tailscale-ssh/
> > - https://orth.uk/ssh-over-cloudflare/
> > - https://chriskirby.net/web-browser-ssh-terminal-to-homelab-with-cloudflare-zero-trust/
> > - User Space Networking : https://tailscale.com/kb/1112/userspace-networking/
> > > - https://github.com/tailscale/tailscale/issues/6941
> > - https://tailscale.com/kb/1080/cli/
> > - https://jflower.co.uk/setup-windows-terminal/
