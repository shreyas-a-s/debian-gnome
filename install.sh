#!/bin/sh

# ██████╗ ███████╗██████╗ ██╗ █████╗ ███╗   ██╗       ██████╗ ███╗   ██╗ ██████╗ ███╗   ███╗███████╗
# ██╔══██╗██╔════╝██╔══██╗██║██╔══██╗████╗  ██║      ██╔════╝ ████╗  ██║██╔═══██╗████╗ ████║██╔════╝
# ██║  ██║█████╗  ██████╔╝██║███████║██╔██╗ ██║█████╗██║  ███╗██╔██╗ ██║██║   ██║██╔████╔██║█████╗
# ██║  ██║██╔══╝  ██╔══██╗██║██╔══██║██║╚██╗██║╚════╝██║   ██║██║╚██╗██║██║   ██║██║╚██╔╝██║██╔══╝
# ██████╔╝███████╗██████╔╝██║██║  ██║██║ ╚████║      ╚██████╔╝██║ ╚████║╚██████╔╝██║ ╚═╝ ██║███████╗
# ╚═════╝ ╚══════╝╚═════╝ ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝       ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝

# Customisation choice
customisationChoice() {
	echo 'Continue to install debian-customisation? (yes/no): ' && read -r customisation_choice
	if [ "$customisation_choice" != 'yes' ] && [ "$customisation_choice" != 'no' ]; then
		printf 'Invalid Choice! Keep in mind this is CASE-SENSITIVE.\n'
    customisationChoice
  fi
}

# QEMU Choice
qemuChoice() {
  echo 'Continue to install qemu and virt-manager? (yes/no): ' && read -r qemu_choice
  if [ "$qemu_choice" != 'yes' ] && [ "$qemu_choice" != 'no' ]; then
    printf 'Invalid Choice! Keep in mind this is CASE-SENSITIVE.\n'
    qemuChoice
  fi
}

# Shell Choice
shellChoice() {
	echo "Which shell you prefer to customise?"
	echo "[1] Bash only"
	echo "[2] Fish only"
	echo "[3] Both but set Bash as Interactive Shell"
	echo "[4] Both but set Fish as Interactive Shell"
	echo "[5] None"
	echo 'Choose an option (1/2/3/4/5) : ' && read -r shell_choice
	if ! [ "$shell_choice" -ge 1 ] || ! [ "$shell_choice" -le 4 ]; then
		printf 'Invalid Choice..!!!\n'
		shellChoice
	fi
}

# Function to install gnome extensions from cli
installGnomeExtension() {

  for extensionname in "$@"; do
    busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s "$extensionname"
    while ! gnome-extensions list | grep "$extensionname" > /dev/null; do :; done
    gnome-extensions enable "$extensionname"
  done

}

# Installation
customisationChoice
if [ "$customisation_choice" = 'yes' ]; then
  export customisation_choice
  qemuChoice && export qemu_choice
  shellChoice && export shell_choice
fi
sudo apt-get -y install gnome-core
sudo apt-get -y purge firefox-esr yelp gnome-terminal totem gnome-software gnome-characters gnome-contacts gnome-font-viewer gnome-logs byobu epiphany-browser && sudo apt-get -y install gnome-console gnome-tweaks gnome-text-editor gnome-shell-extension-gsconnect && sudo apt-get -y autoremove

# Symlink gedit to gnome-text-editor
sudo ln -s /usr/bin/gnome-text-editor /usr/bin/gedit

# Installing customisations
if [ "$customisation_choice" = 'yes' ]; then
  echo "Starting the installation.."
  cd ..; git clone -b de https://github.com/shreyas-a-s/debian-customisation.git && cd debian-customisation/ && ./install.sh
fi

# Install rounded window corners extension
installGnomeExtension rounded-window-corners@yilozt

# Enable GSConnect
gnome-extensions enable gsconnect@andyholmes.github.io
