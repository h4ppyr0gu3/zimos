#!/bin/bash

aur_clone() {
  cd $HOME/.aur
  files_before=($(ls -f))
  git clone $1
  files_after=($(ls -f))
  directory=$(echo ${files_before[@]} ${files_after[@]} | tr ' ' '\n' | sort | uniq -u)
  cd $directory
  makepkg -sicm --noconfirm --needed --noprogressbar
  cd $HOME
}

###############################################
# These are all custom installation functions #
#       The PKGBUILD file ends here           #
###############################################

aur_packages() {
  aur_clone https://aur.archlinux.org/asdf-vm.git
  aur_clone https://aur.archlinux.org/ly.git
  aur_clone https://aur.archlinux.org/libinput-gestures.git
  aur_clone https://aur.archlinux.org/yay.git
  aur_clone https://aur.archlinux.org/ydotool-bin.git
  aur_clone https://aur.archlinux.org/nerd-fonts-jetbrains-mono.git
}

aur_packages
