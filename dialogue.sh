#!/bin/bash

# ANSI escape codes for printf
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

BLUE='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
ORANGE='\033[0;33m'
YELLOW='\033[1;33m'
NC='\033[0m'
BLACK='\033[0;30m'

user=$(whoami)
current_dir=$(pwd)
CUSTOM=0
PKG=0
DEBIAN=0
ARCH=0
package_file=""
custom_file=""

main () {
  clear
  print_logo
  set_params
  verify_params
  install
}

debug () {
  if [ $DEBUG -eq 1 ]; then
    echo -e "${ORANGE}DEBUG INFO: $1 ${NC}"
  fi
}

print_help () {
  echo print_help
}

print_logo () {
  printf "\n"
  COLUMNS=$(tput cols) 
  line1=" oooooooooooo ooooo ooo        ooooo   .oooooo.    .oooooo..o "
  line2="d'\"\"\"\"\"\"d888' \`888' \`88.       .888'  d8P'  \`Y8b  d8P'    \`Y8 "
  line3="      .888P    888   888b     d'888  888      888 Y88bo.      "
  line4="     d888'     888   8 Y88. .P  888  888      888  \`\"Y8888o.  "
  line5="   .888P       888   8  \`888'   888  888      888      \`\"Y88b "
  line6="  d888'    .P  888   8    Y     888  \`88b    d88' oo     .d8P "
  line7=".8888888888P  o888o o8o        o888o  \`Y8bood8P'  8\"\"88888P'  "
  printf "${GREEN}%*s\n" $(((${#line1}+$COLUMNS)/2)) "$line1"
  printf "${YELLOW}%*s\n" $(((${#line2}+$COLUMNS)/2)) "$line2"
  printf "${RED}%*s\n" $(((${#line2}+$COLUMNS)/2)) "$line3"
  printf "${BLACK}%*s\n" $(((${#line2}+$COLUMNS)/2)) "$line4"
  printf "${RED}%*s\n" $(((${#line2}+$COLUMNS)/2)) "$line5"
  printf "${YELLOW}%*s\n" $(((${#line2}+$COLUMNS)/2)) "$line6"
  printf "${GREEN}%*s\n" $(((${#line2}+$COLUMNS)/2)) "$line7"
  printf "${NC}\n"
}

set_base () {
  printf "Select installation for:\n1) ${BLUE}ARCH${NC}\n2) ${RED}DEBIAN${NC}\n"
  read -p "choice: " inst
  if [ $inst -eq 1 ]; then ARCH=1; fi
  if [ $inst -eq 2 ]; then DEBIAN=1; fi
}

set_pkg_file () {
  read -p "Install packages from file? (y/n): " response
  if [[ $response = y* ]] || [[ $response = Y* ]]; then
    read -p "File Path: ~/" file_path
    echo installation file: $HOME/$file_path
    package_file="$HOME/$file_path"
  fi
}

set_custom_file () {
  read -p "PreConfigure available packages from file? (y/n): " response
  if [[ $response = y* ]] || [[ $response = Y* ]]; then
    read -p "File Path: ~/" file_path
    echo cofiguration file: $HOME/$file_path
    custom_file="$HOME/$file_path"
  fi
}

set_params () {
  set_base
  set_pkg_file
  set_custom_file
}

verify_params () {
  printf "\n"
  echo -e "${GREEN}Verify installation parameters${NC}"
  printf "\n"
  if [ $DEBIAN -eq 1 ]; then echo -e "${RED}DEBIAN${NC}"; fi
  if [ $ARCH -eq 1 ]; then echo -e "${BLUE}ARCH${NC}"; fi
  if ! [ "$package_file" = "" ]; then echo "Package file: $package_file"; fi
  if ! [ "$custom_file" = "" ]; then echo "PreConfigured file: $custom_file"; fi
  read -p "Continue with installation? (y/n): " response
  if [[ $response = y* ]] || [[ $response = Y* ]]; then
    echo installing...
  else
    echo exiting
    exit
  fi
}

install () {
  if [ $DEBIAN -eq 1 ]; then 
    source "$current_dir/debian_dialogue.sh"
  fi
  if [ $ARCH -eq 1 ]; then 
    source "$current_dir/arch_dialogue.sh"
  fi
  read_packages
  read_custom
  pacman_install
  custom_install
}

main "$@"
