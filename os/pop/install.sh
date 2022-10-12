#!/usr/bin/env bash

echo "info: Strapping bash"

source ../../scripts/bashstrap.sh

echo "info: configuring sources"

sudo apt-get update -qq
sudo apt-get install -qq software-properties-common curl wget gpg -y
sudo apt-get install -qq nala -y

source config-sources.sh

echo "info: update after sources copy"
sudo nala update -qq

echo "info: add apt packages"

echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections

# iterate through packages and installs them if not already installed
for package_name in ${PACKAGE_LIST[@]}; do
	if ! sudo nala list --installed | grep -q "^\<$package_name\>"; then
		echo "installing $package_name..."
		sleep .5
		if sudo nala install -qq "$package_name" | grep -iqF "Unable to locate"; then
			echo "package $package_name not found. aborting"
			exit 1
		fi
		echo "$package_name installed"
	else
		echo "$package_name already installed"
	fi
done

echo "info: add flatpak packages"

sudo nala install -qq flatpak -y
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
	fi
done

echo "info: add other packages"

source ../../installers/gitkraken.sh
source ../../installers/golang.sh
source ../../installers/nvm.sh
source ../../installers/rust.sh
