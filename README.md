# ZimOS

The script will install and set all the defaults and my preferences

```
Welcome to the ZimOS installation script

This expects you to:
- be running an ARCH based distro
- have pkgs.txt in the directory you run this script from
- have custom.txt in the directory you run this script from

Usage: ./zimos.sh [OPTION]
Example: './zimos.sh i'
OPTIONS:
    -i, --install, i, install         Install packages from files
    -u, --uninstall, u, uninstall     Uninstall packages from files
    -h, --help, h, help               Print this help

N.B. This is a minimal install to have a working Desktop Environment
     although it can be extended through the packages
```

The minimal packages required to be installed are in the `pkgs.txt` and additional pre-configured packages are in `custom.txt`.
There are several preconfigured options that can be put into the `custom.txt` file:
- asdf
- ly
- slack
- sway
- virtualization (**NB.** Not implemented yet)
- pipewire (**NB.** Not implemented yet)
- zsh

## Default packages installed and configured

- zathura
- mako
- nvim
- pipewire (**NB.** Not implemented yet)
- vlc
- firefox
- sway
- slack
- asdf

All listings in the `pkgs.txt` file have to be available in the pacman repository to be installed

## Installation

```bash
git clone https://github.com/h4ppyr0gu3/setup_v2
cd setup_v2 
./zimos i
```

## Contributing

If you'd like additional custom configurations please add them in the `custom.sh` file and update the README, then create a Pull Request
