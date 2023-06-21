- #### [Cloudflare R2 <sub><img src="https://github.com/Azathothas/BugGPT-Tools/assets/58171889/ceaee7c3-473e-48e6-81e7-e4dccf6a1c51"  width="33" height="33"> </sub>](https://studiolab.sagemaker.aws)
> - [**About**](https://github.com/Azathothas/BugGPT-Tools/tree/main/free-tiers/Storage%20(Buckets%20%26%20Databases)/R2%20(Cloudflare)%20#about)
> - [**Setup**](https://github.com/Azathothas/BugGPT-Tools/tree/main/free-tiers/Storage%20(Buckets%20%26%20Databases)/R2%20(Cloudflare)%20#setup)
> - [**Config**](https://github.com/Azathothas/BugGPT-Tools/tree/main/free-tiers/Storage%20(Buckets%20%26%20Databases)/R2%20(Cloudflare)%20#config)
> - [**RClone Ops**](https://github.com/Azathothas/BugGPT-Tools/tree/main/free-tiers/Storage%20(Buckets%20%26%20Databases)/R2%20(Cloudflare)%20#rclone-ops)
---
> - #### **About**

---
> - #### **Setup**
> > - **Create a `R2 Bucket`**
> >   
--- 
> - #### Config
> > - Tokens
> > > Dashboard >> https://dash.cloudflare.com >> R2 >> OverView
> > > ![gen_ak_1](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/50aa95bf-e40d-4791-86ee-e9005b0fcb4a)
> > > ![gen_ak_2](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/389df129-f6d1-40c2-91e0-5e056be2e2b9)
> > > ![gen_ak_3](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/1ac98b31-5e8a-4b90-9eb9-6fd5e6fe19fc)
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/5a7902f6-1b3e-4156-b635-c3d48e745f99)
> > 
> > - Endpoint
> > > Dashboard >> https://dash.cloudflare.com >> R2 >> OverView >> Click On a Bucket >> Copy URL
> > > 
> > > **Delete Bucket Name from url [ Remove after /]**
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/a58a7146-4a06-486b-9aac-d1f0a92056e6)
> > >
> - **Sample**
> > **Install** [**rClone**](https://rclone.org/install/)
> > ```bash
> > !# Linux (As root `sudo su`)
> >  curl -qfsSL "https://rclone.org/install.sh" | sudo bash
> > !# Windows (Via PowerShell Winget)
> >  winget install Rclone.Rclone
> > ```
> > > Or Via [**WingetUI**](https://github.com/marticliment/WingetUI)
> > > ![Install_rclone_wingetUI](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/44475288-3b25-4182-9041-8526e935c1b4)
> > >
> > **Only Change** **`access_key_id`** | **`secret_access_key`** | **`endpoint`**
> > ```bash
> > !# Default Config Location 
> > !# Windows (Paste in File Explorer & Enter)
> >  %APPDATA%/rclone/rclone.conf 
> > !# Linux (Use nano or codium)
> >  $HOME/.config/rclone/rclone.conf
> > ```
> ```ini
> [r2]
> type = s3
> provider = Cloudflare
> access_key_id = <ACCESS_KEY> 
> secret_access_key = <SECRET_ACCESS_KEY>
> region = auto
> endpoint = https://<ACCOUNT_ID>.r2.cloudflarestorage.com
> acl = private
> ```
> - **Test**
> ```bash
> !# List all buckets
>  rclone lsf r2:  #If your bucketname has a `/` at end, then ALWAYS INCLUDE `/`
> 
> !# Upload a file
>  rclone copy .\dns_resolvers_test_50M.txt r2:$Bucket/ --progress
> ```
> ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/364ca4b1-0eb7-46a1-814c-331d6a49ce5b)
> ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/94200fd3-9bd1-4b35-a3de-386d8bd66064)

---
> - #### RClone Ops
> > ```bash
> > ```

---
> - #### References
> > - https://blackist.medium.com/upload-files-to-cloudflare-r2-in-the-terminal-with-rclone-e01f21a47e5e
