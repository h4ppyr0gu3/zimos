# Maintainer: David Rogers <rogersdpdr@gmail.com>
pkgname=zimos
pkgver=0.1.0
pkgrel=0
pkgdesc="the presidents installation script"
arch=('x86_64')
url="https://github.com/h4ppyr0gu3/zimos"
license=('custom:WTFPL')
makedepends=('git' 'curl' 'rsync')
depends=(
'sway' 'swaylock' 'swaybg' 'neovim' 'flatpak' 'firefox-developer-edition' 'alacritty'
'nautilus' 'qutebrowser' 'bluez' 'wireplumber' 'zsh' 'w3m' 'htop' 'gdb' 'swayidle'
'slurp' 'grim' 'ripgrep' 'fzf' 'networkmanager' 'mako' 'jq' 'brightnessctl' 'tlp'
'asciinema' 'cronie' 'ncdu' 'net-tools' 'docker' 'docker-compose' 'neofetch'
'playerctl' 'net-tools' 'nmap' 'traceroute' 'aircrack-ng' 'pipewire' 'pipewire-pulse'
'qbittorrent' 'valgrind' 'mpv' 'wl-clipboard' 'xdg-desktop-portal-wlr' 'sudo'
'xdg-desktop-portal' 'man-db' 'mokutil' 'lsof' 'exa' 'nginx' 'kubectl' 'grpc' 
'gnome-calculator' 'wireshark-qt' 'feh' 'ffmpeg' 'waybar' 'redis' 'postgresql' 
'pavucontrol' 'openssh' 'openvpn' 'audacious' 'wofi' 'fakeroot' 'patch' 'make'
'rsync' 'git' 'curl' 'bison' 'upower' 'zathura' 'zathura-pdf-poppler' 'bluez-utils'
'xorg-xwayland' 'kubectx' 'dnsmasq' 'xdg-desktop-portal-gtk' 'tesseract-data-eng'
'tesseract' 'binutils'
)
source=(
    "git+https://github.com/h4ppyr0gu3/dotfiles.git"
    )
sha256sums=('SKIP')

install=install

prepare() {

  if [ ! -d $HOME/.aur ]; then
    mkdir $HOME/.aur
    aur_packages
  fi

  flatpak_packages
  install_zsh
  configure_git
  prepare_dotfiles
  move_dotfiles
  init_git_cfg
  enable_services
}

package() {
  print_logo
  install -Dm644 $srcdir/../LICENSE.md "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
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

configure_git() {
  git config --global alias.co checkout
  git config --global alias.st status
  git config --global alias.br branch
  git config --global push.default simple
  git config --global pull.rebase true
  git config --global fetch.prune true
  git config --global core.pager 'less -x2'
  git config --global core.editor 'nvim'
  git config --global --add merge.ff false
  git config --global --add pull.ff only
  git config --global grep.lineNumber true
  git config --global diff.wsErrorHighlight all
  git config --global alias.conflicts 'diff --name-only --diff-filter=U'
  git config --global alias.change 'diff --name-only'
  git config --global commit.gpgsign true
}

install_zsh() {
  if [ ! -d $HOME/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    sudo chsh -s $(which zsh)
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/unixorn/fzf-zsh-plugin.git $HOME/.oh-my-zsh/custom/plugins/fzf-zsh-plugin
  fi
}

flatpak_packages() {
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  flatpak install flathub -y --noninteractive slack kdenlive insomnia
}

prepare_dotfiles() {
  if [ -d $HOME/.config ]; then
    rm -rf $HOME/.config/*.old
  else 
    mkdir $HOME/.config
  fi

  [ -f $HOME/.zshrc ] && mv $HOME/.zshrc       $HOME/.zshrc.old
  [ -d $HOME/.config/scripts ] && mv $HOME/.config/scripts   $HOME/.config/scripts.old
  [ -d $HOME/.config/alacritty ] && mv $HOME/.config/alacritty $HOME/.config/alacritty.old
  [ -d $HOME/.config/cronjobs ] && mv $HOME/.config/cronjobs  $HOME/.config/cronjobs.old
  [ -d $HOME/.config/nvim ] && mv $HOME/.config/nvim  $HOME/.config/nvim.old
  [ -d $HOME/.config/mako ] && mv $HOME/.config/mako  $HOME/.config/mako.old
  [ -d $HOME/.config/qutebrowser ] && mv $HOME/.config/qutebrowser $HOME/.config/qutebrowser.old
  [ -d $HOME/.config/sounds ] && mv $HOME/.config/sounds      $HOME/.config/sounds.old
  [ -d $HOME/.config/sway ] && mv $HOME/.config/sway        $HOME/.config/sway.old
  [ -d $HOME/.config/wallpapers ] && mv $HOME/.config/wallpapers  $HOME/.config/wallpapers.old
  [ -f $HOME/.config/libinput-gestures.conf ] && mv $HOME/.config/libinput-gestures.conf  $HOME/.config/libinput-gestures.old
  [ -d $HOME/.config/waybar ] && mv $HOME/.config/waybar      $HOME/.config/waybar.old
  [ -d $HOME/.config/zathura ] && mv $HOME/.config/zathura     $HOME/.config/zathura.old
  [ -d $HOME/.config/zsh ] && mv $HOME/.config/zsh  $HOME/.config/zsh.old
  # I don't know why this works but it does
  echo ""
}

move_dotfiles() {
  mv $srcdir/dotfiles/.zshrc $HOME/.zshrc
  mv $srcdir/dotfiles/.config/scripts $HOME/.config/scripts
  mv $srcdir/dotfiles/.config/alacritty $HOME/.config/alacritty
  mv $srcdir/dotfiles/.config/nvim $HOME/.config/nvim
  mv $srcdir/dotfiles/.config/cronjobs $HOME/.config/cronjobs
  mv $srcdir/dotfiles/.config/mako $HOME/.config/mako
  mv $srcdir/dotfiles/.config/qutebrowser $HOME/.config/qutebrowser
  mv $srcdir/dotfiles/.config/sounds $HOME/.config/sounds
  mv $srcdir/dotfiles/.config/sway $HOME/.config/sway
  mv $srcdir/dotfiles/.config/wallpapers $HOME/.config/wallpapers
  mv $srcdir/dotfiles/.config/libinput-gestures.conf $HOME/.config/libinput-gestures.conf
  mv $srcdir/dotfiles/.config/waybar $HOME/.config/waybar
  mv $srcdir/dotfiles/.config/zathura $HOME/.config/zathura
  mv $srcdir/dotfiles/.config/zsh $HOME/.config/zsh
}

init_git_cfg() {
  if [ ! -d $HOME/.cfg ]; then
    git init $HOME/.cfg --bare
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME add $HOME/.zshrc \
    $HOME/.config/scripts $HOME/.config/alacritty $HOME/.config/cronjobs \
    $HOME/.config/nvim $HOME/.config/qutebrowser $HOME/.config/zsh \
    $HOME/.config/sounds $HOME/.config/sway $HOME/.config/wallpapers \
    $HOME/.config/libinput-gestures.conf $HOME/.config/waybar $HOME/.config/zathura \
    $HOME/.config/mako
  fi
}

print_logo() {
  BLACK='\033[0;30m'
  printf "\n"
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
  printf "${NC}\n\n"

  echo To complete the installation you may need to run 
  echo                $ zimos i
  echo ""

}

enable_services() {
  sudo systemctl enable tlp
  sudo systemctl disable getty@tty2.service
  sudo systemctl enable ly
  if [ ! -d $HOME/screenshots ]; then 
    mkdir $HOME/screenshots 
  fi
}
