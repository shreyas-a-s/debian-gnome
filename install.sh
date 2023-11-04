#!/bin/bash

# ██████╗ ███████╗██████╗ ██╗ █████╗ ███╗   ██╗       ██████╗ ███╗   ██╗ ██████╗ ███╗   ███╗███████╗
# ██╔══██╗██╔════╝██╔══██╗██║██╔══██╗████╗  ██║      ██╔════╝ ████╗  ██║██╔═══██╗████╗ ████║██╔════╝
# ██║  ██║█████╗  ██████╔╝██║███████║██╔██╗ ██║█████╗██║  ███╗██╔██╗ ██║██║   ██║██╔████╔██║█████╗
# ██║  ██║██╔══╝  ██╔══██╗██║██╔══██║██║╚██╗██║╚════╝██║   ██║██║╚██╗██║██║   ██║██║╚██╔╝██║██╔══╝
# ██████╔╝███████╗██████╔╝██║██║  ██║██║ ╚████║      ╚██████╔╝██║ ╚████║╚██████╔╝██║ ╚═╝ ██║███████╗
# ╚═════╝ ╚══════╝╚═════╝ ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝       ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝

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
	echo "Which shell you prefer to customise?"
	echo "[1] Bash only"
	echo "[2] Fish only"
	echo "[3] Both but set Bash as Interactive Shell"
	echo "[4] Both but set Fish as Interactive Shell"
	echo "[5] None"
	read -r -p "Choose an option (1/2/3/4/5) : " shell_choice
	if ! [[ "$shell_choice" =~ ^[1-5]$ ]]; then
		echo -e "Invalid Choice..!!!\n"
		shellChoice
	fi
}

# Function to set custom GNOME keyboard shortcuts
# Source 1: https://askubuntu.com/questions/597395/
# Source 2: https://gitlab.com/tukusejssirs/lnx_scripts/-/blob/master/bash/functions/gshort.sh
function setCustomKeybind {
    local key="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/"
    local custom_keys=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)
    local new_key="$key$1/"
    custom_keys=${custom_keys::-1}", '$new_key']"
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$custom_keys"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$new_key name "$2"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$new_key command "$3"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$new_key binding "$4"
}

# Installation
customisationChoice
if [ "$customisation_choice" = 'yes' ]; then
  export customisation_choice
  qemuChoice && export qemu_choice
  shellChoice && export shell_choice
fi
sudo apt-get -y install gnome-core
sudo apt-get -y purge firefox-esr yelp gnome-terminal totem gnome-software gnome-characters gnome-contacts gnome-font-viewer gnome-logs && sudo apt-get -y install gnome-console gnome-tweaks gnome-text-editor && sudo apt-get -y autoremove

# Symlink gedit to gnome-text-editor
sudo ln -s /usr/bin/gnome-text-editor /usr/bin/gedit

# Set Custom Keyboard shortcuts
setCustomKeybind custom0 Terminal kgx '<Super>Return'
setCustomKeybind custom1 Brave 'brave-browser' '<Super>b'
setCustomKeybind custom2 LibreWolf librewolf '<Super>l'
setCustomKeybind custom3 'Github-Desktop' 'github-desktop' '<Super>g'
setCustomKeybind custom4 'Virt-Manager' 'virt-manager' '<Super>v'
setCustomKeybind custom4 'Disk Usage Analyzer' baobab '<Super>d'
setCustomKeybind custom4 Files nautilus '<Super>f'

# Set default keybinding to close application window
gsettings set org.gnome.desktop.wm.keybindings close '["<Super>q"]'

# Installing customisations
if [ "$customisation_choice" = 'yes' ]; then
  echo "Starting the installation.."
  cd ..; git clone -b de https://github.com/shreyas-a-s/debian-customisation.git && cd debian-customisation/ && ./install.sh
fi
