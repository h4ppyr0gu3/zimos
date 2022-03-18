#!/bin/bash

# https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip font file url
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
package_dir="${current_dir}/packages.txt"
DESKTOP=1
SERVER=1
kernel=""
available_languages=( "ruby" "python" )
available_custom=( "ly" )
languages=()
custom=()

main () {
    echo $user
    echo $package_dir
    parse_params $@
    verify_parameters
    accept_parameters
    install
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
                    echo -e "${RED}ERROR: No kernel given ${NC}"
                    exit
                fi
                kernel=$2
                shift 2
                ;;
            -d | --desktop)
                DESKTOP=$(echo 0)
                shift
                ;;  
            -s | --server)
                SERVER=$(0)
                shift
                ;;
            -l | --language) 
                while [[ $2 =~ ^[a-zA-Z]+$ ]] && [[ $2 != "" ]] ; do
                    if ! [[ " ${available_languages[*]} " =~ " $2 " ]] ;
                    then 
                        echo language not available: $2
                        echo available languages: ${available_languages[*]}
                        exit
                    fi
                    languages+=$2
                    shift
                done
                shift
                ;;
            -p | --package-dir)
                if [[ $2 =~ ^/ ]]; then 
                    package_dir=$2 
                    shift 2
                else
                    echo -e "${RED}ERROR: incorrect file path, please use full path ${NC}"
                    exit
                fi
                ;;
            -c | --custom) 
                while [[ $2 =~ ^[a-zA-Z]+$ ]] && [[ $2 != "" ]] ; do
                    custom+=$2
                    shift
                done
                shift
                ;;
            -h | --help)
                print_help
                exit
                ;;
            *)
                echo -e "${ORANGE}WARNING: Unknown argument ${NC}\"$1\""
                shift
                ;;
        esac
    done
}

verify_parameters () {
if [ $DESKTOP -eq 1 ] && [ $SERVER -eq 1 ];
then
    echo please specify either desktop or server installation
    exit
fi


}

accept_parameters () {
    echo "###############################################################################################"
    echo "###############################################################################################"
    echo "###############################################################################################"
    echo -e "###  ${GREEN}\\    /          _     ___                                _ ${NC}                            ###" 
    echo -e "###  ${GREEN} \\  /  _   _ ._|_\\/    |  _  _ _|_ _ || _ _|_ . _  _    |_) _   _ _ __  _ _|_ _   _ _${NC}  ###"
    echo -e "###  ${GREEN}  \\/  (/_ |  | | /    _|_| |_>  |_(_|||(_| |_ |(_)| |   |  (_| | (_||||(/_ |_(/_ | _>${NC}  ###"
    echo -e "###                            ${GREEN}Verify installation parameters${NC}                               ###"
    echo "###############################################################################################"
    echo "###############################################################################################"
    echo "###############################################################################################"
    printf "\n"

    if [ $DESKTOP -eq 0 ];
    then
        echo Desktop installation
    fi

    if [ $SERVER -eq 0 ] && [ $DESKTOP -eq 1 ];
    then
        echo Server installation
    fi

    if ! [ "$kernel" = "" ]; 
    then 
        echo Kernel-version: $kernel 
    fi

    if ! [ "$languages" = "" ];
    then
        echo Languages: $languages
    fi

    if ! [ "$custom" = "" ];
    then
        echo Custom/git software: $custom
    fi

    if ! [ "$package_dir" = "" ]; 
    then 
        echo package.txt directory: $package_dir 
    else
        echo Using default package directory: $package_dir
    fi

    printf "\n"
    echo "###############################################################################################"
    printf "\n"
    read -p "Do you want to continue with install (y/n): " response

    if [[ $response = y* ]] || [[ $response = Y* ]] ;
    then
        echo Starting installation
    else
        echo Not installing
        exit
    fi
}

install () {
    sudo apt update && sudo apt upgrade

    sudo apt install $kernel_version
    sudo apt install < $package_dir -y
}

main "$@"
