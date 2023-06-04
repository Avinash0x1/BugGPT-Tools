#! /bin/bash
printf "Installing RDP Be Patience..." >&2
printf "This will take ~ 10 Mins..." >&2
printf "When Asked, Keyboard layout, Enter 1\n" && sleep 10s
cd $(mktemp -d)
{
sudo useradd -m gcprdp
sudo adduser gcprdp sudo
echo 'gcprdp:7331' | sudo chpasswd
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd
sudo apt update
sudo apt install xvfb xfce4 xfce4-goodies mpv kdenlive simplescreenrecorder firefox-esr plank papirus-icon-theme dbus-x11 neofetch krita --assume-yes
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install sassc --assume-yes
sudo apt install --assume-yes --fix-broken
sudo DEBIAN_FRONTEND=noninteractive \
sudo apt install --assume-yes xfce4 desktop-base xfce4-terminal 
sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'
sudo apt remove --assume-yes gnome-terminal
sudo apt install --assume-yes xscreensaver
sudo systemctl disable lightdm.service
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo apt install nautilus nano -y
sudo apt install nload
sudo adduser gcprdp chrome-remote-desktop
} &> /dev/null &&
printf "\nSetup Completed \n" >&2 ||
printf "\nError Occured \n" >&2
printf '\nCheck https://remotedesktop.google.com/headless `Begin` >> `Next` >> `Authorize` \n  Copy Command Of Debian Linux And Paste Down \n '
read -p "Paste Here: " CRP
su - gcprdp -c """$CRP"""
printf 'Check https://remotedesktop.google.com/access/ \n '
printf 'Username:gcprdp || Password:7331 \n '
