aur_clone () {
  cd $HOME/AUR
  pac_install git
  files_before=($(ls -f))
  git clone $1
  files_after=($(ls -f))
  directory=$(echo ${files_before[@]} ${files_after[@]} | tr ' ' '\n' | sort | uniq -u)
  cd $directory
  makepkg -si
  cd $HOME
}

asdf () {
  aur_clone https://aur.archlinux.org/asdf-vm.git
  echo ". /opt/asdf-vm/asdf.sh" >> $HOME/.zshrc
  echo ". /opt/asdf-vm/asdf.sh" >> $HOME/.bashrc
}

ly () {
  aur_clone https://aur.archlinux.org/ly.git
  sudo systemctl enable ly.service
  sudo systemctl disable getty@tty2.service
}

slack () {
  aur_clone https://aur.archlinux.org/slack-desktop.git
}

virtualization () {
  echo virtualization env
}

sway () {
  pac_install sway grim slurp neovim ranger
  git clone https://github.com/h4ppyr0gu3/dotfiles.git
  aur_clone https://aur.archlinux.org/libinput-gestures.git
  mv -rf ./dotfiles/sway/ $HOME/.config/sway
  mv -rf ./dotfiles/scripts/ $HOME/.config/scripts
  mv -rf ./dotfiles/qutebrowser/ $HOME/.config/qutebrowser
  mv -rf ./dotfiles/alacritty/ $HOME/.config/alacritty
  mv -rf ./dotfiles/nvim/ $HOME/.config/nvim
  mv ./dotfiles/.libinput-gestures.conf $HOME/.config/.libinput-gestures.conf
  mv -rf ./dotfiles/mako/ $HOME/.config/mako
  mv -rf ./dotfiles/sounds/ $HOME/.config/sounds
  mv -rf ./dotfiles/ranger/ $HOME/.config/ranger
  mv -rf ./dotfiles/wallpapers/ $HOME/.config/wallpapers
  rm -rf dotfiles
  mkdir -p $HOME/Screenshots
}

zsh () {
  echo zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  sudo chsh -s $(which zsh)
  git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  curl https://raw.githubusercontent.com/h4ppyr0gu3/dotfiles/master/.zshrc -o $HOME/.zshrc
}

custom_packages () {
  mkdir -p $HOME/AUR
  pac_install fakeroot git
  echo asdf
  echo ${custom[@]}
  echo ${custom[*]}
  echo ${#custom[*]}
  [[ " ${custom[*]} " =~ " asdf " ]] && asdf;
  [[ " ${custom[*]} " =~ " ly " ]] && ly;
  [[ " ${custom[*]} " =~ " slack " ]] && slack;
  [[ " ${custom[*]} " =~ " sway " ]] && sway;
  [[ " ${custom[*]} " =~ " zsh " ]] && zsh;
}

