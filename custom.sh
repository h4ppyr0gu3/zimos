custom_packages () {
  mkdir -p $HOME/AUR
  # sudo pacman -Sy fakeroot git
  if [[ " ruby " =~ " ${custom[*]} " ]]; then ruby; fi
  if [[ " crystal " =~ " ${custom[*]} " ]]; then crystal; fi
  if [[ " elixir " =~ " ${custom[*]} " ]]; then elixir; fi
  if [[ " virtualization " =~ " ${custom[*]} " ]]; then virtualization; fi
}

aur_clone () {
  cd $HOME/AUR
  files_before=($(ls -f))
  git clone $1
  files_after=($(ls -f))
  directory=$(echo ${files_before[@]} ${files_after[@]} | tr ' ' '\n' | sort | uniq -u)
  cd $directory
  makepkg -si
  cd $HOME
}

ruby () {
  aur_clone https://aur.archlinux.org/rbenv.git
}

ly () {
  aur_clone https://aur.archlinux.org/ly.git
  sudo systemctl enable ly.service
  sudo systemctl disable getty@tty2.service
}

crystal () {
  echo crystal
}

slack () {
  aur_clone https://aur.archlinux.org/slack-desktop.git
}

elixir () {
  echo elixir
}

virtualization () {
  echo elixir
}

screenshots () {
  mkdir $HOME/Screenshots
  sudo pacman -Sy grim slurp
}

sway () {
  echo sway
}

zsh () {
  echo zsh
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
      sudo chsh -s $(which zsh)
      git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
}
