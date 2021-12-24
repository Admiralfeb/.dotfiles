#!/usr/bin/env bash

wget -O ~/Downloads/gitkraken.deb https://release.gitkraken.com/linux/gitkraken-amd64.deb
sudo dpkg -i ~/Downloads/gitkraken.deb

rm ~/Downloads/gitkraken.deb
