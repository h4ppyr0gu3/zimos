custom_install () {
    ly_install
    postman_install
    slack_install
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
        wget https://downloads.slack-edge.com/releases/linux/4.24.0/prod/x64/slack-desktop-4.24.0-amd64.deb 
        sudo dpkg -i slack-desktop-4.24.0-amd64.deb
    fi
}
