#!/usr/bin/env bash

PACKAGE_LIST=(
    apt
    bcompare
    brave-browser
    code
    code-insiders
    com.github.tkashkin.gamehub
    curl
    discord
    docker-ce
    docker-ce-cli
    containerd.io
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
    com.axiosoft.GitKraken
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
