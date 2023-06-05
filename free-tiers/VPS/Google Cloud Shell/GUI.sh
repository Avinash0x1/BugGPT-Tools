#!/usr/bin/env bash
#Set tmp dir
export gui_setup=$(mktemp -d) && cd "$gui_setup"
export origin=$(pwd)
##Set Deps for Core
sudo apt update
sudo apt install dbus-x11 firefox-esr nano nautilus neofetch papirus-icon-theme plank simplescreenrecorder xfce4 xfce4-goodies xfce4-terminal xscreensaver xvfb --assume-yes
sudo apt --fix-broken install --assume-yes
##Set Deps for GUI
sudo apt install sassc --assume-yes
sudo apt --fix-broken install
# Download Chrome Remote Desktop, install it, then delete downloaded .deb package
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb && sudo dpkg -i chrome-remote-desktop* && sudo apt --fix-broken install --assume-yes && rm chrome-remote-desktop*
# Remove Tmp
sudo rm -rf "$gui_setup"
cd "$origin"
#EOF
