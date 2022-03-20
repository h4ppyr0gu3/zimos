language_install () {
    ruby_install
    # crystal_install
}

ruby_install () {
    if [[ " ruby " =~ " ${languages[*]} " ]] ;
    then
        debug "rbenv install: cloning repo"
        git clone https://github.com/rbenv/rbenv.git /home/$user/.rbenv
        debug "making rbenv"
        cd /home/$user/.rbenv && src/configure && make -C src
        debug "adding to path"
        echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/$user/.bashrc
        echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/$user/.zshrc
        debug "rbenv init"
        /home/$user/.rbenv/bin/rbenv init
        mkdir /home/$user/.rbenv/plugins
        cd /home/$user/.rbenv/plugins
        debug "cloning rbenv ruby-build"
        git clone https://github.com/rbenv/ruby-build.git 
        cd
    fi
}
