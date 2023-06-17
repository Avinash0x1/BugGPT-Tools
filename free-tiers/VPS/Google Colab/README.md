- #### [Cloud Colab](https://colab.research.google.com)
> - [**BenchMarks**](https://github.com/Azathothas/BugGPT-Tools/tree/main/free-tiers/VPS/Google%20Colab#customization--qol-changes)
> - [**About**](https://github.com/Azathothas/BugGPT-Tools/tree/main/free-tiers/VPS/Google%20Colab#about-intro--setup)
> - [**Setup**](https://github.com/Azathothas/BugGPT-Tools/tree/main/free-tiers/VPS/Google%20Colab#setup)
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
>
> > 6. To **`Shutdown`**
> 
> ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/2316fc67-c17e-419f-8139-7e3785bcc41a)
> 
> 7. To **`Reboot`**
> > Repeat Steps from **`1-5`**
> > 
> ---
> - #### [**SSH**](https://tailscale.com/kb/1193/tailscale-ssh/)
> > 1. Create a [**TailScale**](https://tailscale.com) Account & Setup : [**`How ?**`](https://github.com/Azathothas/BugGPT-Tools/tree/main/free-tiers/VPN%20(Tunnels%20&%20Proxies)/Tailscale#setup)
> > 2. Generate a Reusable Auth Key, Paste & Run : [**`How ?**`](https://github.com/Azathothas/BugGPT-Tools/tree/main/free-tiers/VPN%20(Tunnels%20&%20Proxies)/Tailscale#2-login)
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/c23bc689-14f6-420d-86e2-c479c920febc)
> > > 
> > 3. **Wait** for it to **Finish** and **Scroll Output**
> > > 
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/033f29a5-6f23-4504-b97f-b42bb5f3dd92)
> > > 
> > 4. Copy paste in your Terminal:
> > >
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/b6ced77b-c202-405a-b048-11603e2c266f)
> > >
> > ---
> > > - You may need to verify your login:
> > > ![tailscale authenticate new page terminal](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/0c0eb3ac-83d3-498a-92fa-9fdf68a05d4a)
> > > ![tailscale authenticate new page browser](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/6df8d091-a7db-42ec-861b-cb50db0ae414)
> > ---
> > ![talscale sshed](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/b91295d3-8be7-44bb-87eb-970288dbfc52) 
> > > 
> > > - You can also get SSH from [**TailScale Dashboard**](https://login.tailscale.com/admin/services)
> > >  
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/cc6ea1d3-8b56-42ff-a4aa-0270b2fd8503)
> ---
> - #### **RDP**
> > ---
> > I. [**Chrome Remote Desktop**](https://remotedesktop.google.com) (**NOT RECOMMENDED**)
> > > 1. `RUN` **Chrome RDP**
> > > 2. Visit: https://remotedesktop.google.com/headless [Use `Chromium Based Browser` (`NOT FireFox`)]
> > > > - `Begin` >> `Next` >> `Authorize`
> > > 3. **Copy** `Debian Linux`
> > > > 
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/2cb4824b-493e-4c72-a0cf-dbd8204f9740)
> > > >
> > > 4. **Paste** & **`Enter`**
> > > > 
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/774d924f-7635-4964-8535-2add26cd07fa)
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/b3826997-91f9-4cfb-9a1a-b45b3e99c741)
> > > > 
> > > 5. `VIEW` : https://remotedesktop.google.com/access
> > > > 
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/750e60f8-c858-4136-928c-094fe924a150)
> > > > 
> > > 6. **`Enter PIN`**
> > > >
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/ead2da79-8faa-4122-bdb2-824679988aea)
> > > > 
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
> > > - 
> > > 7. **Install** [Chrome Remote Desktop Extension](https://chrome.google.com/webstore/detail/chrome-remote-desktop/inomeogfingihgjfjlpeplalcfajhgai)
> > > > - This enables features like **`clipboard sharing`**
> > > 
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/56a25ab6-9bfd-4a4c-b21e-d5436f87483d)
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/af1ff456-c258-41af-b976-fd1e4a2bae20)
> > >
> > > 8. Enable **Higher Bitrate** (Better Colors)
> > > 
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/b2ff44e9-a322-4d89-929c-ce0213152c48)
> > >
> > ---
> > II. **xRDP**
> > > 1. **`RUN xRDP`**
> > >
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/a0b4b791-f6ce-4bd5-9b04-c16f10f5e1eb)
> > > 
> > > 2. Install [**mRemoteNG**](https://github.com/mRemoteNG/mRemoteNG)
> > > 
> > > > [WingetUI](https://github.com/marticliment/WingetUI): **Install As Admin**
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/c3b27b53-27e3-4e4b-9750-c38a31070fe9)
> > > > 
> > > 3. Open mRemoteNG [**FULL SCREEN**]
> > > > On the Top >> Enter your **Address:PORT** >> Click **RDP**
> > > > 
> > > > ![2023-06-05_10-38](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/6fa2410d-30aa-49fa-bc77-dab7aff56adf)
> > > > 
> > > > ```bash
> > > > Session : Xorg
> > > > User : remote
> > > > Password: $the_password_You_created_in_abv_steps
> > > > ```
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/75afe6c2-881d-45c0-bdd8-e5e32be3bfe2)
> > ---
---





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
