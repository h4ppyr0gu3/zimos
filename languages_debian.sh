language_install () { 
  ruby_install
  crystal_install
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

crystal_install () {
  if [[ " crystal " =~ " ${languages[*]} " ]] ;
  then
    debug "installing crystal lang" 
    debug "add to sources.list" 
    echo 'deb http://download.opensuse.org/repositories/devel:/languages:/crystal/Debian_Unstable/ /' | sudo tee -a /etc/apt/sources.list
    debug "add gpg key"
    curl -fsSL https://download.opensuse.org/repositories/devel:languages:crystal/Debian_Unstable/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/devel_languages_crystal.gpg > /dev/null
    debug "apt update"
    sudo apt update
    debug "install crystal and dependencies"
    sudo apt install crystal libpcre3-dev libgc-dev libevent-dev libssl-dev libxml2-dev libyaml-dev libgmp-dev libz-dev   
  fi 
}                                                            
