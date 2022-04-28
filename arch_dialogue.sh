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

