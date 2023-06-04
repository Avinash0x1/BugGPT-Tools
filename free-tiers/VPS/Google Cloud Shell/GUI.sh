#!/bin/bash
#Enter a tmp dir
cd $(mktemp -d)
#Setup Deps
sudo apt update && sudo apt install xvfb xfce4 xfce4-goodies mpv kdenlive simplescreenrecorder firefox-esr plank papirus-icon-theme dbus-x11 neofetch krita --assume-yes
# Download Chrome Remote Desktop, install it, then delete downloaded .deb package
wget --quiet https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb && sudo dpkg -i chrome-remote-desktop* && sudo apt --fix-broken install --assume-yes
rm chrome-remote-desktop*
#eget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb --to /tmp/Chrome

# Install Catppuccin themes for terminal
sudo apt install sassc --assume-yes
git clone https://github.com/catppuccin/gtk.git && cd gtk && sudo make build && sudo make package && cd pkgs && sudo cp * /usr/share/themes && cd /usr/share/themes
#Unzip Themes
sudo unzip '/usr/share/themes/Catppuccin-dark.zip'
sudo unzip '/usr/share/themes/Catppuccin-dark-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-dark-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-green.zip'
sudo unzip '/usr/share/themes/Catppuccin-green-dark.zip'
sudo unzip '/usr/share/themes/Catppuccin-green-dark-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-green-dark-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-green-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-green-light.zip'
sudo unzip '/usr/share/themes/Catppuccin-green-light-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-green-light-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-green-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-grey.zip'
sudo unzip '/usr/share/themes/Catppuccin-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-light.zip'
sudo unzip '/usr/share/themes/Catppuccin-light-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-light-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-orange.zip'
sudo unzip '/usr/share/themes/Catppuccin-orange-dark.zip'
sudo unzip '/usr/share/themes/Catppuccin-orange-dark-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-orange-dark-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-orange-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-orange-light.zip'
sudo unzip '/usr/share/themes/Catppuccin-orange-light-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-orange-light-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-orange-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-pink.zip'
sudo unzip '/usr/share/themes/Catppuccin-pink-dark.zip'
sudo unzip '/usr/share/themes/Catppuccin-pink-dark-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-pink-dark-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-pink-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-pink-light.zip'
sudo unzip '/usr/share/themes/Catppuccin-pink-light-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-pink-light-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-pink-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-purple.zip'
sudo unzip '/usr/share/themes/Catppuccin-purple-dark.zip'
sudo unzip '/usr/share/themes/Catppuccin-purple-dark-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-purple-dark-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-purple-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-purple-light.zip'
sudo unzip '/usr/share/themes/Catppuccin-purple-light-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-purple-light-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-purple-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-red.zip'
sudo unzip '/usr/share/themes/Catppuccin-red-dark.zip'
sudo unzip '/usr/share/themes/Catppuccin-red-dark-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-red-dark-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-red-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-red-light.zip'
sudo unzip '/usr/share/themes/Catppuccin-red-light-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-red-light-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-red-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-teal.zip'
sudo unzip '/usr/share/themes/Catppuccin-teal-dark.zip'
sudo unzip '/usr/share/themes/Catppuccin-teal-dark-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-teal-dark-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-teal-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-teal-light.zip'
sudo unzip '/usr/share/themes/Catppuccin-teal-light-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-teal-light-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-teal-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-yellow.zip'
sudo unzip '/usr/share/themes/Catppuccin-yellow-dark.zip'
sudo unzip '/usr/share/themes/Catppuccin-yellow-dark-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-yellow-dark-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-yellow-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-yellow-light.zip'
sudo unzip '/usr/share/themes/Catppuccin-yellow-light-hdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-yellow-light-xhdpi.zip'
sudo unzip '/usr/share/themes/Catppuccin-yellow-xhdpi.zip' 
sudo rm *.zip

# Install Catppuccin Plank theme
cd $(mktemp -d) && git clone https://github.com/catppuccin/plank.git && cd plank && sudo cp -r Catppuccin /usr/share/plank/themes && sudo cp -r Catppuccin-solid /usr/share/plank/themes
