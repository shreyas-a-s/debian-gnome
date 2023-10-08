#!/bin/bash

echo -e "--------------------------------------------------------------------------------------------------"
echo "██████╗ ███████╗██████╗ ██╗ █████╗ ███╗   ██╗       ██████╗ ███╗   ██╗ ██████╗ ███╗   ███╗███████╗"
echo "██╔══██╗██╔════╝██╔══██╗██║██╔══██╗████╗  ██║      ██╔════╝ ████╗  ██║██╔═══██╗████╗ ████║██╔════╝"
echo "██║  ██║█████╗  ██████╔╝██║███████║██╔██╗ ██║█████╗██║  ███╗██╔██╗ ██║██║   ██║██╔████╔██║█████╗"
echo "██║  ██║██╔══╝  ██╔══██╗██║██╔══██║██║╚██╗██║╚════╝██║   ██║██║╚██╗██║██║   ██║██║╚██╔╝██║██╔══╝"
echo "██████╔╝███████╗██████╔╝██║██║  ██║██║ ╚████║      ╚██████╔╝██║ ╚████║╚██████╔╝██║ ╚═╝ ██║███████╗"
echo "╚═════╝ ╚══════╝╚═════╝ ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝       ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝"
echo -e "--------------------------------------------------------------------------------------------------"

# Customisation choice
function customisationChoice {
	read -r -p "Continue to install debian-customisation? (yes/no): " customisation_choice
	if [ "$customisation_choice" != 'yes' ] && [ "$customisation_choice" != 'no' ]; then
		echo -e "Invalid Choice! Keep in mind this is CASE-SENSITIVE.\n"
    	customisationChoice
  	fi
}

# QEMU Choice
function qemuChoice {
  read -r -p "Continue to install qemu and virt-manager? (yes/no): " qemu_choice
  if [ "$qemu_choice" != 'yes' ] && [ "$qemu_choice" != 'no' ]; then
    echo -e "Invalid Choice! Keep in mind this is CASE-SENSITIVE.\n"
    qemuChoice
  fi
}

# Shell Choice
function shellChoice {
	read -r -p "Which shell you prefer? (bash/fish) : " shell_choice
  if [ "$shell_choice" != 'bash' ] && [ "$shell_choice" != 'fish' ]; then
    echo -e "Invalid Choice! Keep in mind this is CASE-SENSITIVE.\n"
    shellChoice
  fi
}

# Installation
customisationChoice
if [ "$customisation_choice" = 'yes' ]; then
  export customisation_choice
  qemuChoice && export qemu_choice
  shellChoice && export shell_choice
fi
sudo apt-get -y install gnome-core
sudo apt-get -y purge firefox-esr yelp gnome-terminal totem && sudo apt-get -y install gnome-console gnome-tweaks gnome-text-editor && sudo apt-get -y autoremove

# Symlink gedit to gnome-text-editor
sudo ln -s /usr/bin/gnome-text-editor /usr/bin/gedit

# Set gnome-console to launch with Ctrl+Alt+T
# Source 1: https://askubuntu.com/questions/597395/
# Source 2: https://gitlab.com/tukusejssirs/lnx_scripts/-/blob/master/bash/functions/gshort.sh
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'kgx'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Primary><Alt>t'

# Installing customisations
if [ "$customisation_choice" = 'yes' ]; then
  echo "Starting the installation.."
  cd ..; git clone -b de https://github.com/shreyas-a-s/debian-customisation.git && cd debian-customisation/ && ./install.sh
fi
