- #### [Cloud Colab](https://colab.research.google.com)
> - #### About: [<img src="https://github.com/Azathothas/BugGPT-Tools/assets/58171889/7737d632-1cf6-46a0-8b3a-644482b9022d" width="30" height="30">**Intro** & **Setup**](https://www.youtube.com/watch?v=g0xu9DA4gDw)
> [![Google Colab Tutorial for Beginners](https://img.youtube.com/vi/g0xu9DA4gDw/maxresdefault.jpg)](https://www.youtube.com/watch?v=RdDyF3jVbbE)
> > ➼ **Limits**
> > 
> > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/ff3c76fb-cad8-47a6-a6f0-1ad5b42d3b93)
> > 
> > ```yaml
> > Quota                           : 50 Hr / Week [~ 7 Hrs / Day]
> > Interactive Session Limit       : 12 Hr [Auto Terminates and Loses Persistance] # Interactive = You continously use the Shell Environment
> > Non Interactive Session Limit   : 20Mins ~ 1 Hr [Auto Terminates and Loses Persistance] # Non Interactive = You do nothing & Shell Environment is Idle
> > ```
> > ➼ **Specs**
> > 1. **No `Credit Card`** || **No `Free Trial`** 
> > 
> > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/2eafe78f-e37e-4b83-93c5-e5394fb35f98)
> > 
> > > ```YAML
> > > CPU                  : 2 Cores (Intel / AMD) ~ 2 GHZ
> > > RAM                  : 8 GB
> > > Storage (Persistent) : 5 GB [`$HOME/*`] # Everything you keep in ~/$USERNAME (Home) directoy will Survive (Persist) a System Reboot 
> > >   Inactivity         : Deleted if inactive (No Sign In & Use of Cloud Shell for 120 days)
> > >   Ephemeral Mode     : N/A # System is Faster, but nothing is preserved, Read : https://cloud.google.com/shell/docs/using-cloud-shell#choosing_ephemeral_mode
> > > Storage (Mounted)    : 60 GB [`/dev/sda*/*`] # This is a temporary storage mounted on System Boot, RESET after a System Reboot 
> > >   Usable             : ~ 15 GB 
> > > Networking           : Limited
> > >   IPv4               : Yes
> > >   IPv6               : No
> > >   Benchmarks         : See #Benchmarks Below
> > > Cron                 : No crontab, Interactve only # Can't Schedule tasks etc
> > > ```
> > > - **Storage**
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/4d841f1d-909c-4697-b0e4-fe845d437b95)
> > > 
> > 2. **`Credit Card`** || **`Free Trial`** 
> > > - Google won't charge you, but if you provide a **Credit Card** and enable [**Compute Engine**](https://console.cloud.google.com/apis/api/compute.googleapis.com/metrics)   
> > > 
----
> - #### Setup:
> > Use `Chromium Based Browser` [`NOT FireFox`]
> 1. **Right Click** [`Open In NewTab`] --> <a href="https://colab.research.google.com/github/Azathothas/BugGPT-Tools/blob/main/free-tiers/VPS/Google%20Colab/VPS.ipynb" target="_parent"><img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/></a>
> 2. `RUN` **Create User** (If prompted, `RUN ANYWAY`)
> 
> > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/9d0247c1-a7ac-42d0-a49e-2f3f35b1f9a8)
> > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/26cd26e5-1388-4534-94dd-31d77248ac7d)
> 
> 3. `RUN` **RDP**
> 
> ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/b9389adc-2aa7-43a8-9edd-14a54f4edecf)
> > 1. Visit: https://remotedesktop.google.com/headless
> > - `Begin` >> `Next` >> `Authorize`
> > 2. **Copy** `Debian Linux`
> > 
> > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/2cb4824b-493e-4c72-a0cf-dbd8204f9740)
> > 
> > 3. **Paste** & **`Enter`**
> > 
> > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/774d924f-7635-4964-8535-2add26cd07fa)
> > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/b3826997-91f9-4cfb-9a1a-b45b3e99c741)
> > 
> > - **Wait for Installation**
> > 
> > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/fe338f84-878f-4db5-b29a-d40d6ce29ec0)
> > 
> 4. `RUN` **Keep Connected**
> > This is a loop, so it will keep executing infinitely
> > 
> > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/c9a9da72-a85c-436f-94d7-d16ee6742159)
> 5. `VIEW` : https://remotedesktop.google.com/access
> 
> > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/750e60f8-c858-4136-928c-094fe924a150)
> > 
> > **`Enter PIN`**
> > 
> > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/ead2da79-8faa-4122-bdb2-824679988aea)
> > s
> 6. To **`Shutdown`**
> ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/2316fc67-c17e-419f-8139-7e3785bcc41a)
> 
> 7. To **`Reboot`**
> > Repeat Steps from **`1-5`**
---
> - Customization & QOL Changes
> 1. **Install** [Chrome Remote Desktop Extension](https://chrome.google.com/webstore/detail/chrome-remote-desktop/inomeogfingihgjfjlpeplalcfajhgai)
> > - This enables features like **`clipboard sharing`**
> > 
> > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/56a25ab6-9bfd-4a4c-b21e-d5436f87483d)
> > 
> 2. 
> 






