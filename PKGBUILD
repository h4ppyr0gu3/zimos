# Maintainer: David Rogers <rogersdpdr@gmail.com>
pkgname=zimos
pkgver=0.0.2
pkgrel=0
pkgdesc="the presidents installation script"
arch=('x86_64')
url="https://github.com/h4ppyr0gu3/zimos"
license=('custom:WTFPL')
makedepends=('git' 'curl')
depends=(
'sway' 'swaylock' 'swaybg' 'neovim' 'flatpak' 'firefox-developer-edition' 'alacritty'
'nautilus' 'qutebrowser' 'bluez' 'wireplumber' 'zsh' 'w3m' 'htop' 'gdb' 'swayidle'
'slurp' 'grim' 'ripgrep' 'fzf' 'networkmanager' 'mako' 'jq' 'curl' 'brightnessctl'
'asciinema' 'cronie' 'ncdu' 'net-tools' 'docker' 'docker-compose' 'neofetch' 'git'
'playerctl' 'net-tools' 'nmap' 'traceroute' 'aircrack-ng' 'pipewire' 'pipewire-pulse'
'qbittorrent' 'valgrind' 'vlc' 'mpv' 'wl-clipboard' 'xdg-desktop-portal-wlr' 'sudo'
'xdg-desktop-portal' 'man-db' 'mokutil' 'lsof' 'exa' 'nginx' 'kubectl' 'grpc' 
'gnome-calculator' 'wireshark-qt' 'feh' 'ffmpeg' 'waybar' 'redis' 'postgresql' 
'pavucontrol' 'openssh' 'openvpn' 'audacious' 'wofi' 'fakeroot' 'patch' 'make'
'rsync' 'tlp' 'bison' 'upower' 'zathura' 'zathura-pdf-poppler'
)
source=(
    "git+https://github.com/h4ppyr0gu3/dotfiles2.git"
    )
sha256sums=('SKIP')


install=install.sh

prepare() {
  if [ -f $HOME/.aur ]; then
    mkdir $HOME/.aur
    aur_packages
  fi
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  install_zsh
  if [ -f $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
  fi
  flatpak install flathub -y --noninteractive slack kdenlive insomnia
}

aur_packages() {
  aur_clone https://aur.archlinux.org/asdf-vm.git
  aur_clone https://aur.archlinux.org/ly.git
  aur_clone https://aur.archlinux.org/libinput-gestures.git
  aur_clone https://aur.archlinux.org/yay.git
  aur_clone https://aur.archlinux.org/ydotool-bin.git
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

install_zsh() {
  if [ -f $HOME/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    sudo chsh -s $(which zsh)
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/unixorn/fzf-zsh-plugin.git $HOME/.oh-my-zsh/custom/plugins/fzf-zsh-plugin
  fi
}

package() {
  rm -rf $HOME/.config
  mv $srcdir/dotfiles2/.config $HOME/.config
  mv $srcdir/dotfiles2/.zshrc $HOME/.zshrc
  install -Dm644 $srcdir/dotfiles2/LICENSE.md "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
  /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME remote set-url origin git@github.com:h4ppyr0gu3/dotfiles
}
