- #### [Cloud Shell](https://cloud.google.com/shell)
> - #### About: [<img src="https://github.com/Azathothas/BugGPT-Tools/assets/58171889/7737d632-1cf6-46a0-8b3a-644482b9022d" width="30" height="30">**Intro** & **Setup**](https://www.youtube.com/watch?v=RdDyF3jVbbE)
> [![Google Cloud Shell Tutorial for Beginners](https://img.youtube.com/vi/RdDyF3jVbbE/maxresdefault.jpg)](https://www.youtube.com/watch?v=RdDyF3jVbbE)
> > ➼ **Limits**
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
> > > - You get a [***free Credit of `$300`***](https://cloud.google.com/free/docs/free-cloud-features) (eligible for 90 Days) your ***System Resources are Doubled (2X)***
> > > 
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/7e41099e-321d-479c-876d-8641ea5e4507)
> > > 
> > > ```YAML
> > > CPU                  : 4 Cores (Intel / AMD) ~ 2 GHZ
> > > RAM                  : 16 GB
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
> > ---
> > ➼ **Configuration**
> > > 1. Tools & Binaries : Anything Installed via `apt` | `cargo` | `go` | `pip` etc is **Auto DELETED** upon Restart
> > > > - Only Way to keep your Installed Tools & Binaries, is to store them in: **`$HOME/bin`** || **`$HOME/.local/bin`**
> > > > ```YAML
> > > > !# Default path for Binaries
> > > > apt    | apt-get       : /usr/bin/ || /usr/local/bin/
> > > > cargo (rust)           : $HOME/.cargo/bin/ # Rust is not installed by default
> > > > go get | go install    : $HOME/gopath/bin/
> > > > pip    | pip3          : $HOME/.local/bin # May need to `source ~/.profile`
> > > > ```
> > > ```bash
> > > !# You only have a limited 5 GB of Space. Only Preserve Absolute Necessities
> > > !# Create Dirs
> > > mkdir -p "$HOME"{bin,,.local/bin}
> > > !# Installing via CLI (`apt` | `cargo` | `go` | `pip` etc)
> > > !# Install normally, and then move
> > > sudo mv $(which $Tool) "$HOME/bin/"
> > > !# Source $PROFILE
> > > source "$HOME/.profile" && exec $SHELL
> > > ```
> > ---
> > ➼ **Customization** & **QOL Changes**
> > > - `ZSH`
> > > ```bash
> > > !# This is all Ephemeral, Must Install zsh upon each boot, Only ~/.dotfiles are Preserved
> > > !# See #Scripts for Automation
> > > !# Install
> > > sudo apt-get install zsh zsh-syntax-highlighting zsh-autosuggestions -y
> > > !# Change Default Shell
> > > sudo chsh -s /bin/zsh "$USER" && $(which zsh)
> > > ```
> > - **Scripts**
> > > - **Auto Setup**, **Backup** & **Sync**
> > > 1. Create a [**New Private Repository**](https://github.com/new) with the following Presets:
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/4c3a2824-f323-403a-beb0-bb3be77f4788)
> > > 2. Create a [**Personal Access Token**](https://github.com/settings/tokens?type=beta) (**Fine-grained tokens**) for the created Repository:
> > > > **Expiration**           : `Exactly 1 Year from Current Date`
> > > > **Repository access**    : >> `Only select repositories` >> `Select Your Repository`
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/bf3c316b-e332-4dd7-bfcb-0da19da3ecac)
> > > > **Permissions**          : >> `Repository permissions` >> `Read & Write` | `Read` (**DO NOT give any Account Permission**)
> > > > - **Generate Token** >> **Copy somewhere safe**
> > > > 
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/6eb9fe4b-6d8a-4861-836e-cbffdc68cd0b)
> > > >
> > > 3. **Repo** >> **Add File** >> **Create A New File** >> `.customize_environment`
> > > 
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/30d0cffb-4179-45ff-a695-57b64b93905e)
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/617857cf-740a-4e8b-9258-023943f07090)
> > >
> > > 4. **Copy & Paste** : https://github.com/Azathothas/BugGPT-Tools/blob/main/free-tiers/VPS/Google%20Cloud%20Shell/.customize_environment
> > > > ```yaml
> > > > #Similary, Create (DO NOT FORGET DOTS (.) In FILENAMES) the following files and Copy paste
> > > > `/scripts/gsync.sh` : https://github.com/Azathothas/BugGPT-Tools/blob/main/free-tiers/VPS/Google%20Cloud%20Shell/gsync.sh 
> > > > `.tmux.conf`        : https://github.com/Azathothas/BugGPT-Tools/blob/main/free-tiers/VPS/Google%20Cloud%20Shell/.tmux.conf
> > > > `.zshrc`            : https://github.com/Azathothas/BugGPT-Tools/blob/main/free-tiers/VPS/Google%20Cloud%20Shell/.zshrc
> > > > `.zshenv`           : https://github.com/Azathothas/BugGPT-Tools/blob/main/free-tiers/VPS/Google%20Cloud%20Shell/.zshenv
> > > > ```
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/8dd324ff-f0d7-4e48-9ea4-ef0e6d49d50e)
> > > > 
> > > > `gsync.sh` (NO .DOTS in FILENAME) MUST BE inside `scripts`, use `/` to create folders when adding files
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/99c18f50-33f0-48a9-b171-7daa3fd7fd00)
> > > > 
> > > 5. Change `GITHUB_USER` && `GITHUB_REPO` && `GITHUB_TOKEN` in `.customize_environment` || `/scripts/gsync.sh` >> **Commit Changes** >> **Save**
> > > 6. In [**Google Cloud Shell**](https://shell.cloud.google.com/?hl=en_US&fromcloudshell=true&show=terminal)
> > > > ```bash
> > > > !# Set environ, The URL must be your RAW URL for `.customize_environment`
> > > > !# This is EXAMPLE ONLY!!!
> > > > curl -qfsSL "https://raw.githubusercontent.com/Azathothas/GoogleVPS/main/.customize_environment?token=GHFAT0BBBBBY3DGUSBWHAQI2Y4YWSADASQ" | bash
> > > > !# That will take ~ 2-3 Mins
> > > > !# Type bash or zsh
> > > > zsh
> > > > !# Your SHELL & PROMPT should look like this: 
> > > > ```
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/f9bd6c03-5534-43f9-8b24-9ab3003f282b)
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/48d2608b-fea8-4e30-98cf-f8d5a517ac2e)
> > >  
> > > > - For proper config, you may need to Restart your CloudShell (Restart will take longer)
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/56f4e12f-7ae4-4b16-bffa-de702e9b249b)
> > > > 
> > > > > If it takes longer than ~5 mins, Hard Refresh the browser (Ctrl + Shift + R)
> > > > > Next time whenever you reboot, your system should automatically be configured, if it is not then:
> > > > > ```bash
> > > > > bash "$HOME/.customize_environment"
> > > > > !#If asked for Font Config, Enter `N`
> > > > > ```
> > ---
> > - **SSH**
> > > - **Setup**
> > > ```
> > > !# Install Gcloud ClI, if this doesn't work : https://cloud.google.com/sdk/docs/install#deb
> > > !# Setup Deps
> > > sudo apt-get install apt-transport-https ca-certificates gnupg
> > > !# Import Keys
> > > curl -qs "https://packages.cloud.google.com/apt/doc/apt-key.gpg" | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
> > > !# Finally Install
> > > sudo apt-get update && sudo apt-get install google-cloud-cli
> > > ```
> > > - **Configuration**
> > > ```bash
> > > gcloud auth login 
> > > ```
> > > Sign In & Authorize Via Browser
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/510a918c-30ba-46f4-832c-316d30618cf0)
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/b113b34a-88e3-43d0-9f27-46568c84147d)
> > > 
> > > - SSH :
> > > ```bash
> > > gcloud cloud-shell ssh
> > > ```
> > > > If you have multiple projectts in your GCloud Acc
> > > > ```bash
> > > > !# List ALL Projects
> > > > gcloud projects list
> > > > !# Example Output
> > > > PROJECT_ID        NAME                PROJECT_NUMBER
> > > > BegHecker-1337    Beg Hecker          6969886133769
> > > > BegHecker-69420   beghaxxor           1337133769420
> > > > !# Change to $project
> > > > gcloud config set project $Poject_ID
> > > > !#Example
> > > > gcloud config set project BegHecker-1337
> > > > 
> > > > ```
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/1906fa0b-182b-4ddc-848f-8716e2d0727a)
> > > 
> > > - **TmuX**
> > > ```YAML
> > > Bind Key      : Alt + G
> > > Mouse Support : Enabled (Messes up easy copy paste in browser, so either disable or use `Alt + G + [ `
> > > ```
> > > ```bash
> > > tmux 
> > > ```
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/cba1f9c9-95c6-4704-9b86-b14b8ba7a3b7)
> > ---
> > - **Remote Desktop**
> > > 1. Using **lxde** + **Chrome** [**Fast but Limited**] [USE: xdrp See#3 ]
> > > > Note: Setting this will take a lot of Space + Time
> > > > - This is documented only for documentation's sake
> > > > - `xRdp` is a way better way to achieve this
> > > ```bash
> > > !# Run
> > >  curl -qfs "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/free-tiers/VPS/Google%20Cloud%20Shell/GUI.sh" | bash 
> > > !# If prompted for : Keyboard layout >> Enter 1 (Press Enter 2-3 times & wait)
> > > !# The script essenttially installs a Desktop Environment from Scratch
> > > !# Sometimes, t may not work, and will need Troubleshootng:
> > > !# If hangs, exit `Alt + G + X` >> Restart >> Try Again:
> > >  sudo killall apt
> > >  sudo dpkg --configure -a
> > > !#Then re run the curl cmd  
> > >  curl -qfs "https://raw.githubusercontent.com/Azathothas/BugGPT-Tools/main/free-tiers/VPS/Google%20Cloud%20Shell/GUI.sh" | bash
> > > !# If it still doesn't work, try the `xRdp` Way
> > > ```
> > > > - Visit: https://remotedesktop.google.com/headless
> > > > - `Begin` >> `Next` >> `Authorize`
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/04d884ed-6081-469b-889e-d810af9f29ab)
> > > >
> > > > - Copy `Debian Linux` & Paste [Remember the PIN you enter]
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/3a69f6c2-8d4c-4822-8058-6cb61ac636e0)
> > > > 
> > > > - Visit: https://remotedesktop.google.com/access
> > > > - You will See `Online`
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/6408bc37-bed4-4684-82ca-363f8cc883fb)
> > > > - Enter the **PIN** You created & **Login**
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/56c77c5e-06ce-4885-b236-b29b45508347)
> > > > 
> > > > ---
> > > 2. Using Docker (Easiest + Quickest) [**Slow** & **Limited**]
> > > > ```bash
> > > > !#Pull the container
> > > >  docker run -p 7331:80 dorowu/ubuntu-desktop-lxde-vnc
> > > > ``` 
> > > > - **Web Preview** >> **Change Port** >> 7331
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/499a0298-6bc4-4941-ad31-85f72ea1a602)
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/286adcff-45c1-4c49-8d5d-e880e65a7178) 
> > > > 
> > > > ```YAML
> > > > Specs:
> > > >   Persisteence: None (Temporary)
> > > >   Uptime      : 4-5 Hrs
> > > >   Disk        : 10 GB
> > > >   Network     :
> > > >     IPv4      : Yes
> > > >     IPv6      : No
> > > >     Speed     : ~ 1000 Mbps
> > > > ```   
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/af8c457d-8b25-4303-82fc-4a126a8c21af)
> > > 
> > > ---
> > > 
> > > 3. Using **xRDP** [**Most Stable & Reliable**]
> > > ```bash
> > > !# Create a rdp user
> > > sudo adduser remote
> > > !# Enter a new password when prompted, Press Enter for everything else
> > > !# Assign sudo perms
> > > sudo usermod -aG sudo remote
> > > ```
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/416cf2ba-53ff-4b41-864c-a04b9ba657cf)
> > >
> > >```bash
> > > !# Install Essential Pkgs
> > > sudo apt install xrdp dbus-x11 xfce4 -y 
> > > !# If prompted to choose Keyboard Layout, Choose English (US) : 1
> > > !# ngrok for tunneling
> > > eget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz --to "$HOME/bin/ngrok" && sudo chmod +x "$HOME/bin/ngrok"
> > > !# Register & Get Auth Token
> > > https://dashboard.ngrok.com/get-started/your-authtoken
> > > !# Add it
> > > ngrok config add-authtoken $auth_token
> > > !# Start xrdp service
> > > sudo service xrdp start 
> > > !# Start ngrok
> > > ngrok tcp 3389
> > > ```
> > > - Copy the `tcp://Address:Port` 
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/84cc450f-611d-4bcb-a10c-c367f2798b2f)
> > > 
> > > 1. Install [**mRemoteNG**](https://github.com/mRemoteNG/mRemoteNG)
> > > > [WingetUI](https://github.com/marticliment/WingetUI): **Install As Admin**
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/c3b27b53-27e3-4e4b-9750-c38a31070fe9)
> > > 2. Open mRemoteNG [**FULL SCREEN**]
> > > > On the Top >> Enter your **Address:PORT** >> Click **RDP**
> > > > ![2023-06-05_10-38](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/6fa2410d-30aa-49fa-bc77-dab7aff56adf)
> > > > 
> > > > ```bash
> > > > Session : Xorg
> > > > User : remote
> > > > Password: $the_password_You_created_in_abv_steps
> > > > ```
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/75afe6c2-881d-45c0-bdd8-e5e32be3bfe2)
> > > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/17d47db2-2c38-4f8e-b1de-09087629e43b)
---
 - #### **Benchmarks**
---
> - **References**
> > - https://github.com/FrancescoDiSalesGithub/Google-cloud-shell-hacking
> > - https://github.com/ProblematicToucan/gcloud-shell-rdp
