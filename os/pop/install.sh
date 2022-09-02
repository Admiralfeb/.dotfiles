#!/usr/bin/env bash

chmod +x ../../scripts/bashstrap.sh
../../scripts/bashstrap.sh

chmod +x config-sources.sh

sudo apt update
sudo apt install software-properties-common curl wget

. config-sources.sh

sudo apt update

# iterate through packages and installs them if not already installed
for package_name in ${PACKAGE_LIST[@]}; do
	if ! sudo apt list --installed | grep -q "^\<$package_name\>"; then
		echo "installing $package_name..."
		sleep .5
		sudo apt install "$package_name" -y
		echo "$package_name installed"
	else
		echo "$package_name already installed"
	fi
done

sudo apt install flatpak -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

for flatpak_name in ${FLATPAK_LIST[@]}; do
	if ! flatpak list | grep -q $flatpak_name; then
		flatpak install "$flatpak_name" -y
	else
		echo "$flatpak_name already installed"
	fi
done

for snap_name in ${SNAP_CLASSIC_LIST[@]}; do
    if ! snap list | grep -q $snap_name; then
        sudo snap install "$snap_name" --classic
    else
        echo "$snap_name already installed"

source ../../installers/gitkraken.sh
source ../../installers/golang.sh
source ../../installers/nvm.sh
source ../../installers/rust.sh
