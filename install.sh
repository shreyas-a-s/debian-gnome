#!/bin/bash

# Functions
function choiceOfCustomisation {
   read -r -p "Continue to install debian-customisation? (yes/no): " choice
   case "$choice" in 
     "yes" ) echo "Starting the installation.."; cd ..; git clone -b de https://github.com/shreyas-a-s/debian-customisation.git && cd debian-customisation/ && ./install.sh;;
     "no" ) exit 1;;
     * ) echo "Invalid Choice! Keep in mind this is CASE-SENSITIVE."; choiceOfCustomisation;;
   esac
}

sudo apt install gnome-core -y
sudo apt purge firefox-esr yelp -y && sudo apt install gnome-console gnome-tweaks -y && sudo apt autoremove -y

# Install debian-customisation
choiceOfCustomisation