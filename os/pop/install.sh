#!/usr/bin/env bash

echo "info: Strapping bash"

chmod +x ../../scripts/bashstrap.sh
../../scripts/bashstrap.sh

echo "info: configuring sources"

chmod +x ./config-sources.sh

sudo apt update
sudo apt install software-properties-common curl wget

. ./config-sources.sh

sudo apt update

echo "info: add apt packages"

# iterate through packages and installs them if not already installed
for package_name in ${PACKAGE_LIST[@]}; do
	if ! sudo apt list --installed | grep -q "^\<$package_name\>"; then
		echo "installing $package_name..."
		sleep .5
		sudo apt -qq install "$package_name" -y
		echo "$package_name installed"
	else
		echo "$package_name already installed"
	fi
done

echo "info: add flatpak packages"

sudo apt install flatpak -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

for flatpak_name in ${FLATPAK_LIST[@]}; do
	if ! flatpak list | grep -q $flatpak_name; then
		flatpak install "$flatpak_name" -y
	else
		echo "$flatpak_name already installed"
	fi
done

echo "info: add snap packages"

for snap_name in ${SNAP_CLASSIC_LIST[@]}; do
    if ! snap list | grep -q $snap_name; then
        sudo snap install "$snap_name" --classic
    else
        echo "$snap_name already installed"
done

echo "info: add other packages"

source ../../installers/gitkraken.sh
source ../../installers/golang.sh
source ../../installers/nvm.sh
source ../../installers/rust.sh
