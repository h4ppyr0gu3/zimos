# This is a default template for a post-install scriptlet.
# Uncomment only required functions and remove any functions
# you don't need (and this header).

## arg 1:  the new package version
#pre_install() {

#}

## arg 1:  the new package version
post_install() {
  sudo systemctl enable --now tlp
  sudo systemctl enable --now ly
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

## arg 1:  the new package version
## arg 2:  the old package version
#pre_upgrade() {
	# do something here
#}

## arg 1:  the new package version
## arg 2:  the old package version
post_upgrade() {
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

## arg 1:  the old package version
#pre_remove() {
#	echo about to  do something here to remove
#}

## arg 1:  the old package version
#post_remove() {
	# do something here
#}
