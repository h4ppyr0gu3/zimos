#!bin/bash

read_packages () {
  if ! [ "$package_file" = "" ]; then 
    readarray -t packages < $package_file
  fi
}

read_custom () {
  if ! [ "$custom_file" = "" ]; then 
    readarray -t custom < $custom_file
  fi
}

pacman_install () {
  sudo pacman -Syu ${packages[*]}
}

custom_install () {
  for i in "${custom[@]}"; do
    $i
  done
}

rbenv () {
  echo rbenv install
}

crystal () {
}

rust () {
}

postman () {
}

ly () {
}

slack () {
  echo slack function
}

authy () {
}

teamviewer () {
}

###### CONFIGURE ######

zsh () {
}

alacritty () {
}

nvim () {
}

scripts () {
}

qutebrowser () {
}

nnn () {
}

ranger () {
}

sway () {
}

mako () {
}

neomutt () {
}
