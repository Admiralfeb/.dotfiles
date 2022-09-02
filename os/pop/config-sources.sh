#!/usr/bin/env bash

source ../../extras/functions.sh

# This script is meant to configure the sources used.

KEYRING_LOCATION=/usr/share/keyrings

wget -O- https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg | sudo tee "$KEYRING_LOCATION/brave-browser-archive-keyring.gpg"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o "$KEYRING_LOCATION/docker-archive-keyring.gpg"
wget -O- https://dl.google.com/linux/linux_signing_key.pub | sudo tee "$KEYRING_LOCATION/google-archive-keyring.pub"
sudo gpg --no-default-keyring --keyring "$KEYRING_LOCATION/insync-archive-keyring.gpg" --keyserver <hkp://keyserver.ubuntu.com:80> --recv-keys ACCAF35C
wget -O- https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xaeeb94e9c5a3b54ecfa4a66aa684470caccaf35c | sudo tee "$KEYRING_LOCATION/insync-archive-keyring.gpg"
wget -O- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee "$KEYRING_LOCATION/microsoft-archive-keyring.gpg"
wget -O- https://www.mongodb.org/static/pgp/server-5.0.asc | sudo tee "$KEYRING_LOCATION/mongodb-5.0-archive-keyring.asc"
# scootersoftware - cannot locate their key
wget -O- https://slack.com/gpg/slack_pubkey_20210901.gpg | sudo tee "$KEYRING_LOCATION/slack-archive-keyring.gpg"


sudo cp -r ../../package-managers/apt/sources.list.d /etc/apt/sources.list.d


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
)

SNAP_CLASSIC_LIST=(
    flutter
)
