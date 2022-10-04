# Maintainer: David Rogers <rogersdpdr@gmail.com>
pkgname=zimos
pkgver=0.0.2
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
'qbittorrent' 'valgrind' 'vlc' 'mpv' 'wl-clipboard' 'xdg-desktop-portal-wlr' 'sudo'
'xdg-desktop-portal' 'man-db' 'mokutil' 'lsof' 'exa' 'nginx' 'kubectl' 'grpc' 
'gnome-calculator' 'wireshark-qt' 'feh' 'ffmpeg' 'waybar' 'redis' 'postgresql' 
'pavucontrol' 'openssh' 'openvpn' 'audacious' 'wofi' 'fakeroot' 'patch' 'make'
'rsync' 'git' 'curl' 'bison' 'upower' 'zathura' 'zathura-pdf-poppler'
)
source=(
    "git+https://github.com/h4ppyr0gu3/dotfiles.git"
    )
sha256sums=('SKIP')


install=install

# next steps: 
# add environment variables to environment
# configure global git settings

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
  cp $srcdir/dotfiles/.zshrc $HOME/.zshrc
  mv $HOME/.config/scripts                   $HOME/.config/scripts.old
  mv $HOME/.config/alacritty                 $HOME/.config/alacritty.old
  mv $HOME/.config/cronjobs                  $HOME/.config/cronjobs.old
  mv $HOME/.config/nvim                      $HOME/.config/nvim.old
  mv $HOME/.config/qutebrowser               $HOME/.config/qutebrowser.old
  mv $HOME/.config/scripts                   $HOME/.config/scripts.old
  mv $HOME/.config/sounds                    $HOME/.config/sounds.old
  mv $HOME/.config/sway                      $HOME/.config/sway.old
  mv $HOME/.config/wallpapers                $HOME/.config/wallpapers.old
  mv $HOME/.config/libinput-gestures.conf    $HOME/.config/libinput-gestures.old
  mv $HOME/.config/waybar                    $HOME/.config/waybar.old
  mv $HOME/.config/zathura                   $HOME/.config/zathura.old
  mv $HOME/.config/zsh                       $HOME/.config/zsh.old

  mv $srcdir/dotfiles/.config/scripts $HOME/.config/scripts
  mv $srcdir/dotfiles/.config/alacritty $HOME/.config/alacritty
  mv $srcdir/dotfiles/.config/cronjobs $HOME/.config/cronjobs
  mv $srcdir/dotfiles/.config/mako $HOME/.config/nvim
  mv $srcdir/dotfiles/.config/qutebrowser $HOME/.config/qutebrowser
  mv $srcdir/dotfiles/.config/scripts $HOME/.config/scripts
  mv $srcdir/dotfiles/.config/sounds $HOME/.config/sounds
  mv $srcdir/dotfiles/.config/sway $HOME/.config/sway
  mv $srcdir/dotfiles/.config/wallpapers $HOME/.config/wallpapers
  mv $srcdir/dotfiles/.config/libinput-gestures.conf $HOME/.config/libiput-gestures.conf
  mv $srcdir/dotfiles/.config/waybar $HOME/.config/waybar
  mv $srcdir/dotfiles/.config/zathura $HOME/.config/zathura
  mv $srcdir/dotfiles/.config/zsh $HOME/.config/zsh

  if [ -f $HOME/.cfg ]; then
    git init $HOME/.cfg --bare
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME remote set-url origin git@github.com:h4ppyr0gu3/dotfiles
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME pull origin master
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME add $HOME/.zshrc \
    $HOME/.config/scripts $HOME/.config/alacritty $HOME/.config/cronjobs \
    $HOME/.config/nvim $HOME/.config/qutebrowser $HOME/.config/scripts \
    $HOME/.config/sounds $HOME/.config/sway $HOME/.config/wallpapers \
    $HOME/.config/libiput-gestures.conf $HOME/.config/waybar $HOME/.config/zathura \
    $HOME/.config/zsh
  fi

  install -Dm644 $srcdir/../LICENSE.md "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}
