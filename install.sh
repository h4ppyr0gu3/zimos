#!bin/bash

# https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip font file url
# neovim config: ./init.vim
# wallpaper library: 
# icon packs: Bonny-Dark-Icons
# installed applications

user=$(whoami)
packages=$(echo sudo firefox sway swayidle git build-essential bison brightnessctl nvim)

su - root
apt update && apt upgrade
apt install sudo -y
echo "$user ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/$user 
apt install $packages


exit


