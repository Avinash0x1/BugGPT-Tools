## **Setup** 
> #### 1. Create a [**TailScale**](https://tailscale.com/) **Account** : **https://login.tailscale.com/start**
> > - **Install** [**TailScale CLI**]()
> > > - [**Linux**](https://tailscale.com/kb/1031/install-linux/)
> > > > ```bash
> > > > !# On Linux (Running with Systemd or Init System) [Debian Based]
> > > > !# Add Keys
> > > >  curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
> > > >  curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
> > > > !# Update & Install TailScale
> > > >  sudo apt-get update
> > > >  sudo apt-get install tailscale -y
> > > > !# On Linux (Running on Containers without init) | [Not Debian]
> > > > !# Same for Arch and Variants
> > > > !# Read: https://tailscale.com/kb/1031/install-linux/
> > > >  sudo su
> > > >  curl -qfsSL "https://tailscale.com/install.sh" | sh
> > > > ```
> > - [**Windows**](https://tailscale.com/kb/1022/install-windows/)
> > > [**WingetUI**](https://github.com/marticliment/WingetUI)
> > > **Search**: **`Tailscale`** >> **Source** : **`Winget`** >> **Right Click** >> **`Install as Admin`**
> > > 
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/05141548-d49c-4f0b-9695-53b4efdd5a31)
> > >
> ---
> #### 2. **Login**
> > > - **`Linux`**
> > > > 1. **Get an Auth Key** : **https://login.tailscale.com/admin/settings/keys**
> > > >
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/8ea3ac97-13a2-4e1a-867a-cecf7b96414d)
> > > >
> > > > 2. **MUST ENABLE** **`Reusable`**
> > > >
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/5b0719d1-df4a-4963-a753-8cb126e475df)
> > > > 
> > > > 3. Using Tailscale Cli
> > > > ```bash
> > > > !#Use your AuthKey (On Your Linux)
> > > >  sudo tailscale login --auth-key=$Auth_key
> > > > !# On Colab (NOT YOUR LINUX)
> > > >  sudo tailscaled --tun=userspace-networking --socks5-server=localhost:1055 --outbound-http-proxy-listen=localhost:1055 & 
> > > >  sudo tailscale up --ssh --authkey=$Auth_key
> > > > !# If you provide Invalid key: backend error: invalid key: API key does not exist
> > > > !# Else, there will be NO Output 
> > > > !# Check Status
> > > >  sudo tailscale status
> > > > !# Add TailScale to run on boot (No point on doing this on Colab, since it's Ephemeral)
> > > >  
> > > > ````
> > > > 
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/86dce283-d838-4afc-a269-007b16135557)
> > > 
> > > - **`Windows`**
> > > > 1. Launch TailScale (Search `tailscale` & Double Click) if it's not already Launched
> > > > 2. **`Expand`** >> **`System Tray`** >> **Right Click on `TailScale`** >> **`Login`**
> > > > 
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/a0b28e0f-2952-4475-b5ac-d5089fa3a23d)
> > > > 
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/3270d3c5-67f0-4ccf-ae84-3cbf31142d61)
> > > > 
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/3fd35e42-53c4-4726-8940-0d5621711db5)
> > > > 
> > > > - **Connect**
> > > > 
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/516346b0-c937-4e50-9a73-e3be86c60b4f)
> > > > 
> > > > - **Check Status**
> > > > 
> > > > - ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/d56789bb-8839-4c5c-8758-b4d997b9ae5d)
> > > > 
> > > > - **Enable Services** : 
> > > > 
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/c8e4704b-281f-4007-94a8-d20ef1ee67da)
> > 3. **DNS** : **https://login.tailscale.com/admin/dns**
> > > > ```bash
> > > > !# By Default, TailScale Assigns PERMANENT IPv4 + IPv6 Addresses, but they can be hard to remember
> > > >  tailscale ip
> > > > !# Have a Dynamic DNS will also act as failsafe
> > > > ```
> > > - **Update NameServers**
> > > > - **Add**: **Google** + **CloudFlare** + **Quad9** >> **Enable** **`HTTPS`**
> > > 
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/d123507d-273c-4bc5-903a-caf5253a8f3c)
> > >
---
## Usages :
> - 


-
