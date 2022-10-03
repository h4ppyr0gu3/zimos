# This is a default template for a post-install scriptlet.
# Uncomment only required functions and remove any functions
# you don't need (and this header).

## arg 1:  the new package version
#pre_install() {

#}

## arg 1:  the new package version
post_install() {
  sudo systemctl enable tlp
  sudo systemctl disable getty@tty2.service
  sudo systemctl enable ly
  nvim --headless -c +PackerInstall +q
  if [ -f $HOME/Screenshots ]; then 
    mkdir $HOME/Screenshots 
  fi
  print_logo
}

## arg 1:  the new package version
## arg 2:  the old package version
#pre_upgrade() {
#}

## arg 1:  the new package version
## arg 2:  the old package version
post_upgrade() {
  nvim --headless -c +PackerInstall +q
  print_logo
}

print_logo() {
  printf "\n"
  printf "\n"
  COLUMNS=$(tput cols) 
  line1=" oooooooooooo ooooo ooo        ooooo   .oooooo.    .oooooo..o "
  line2="d'\"\"\"\"\"\"d888' \`888' \`88.       .888'  d8P'  \`Y8b  d8P'    \`Y8 "
  line3="      .888P    888   888b     d'888  888      888 Y88bo.      "
  line4="     d888'     888   8 Y88. .P  888  888      888  \`\"Y8888o.  "
  line5="   .888P       888   8  \`888'   888  888      888      \`\"Y88b "
  line6="  d888'    .P  888   8    Y     888  \`88b    d88' oo     .d8P "
  line7=".8888888888P  o888o o8o        o888o  \`Y8bood8P'  8\"\"88888P'  "
  printf "${GREEN}%*s\n" $(((${#line1}+$COLUMNS)/2)) "$line1"
  printf "${YELLOW}%*s\n" $(((${#line2}+$COLUMNS)/2)) "$line2"
  printf "${RED}%*s\n" $(((${#line2}+$COLUMNS)/2)) "$line3"
  printf "${BLACK}%*s\n" $(((${#line2}+$COLUMNS)/2)) "$line4"
  printf "${RED}%*s\n" $(((${#line2}+$COLUMNS)/2)) "$line5"
  printf "${YELLOW}%*s\n" $(((${#line2}+$COLUMNS)/2)) "$line6"
  printf "${GREEN}%*s\n" $(((${#line2}+$COLUMNS)/2)) "$line7"
  printf "${NC}\n"
}

## arg 1:  the old package version
#pre_remove() {
#	echo about to  do something here to remove
#}

## arg 1:  the old package version
#post_remove() {
	# do something here
#}
