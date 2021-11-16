#!/bin/bash

echo "Which version of golang do you wish to install?"

read golang_version

sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go$golang_version.linux-amd64.tar.gz
