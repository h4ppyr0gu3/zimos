# this repository is a snapshot of my system in case of the unthinkable

the script will install and set all the defaults and my preferences
and also because i tend to break it quite often

# Debian

to add the created user to the sudoers file type the following command
as root user where $user is your user name 

``` bash 
apt install sudo -y
echo "$user ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/$user 
```

copy the packages.txt file and edit it how you would like

``` bash
wget url -o packages.txt
```

run the install script in the same directory as the package.txt file
or pass the packages flag to the script with the directory of the packages.txt file

``` bash 
sudo wget url -o - | sh 
```

or

``` bash
bash -c "$(wget -qO - '$url')" '' parameters
```

flags and options

`-k/--kernel [full image name ie: linux-image-5.16.0-4-amd64 ]`
    upgrades kernel to specified version 
    please ensure the specified version is available in default repo 

`-p/--package-dir [path/to/packages.txt]`
    installs packages specified in the file, not necessarily txt

`-d/--desktop` 
    specifies that the graphical environment will be installed

`-s/--server`
    specifes no graphical elements will be installed

`-l/--language [languages to install in list or file]`
    rust 
    ruby
    elixir
    python
    node
    go

`-c/--custom [custom package list from available packages not in apt repo]`
    ly display manager
    sirula launcher

    




David Rogers
