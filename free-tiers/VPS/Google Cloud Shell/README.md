- #### [Cloud Shell](https://cloud.google.com/shell)
> - #### About: **Intro** & **Setup**
> [![ Google Cloud Shell Tutorial for Beginners ](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/34267923-dac3-4ae8-8850-9502c32c0ce0)](https://www.youtube.com/watch?v=RdDyF3jVbbE)
> > - **Limits**
> > ```yaml
> > Quota                           : 50 Hr / Week [~ 7 Hrs / Day]
> > Interactive Session Limit       : 12 Hr [Auto Terminates and Loses Persistance] # Interactive = You continously use the Shell Environment
> > Non Interactive Session Limit   : 20Mins ~ 1 Hr [Auto Terminates and Loses Persistance] # Non Interactive = You do nothing & Shell Environment is Idle
> > ```
> > - **Specs**
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
> > > ```
> > - **Configuration**
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
> > - **Customization** & **QOL Changes**
> > > - `ZSH`
> > > ```
> > > !# This is all Ephemeral, Must Install zsh upon each boot, Only ~/.dotfiles are Preserved
> > > !# See #Scripts for Automation
> > > !# Install
> > > sudo apt-get install zsh zsh-syntax-highlighting zsh-autosuggestions -y
> > > !# Change Default Shell
> > > sudo chsh -s /bin/zsh "$USER" && $(which zsh)
> > > ```
> > - **Benchmarks**
> > 
