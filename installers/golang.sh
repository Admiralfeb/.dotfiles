#!/bin/bash

current_version=$(go version)
golang_version=$(curl -s https://go.dev/VERSION?m=text)

echo "Current Version on system: $current_version"
echo "Online Version: $golang_version"

dl_url="https://go.dev/dl"

if [[ $OSTYPE == 'darwin'* ]]; then
    echo 'macOS'
    curl -L -o ~/Downloads/go-archive.tar.gz "$dl_url/$golang_version.darwin-amd64.tar.gz"
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf ~/Downloads/go-archive.tar.gz
else
    echo 'linux'
    curl -L -o ~/Downloads/go-archive.tar.gz "$dl_url/$golang_version.linux-amd64.tar.gz"
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf ~/Downloads/go-archive.tar.gz
fi

rm ~/Downloads/go-archive.tar.gz

echo "Verifying installation version"
echo $(go version)
