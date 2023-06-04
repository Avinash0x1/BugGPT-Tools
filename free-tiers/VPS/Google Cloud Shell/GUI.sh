#! /bin/bash
printf 'Installing RDP Be Patience... \n ' >&2
printf 'This will take ~ 10 Mins... \n ' >&2
printf 'When Asked, Keyboard layout, Enter `1` \n ' && sleep 10s
printf 'Username:gcprdp || Password:733169420 \n '
cd $(mktemp -d)
{
sudo useradd -m gcprdp
sudo adduser gcprdp sudo
echo 'gcprdp:733169420' | sudo chpasswd
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive \
sudo apt install dbus-x11 desktop-base firefox-esr gnome-terminal kdenlive mpv nano nautilus neofetch nload papirus-icon-theme plank sassc simplescreenrecorder xfce4 xfce4-goodies xfce4-terminal xscreensaver xvfb --assume-yes
sudo apt install --assume-yes --fix-broken
sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'
sudo systemctl disable lightdm.service
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo adduser gcprdp chrome-remote-desktop
} &> /dev/null &&
printf "\nSetup Completed \n" >&2 ||
printf "\nError Occured \n" >&2
printf '\nCheck https://remotedesktop.google.com/headless `Begin` >> `Next` >> `Authorize` \n  Copy Command Of Debian Linux And Paste Down \n '
read -p "Paste Here: " CRP
su - gcprdp -c """$CRP"""
printf 'Check https://remotedesktop.google.com/access/ \n '
printf 'Username:gcprdp || Password:733169420 \n '
