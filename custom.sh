aur_clone () {
  cd $HOME/AUR
  pac_install git patch make
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

pipewire () {
  echo handle pipewire and wireplumber
  pac_install pipewire wireplumber
}

sway () {
  pac_install sway grim slurp neovim ranger ctags ripgrep fzf
  git clone https://github.com/h4ppyr0gu3/dotfiles.git ./dotfiles
  aur_clone https://aur.archlinux.org/libinput-gestures.git
  aur_clone https://aur.archlinux.org/lf.git
  mv -f ./dotfiles/sway/ $HOME/.config/sway
  mv -f ./dotfiles/scripts/ $HOME/.config/scripts
  mv -f ./dotfiles/qutebrowser/ $HOME/.config/qutebrowser
  mv -f ./dotfiles/alacritty/ $HOME/.config/alacritty
  mv -f ./dotfiles/nvim/ $HOME/.config/nvim
  mv -f ./dotfiles/libinput-gestures.conf $HOME/.config/libinput-gestures.conf
  mv -f ./dotfiles/mako/ $HOME/.config/mako
  mv -f ./dotfiles/sounds/ $HOME/.config/sounds
  mv -f ./dotfiles/ranger/ $HOME/.config/ranger
  mv -f ./dotfiles/wallpapers/ $HOME/.config/wallpapers
  rm -rf ./dotfiles
  mkdir -p $HOME/Screenshots
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}

zsh () {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  sudo chsh -s $(which zsh)
  git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  git clone https://github.com/unixorn/fzf-zsh-plugin.git $HOME/.oh-my-zsh/custom/plugins/fzf-zsh-plugin
  curl https://raw.githubusercontent.com/h4ppyr0gu3/dotfiles/master/.zshrc -o $HOME/.zshrc
}

custom_packages () {
  mkdir -p $HOME/AUR
  pac_install fakeroot git
  [[ " ${custom[*]} " =~ " asdf " ]] && asdf;
  [[ " ${custom[*]} " =~ " ly " ]] && ly;
  [[ " ${custom[*]} " =~ " pipewire " ]] && pipewire;
  [[ " ${custom[*]} " =~ " slack " ]] && slack;
  [[ " ${custom[*]} " =~ " sway " ]] && sway;
  [[ " ${custom[*]} " =~ " virtualization " ]] && virtualization;
  [[ " ${custom[*]} " =~ " zsh " ]] && zsh;
}

