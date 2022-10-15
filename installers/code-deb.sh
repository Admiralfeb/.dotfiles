#!/usr/bin/env bash

echo "Info: Installing VS Code"

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg

$sourcesFileText = $(cat << EOF
X-Repolib-Name: VSCode
Enabled: yes
Types: deb
URIs: http://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: amd64,arm64,armhf
Signed-by: /etc/apt/keyrings/packages.microsoft.gpg
EOF
)

sudo tee /etc/apt/sources.list.d/vscode.sources

sudo apt update
sudo apt install code
sudo apt install code-insiders

rm -f packages.microsoft.gpg

echo "Info: Finish Installing VS Code"
