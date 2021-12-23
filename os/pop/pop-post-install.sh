#!/usr/bin/env bash

# This script is meant to configure the sources and install the applications used.

# elevate to sudo
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

KEYRING_LOCATION=/usr/share/keyrings

SOURCES_KEY_COMMANDS=(
    wget -O- https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg | sudo tee "$KEYRING_LOCATION/brave-browser-archive-keyring.gpg"
    wget -O- https://dl.google.com/linux/linux_signing_key.pub | sudo tee "$KEYRING_LOCATION/google-archive-keyring.pub"
    sudo gpg --no-default-keyring --keyring "$KEYRING_LOCATION/insync-archive-keyring.gpg" --keyserver <hkp://keyserver.ubuntu.com:80> --recv-keys ACCAF35C
    wget -O- https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xaeeb94e9c5a3b54ecfa4a66aa684470caccaf35c | sudo tee "$KEYRING_LOCATION/insync-archive-keyring.gpg"
    wget -O- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee "$KEYRING_LOCATION/microsoft-archive-keyring.gpg"
    wget -O- https://www.mongodb.org/static/pgp/server-5.0.asc | sudo tee "$KEYRING_LOCATION/mongodb-5.0-archive-keyring.asc"
    # scootersoftware - cannot locate their key
    wget -O- https://slack.com/gpg/slack_pubkey_20210901.gpg | sudo tee "$KEYRING_LOCATION/slack-archive-keyring.gpg"
)

SOURCES_NAMES=(
    brave-browser-release
    google-chrome
    insync
    microsoft-edge
    microsoft-prod
    mongodb-5.0
    scootersoftware
    slack
    vscode
)

SOURCES_LIST=(
    deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main
    deb [signed-by=/usr/share/keyrings/google-archive-keyring.pub arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main
    deb [signed-by=/usr/share/keyrings/insync-archive-keyring.gpg] http://apt.insync.io/ubuntu xenial non-free contrib
    deb [signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg arch=amd64] https://packages.microsoft.com/repos/edge/ stable main
    deb [signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg arch=amd64,arm64,armhf] https://packages.microsoft.com/ubuntu/21.04/prod hirsute main
    deb [signed-by=/usr/share/keyrings/mongodb-5.0-archive-keyring.asc arch=amd64,arm64] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse
    deb https://www.scootersoftware.com/ bcompare4 non-free
    deb [signed-by=/usr/share/keyrings/slack-archive-keyring.gpg] https://packagecloud.io/slacktechnologies/slack/debian/ jessie main
    deb [signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg arch=amd64,arm64,armhf] http://packages.microsoft.com/repos/code stable main
)

PACKAGE_LIST=(
    apt
    bcompare
    brave-browser
    code
    code-insiders
    com.github.tkashkin.gamehub
    curl
    discord
    dotnet-sdk-6.0
    fontforge
    fonts-firacode
    gnome-boxes
    gnome-tweaks
    gnome-shell-extension-pop-shell
    gpaint
    insync
    lutris
    meld
    microsoft-edge-stable
    mongodb-org
    neofetch
    packages-microsoft-prod
    python3
    python3-pip
    realvnc-vnc-server
    slack-desktop
    snapd
    steam
    timeshift
    tree
    ttf-mscorefonts-installer
    virt-manager
    vlc
    wine
    winetricks
    youtube-dl
)

FLATPACK_LIST=(
    com.google.AndroidStudio
    com.mattermost.Desktop
    com.obsproject.Studio
    md.obsidian.Obsidian
    org.gimp.GIMP
    org.gimp.GIMP.Manual
    org.gnome.clocks
    org.gnucash.GnuCash
    org.seul.pingus
    re.sonny.Tangram
)

SNAP_CLASSIC_LIST=(
    flutter
)

# prep to add custom sources
sudo apt update
sudo apt install software-properties-common curl wget

# add custom source keys
for i in ${SOURCES_KEY_COMMANDS[@]}; do
    $i
done

# add custom sources
for i in ${!SOURCES_NAMES[@]}; do
    echo $SOURCES_LIST[$i] | sudo tee "/etc/apt/sources.list.d/$SOURCES_NAMES[$i]"
done

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

# setup flatpak
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

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
