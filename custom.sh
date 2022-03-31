custom_install () {
    ly_install
    postman_install
    slack_install
    zsh_install
    alt_install
    postgres_install
}


ly_install () {
    if [[ " ly " =~ " ${custom[*]} " ]] ;
    then 
        debug "beginning ly installation: cloning repo"
        git clone --recurse-submodules https://github.com/nullgemm/ly.git
        cd ly
        make
        debug "sudo making install"
        sudo make install
        debug "enable ly service"
        sudo systemctl enable ly.service
        debug "disable getty tty2 service"
        sudo systemctl disable getty@tty2.service
        cd ..
        debug "removing source code"
        rm -rf ly/
    fi
}

postman_install () {
    if [[ " postman " =~ " ${custom[*]} " ]] ;
    then
        snap install postman
    fi
}

slack_install () {
    if [[ " slack " =~ " ${custom[*]} " ]] ;
    then
      debug "installing Slack"
      sudo flatpak install -y --noninteractive slack    
    fi
}

zsh_install () {
    if [[ " zsh " =~ " ${custom[*]} " ]] ;
    then
      debug "configuring zsh"
      debug "installing oh-my-zsh"
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
      debug "setting shell to zsh"
      sudo chsh -s $(which zsh)
      debug "clone zsh autosuggestions"
      git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    fi
}

alt_install () {
    if [[ " alt " =~ " ${custom[*]} " ]] ;
    then
      debug "configuring flatpak"
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      debug "symlink snap to applications"
      sudo ln -s /var/lib/snapd/desktop/applications /usr/share/applications/snap
      debug "symlink flatpak to applications"
      sudo ln -s /var/lib/flatpak/exports/share/applications /usr/share/applications/flatpak 
    fi
}

postgres_install () {
    if [[ " postgres " =~ " ${custom[*]} " ]] ;
    then
      debug "configuring postgres"
      sudo su - postgres -c "createuser -d -P david" 
    fi
}
