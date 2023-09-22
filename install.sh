#!/bin/bash

# Customisation choice
function customisationChoice {
	read -r -p "Continue to install debian-customisation? (yes/no): " customisation_choice
	if [ "$customisation_choice" != 'yes' ] && [ "$customisation_choice" != 'no' ]; then
		echo -e "Invalid Choice! Keep in mind this is CASE-SENSITIVE.\n"
    	customisationChoice
  	fi
}

# Installation
customisationChoice && export customisation_choice
sudo apt install gnome-core -y
sudo apt purge firefox-esr yelp -y && sudo apt install gnome-console gnome-tweaks -y && sudo apt autoremove -y

# Installing customisations
if [ "$customisation_choice" = 'yes' ]; then
  echo "Starting the installation.."
  cd ..
  git clone -b de https://github.com/shreyas-a-s/debian-customisation.git && cd debian-customisation/ && ./install.sh
fi