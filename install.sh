#!/bin/sh

# ██████╗ ███████╗██████╗ ██╗ █████╗ ███╗   ██╗       ██████╗ ███╗   ██╗ ██████╗ ███╗   ███╗███████╗
# ██╔══██╗██╔════╝██╔══██╗██║██╔══██╗████╗  ██║      ██╔════╝ ████╗  ██║██╔═══██╗████╗ ████║██╔════╝
# ██║  ██║█████╗  ██████╔╝██║███████║██╔██╗ ██║█████╗██║  ███╗██╔██╗ ██║██║   ██║██╔████╔██║█████╗
# ██║  ██║██╔══╝  ██╔══██╗██║██╔══██║██║╚██╗██║╚════╝██║   ██║██║╚██╗██║██║   ██║██║╚██╔╝██║██╔══╝
# ██████╔╝███████╗██████╔╝██║██║  ██║██║ ╚████║      ╚██████╔╝██║ ╚████║╚██████╔╝██║ ╚═╝ ██║███████╗
# ╚═════╝ ╚══════╝╚═════╝ ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝       ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝

# Installation
sudo apt-get -y install gnome-core
sudo apt-get -y purge firefox-esr yelp gnome-terminal totem gnome-software gnome-characters gnome-contacts gnome-font-viewer gnome-logs byobu epiphany-browser && sudo apt-get -y install gnome-console gnome-tweaks gnome-text-editor gnome-shell-extension-gsconnect && sudo apt-get -y autoremove

# Symlink gedit to gnome-text-editor
sudo ln -s /usr/bin/gnome-text-editor /usr/bin/gedit

# Enable GSConnect
gnome-extensions enable gsconnect@andyholmes.github.io
