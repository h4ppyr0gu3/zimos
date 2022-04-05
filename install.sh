#!/bin/bash

# sh -c 'curl -fLo /home/david/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# add non-free and contrib to sources.list

# sudo cp -r ./wallpaper /usr/share/backgrounds/wallpapers

# gebaar input
# dependencies and make 
# git clone https://github.com/Coffee2CodeNL/gebaar-libinput

# Postgres
# sudo su - postgres
# psql
#  sudo su - postgres -c "createuser -d -P david" 

# js 
# sudo apt install npm
# sudo npm install -g n
# sudo npm install -g nvm
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash


# Screenshot grim + slurp
# sudo apt install llibcairo2-dev wayland-protocols libwayland-dev libxkbcommon-dev
# git clone --depth 1 https://github.com/emersion/slurp.git
# cd slurp
# meson build
# ninja -C build
# install -m 755 build/slurp /usr/local/bin
# rm -rf slurp
# git clone --depth 1 https://github.com/emersion/grim.git
# cd grim
# meson build
# ninja -C build
# install -m 755 build/grim /usr/local/bin
# rm -rf grim
# mkdir /home/$user/Screenshots

# Pipewire
# touch /etc/pipewire/media-session.d/with-pulseaudio
# cp /usr/share/doc/pipewire/examples/systemd/user/pipewire-pulse.* /etc/systemd/user/
# systemctl --user daemon-reload
# ➜  setup_v2 git:(master) ✗ systemctl --user --now disable pulseaudio.service pulseaudio.socket
# ➜  setup_v2 git:(master) ✗ systemctl --user --now enable pipewire pipewire-pulse
# ➜  setup_v2 git:(master) ✗ LANG=C pactl info | grep '^Server Name'
# Server Name: PulseAudio (on PipeWire 0.3.19)
# ➜  setup_v2 git:(master) ✗ systemctl --user mask pulseaudio
# Created symlink /home/david/.config/systemd/user/pulseaudio.service → /dev/null.

# neovim config: ./init.vim
# wallpaper library: 
# icon packs: Bonny-Dark-Icons
# installed applications

# ANSI escape codes for printf
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

GREEN='\033[0;32m'
RED='\033[0;31m'
ORANGE='\033[0;33m'
NC='\033[0m'
user=$(whoami)
current_dir=$(pwd)
package_dir="${current_dir}/pkgs.txt"
ADDITIONAL=1
DESKTOP=1
SERVER=1
DEBUG=1
DEBIAN=1
ARCH=1
kernel=""
available_languages=( "ruby" "python" )
available_custom=( "ly" "slack" "postman" "postgres" "zsh" "alt" )
languages=()
custom=()

main () {
  parse_params $@
  verify_parameters
  accept_parameters
  read_packages    
  run_install
  custom_install
  language_install
}

debug () {
  if [ $DEBUG -eq 0 ]; then
    echo -e "${ORANGE}DEBUG INFO: $1 ${NC}"
  fi
}

print_help () {
  echo print_help
}

parse_params () {
  while [ "$1" != "" ]
  do
    case "$1" in
      -k | --kernel)
        if [ "$2" = "" ]
        then
          echo -e "${RED}ERROR: No kernel given ${NC}" ; exit
        fi
        kernel=$2 ; shift 2 ;;
      -d | --desktop) DESKTOP=0 ; shift ;;  
      -s | --server) SERVER=0 ; shift ;;
      -a | --additional) ADDITIONAL=0 ; shift ;;
      -arch) ARCH=$(0) ; shift ;;
      -deb) DEBIAN=$(0) ; shift ;;
      -l | --language) 
        while [[ $2 =~ ^[a-zA-Z]+$ ]] && [[ $2 != "" ]]; do
          if ! [[ " ${available_languages[*]} " =~ " $2 " ]]; then 
            echo language not available: $2
            echo available languages: ${available_languages[*]}
            exit
          fi
          languages+=$2
          shift
        done
        shift ;;
      -p | --package-dir)
        if [[ $2 =~ ^/ ]]; then 
          package_dir=$2 
          shift 2
        else
          echo -e "${RED}ERROR: incorrect file path, please use full path ${NC}" ; exit
        fi
        ;;
      -c | --custom) 
        while [[ $2 =~ ^[a-zA-Z]+$ ]] && [[ $2 != "" ]]; do
          custom+=$2
          shift
        done
        shift ;;
      --debug) DEBUG=0 ; shift ;;
      -h | --help) print_help ; exit ;;
      *) echo -e "${ORANGE}WARNING: Unknown argument ${NC}\"$1\"" ; shift ;;
    esac
  done
}

verify_parameters () {
  if [ $DESKTOP -eq 1 ] && [ $SERVER -eq 1 ] && [ $ADDITIONAL -eq 1 ];
  then
    printf "${RED}ERROR: please specify either desktop, server or additional installation${NC}\n" ; exit
  fi
}

accept_parameters () {
  echo "###############################################################################################"
  echo -e "#    ${GREEN}\\    /          _     ___                                _ ${NC}                              #" 
  echo -e "#    ${GREEN} \\  /  _   _ ._|_\\/    |  _  _ _|_ _ || _ _|_ . _  _    |_) _   _ _ __  _ _|_ _   _ _${NC}    #"
  echo -e "#    ${GREEN}  \\/  (/_ |  | | /    _|_| |_>  |_(_|||(_| |_ |(_)| |   |  (_| | (_||||(/_ |_(/_ | _>${NC}    #"
  echo -e "#                              ${GREEN}Verify installation parameters${NC}                                 #"
  echo "###############################################################################################"
  printf "\n"

  if [ $DESKTOP -eq 0 ]; then
    echo Desktop installation
  fi

  if [ $SERVER -eq 0 ] && [ $DESKTOP -eq 1 ]; then
    echo Server installation
  fi

  if [ $ADDITIONAL -eq 0 ]; then 
    echo Additional software installation
  fi

  if ! [ "$kernel" = "" ]; then 
    echo Kernel-version: $kernel 
  fi

  if ! [ "$languages" = "" ]; then
    echo Languages: $languages
  fi

  if ! [ "$custom" = "" ]; then
    echo Custom/git software: $custom
  fi

  if [ $ADDITIONAL -eq 1 ]; then
    if ! [ "$package_dir" = "" ]; then 
      echo package.txt directory: $package_dir 
    else
      echo Using default package directory: $package_dir
    fi
  fi

  printf "\n###############################################################################################\n"
  read -p "Do you want to continue with install (y/n): " response

  if [[ $response = y* ]] || [[ $response = Y* ]]; then
    echo Starting installation
  else
    echo Not installing ; exit
  fi
}

read_packages () {
  readarray -t packages < $package_dir
  debug "packages to be installed: ${packages[*]}"
}

run_install () {
  if [ $ARCH -eq 1 ]; then 
    source "$current_dir/languages_arch.sh"
    source "$current_dir/custom_arch.sh"
  fi
  if [ $DEBIAN -eq 1 ]; then 
    source "$current_dir/languages_debian.sh"
    source "$current_dir/custom_debian.sh"
  fi
}

main "$@"
