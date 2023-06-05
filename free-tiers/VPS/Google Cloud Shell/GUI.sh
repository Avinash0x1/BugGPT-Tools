#!/usr/bin/env bash
#Set tmp dir
export gui_setup=$(mktemp -d) && cd "$gui_setup"
export origin=$(pwd)
##Set Deps for Core
sudo apt update && sudo apt install xvfb xfce4 xfce4-goodies mpv kdenlive simplescreenrecorder firefox-esr plank papirus-icon-theme dbus-x11 neofetch krita --assume-yes
##Set Deps for GUI
# Download Chrome Remote Desktop, install it, then delete downloaded .deb package
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb && sudo dpkg -i chrome-remote-desktop* && sudo apt --fix-broken install --assume-yes && rm chrome-remote-desktop*
# Remove Tmp
sudo rm -rf "$gui_setup"
cd "$origin"
#EOF
