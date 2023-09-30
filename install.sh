#!/bin/bash

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
sudo apt-get -qq install gnome-core
sudo apt-get -qq purge firefox-esr yelp gnome-terminal totem && sudo apt-get -qq install gnome-console gnome-tweaks && sudo apt-get -qq autoremove

# Installing customisationsRemove redundent -y
if [ "$customisation_choice" = 'yes' ]; then
  echo "Starting the installation.."
  cd ..; git clone -b de https://github.com/shreyas-a-s/debian-customisation.git && cd debian-customisation/ && ./install.sh
fi
