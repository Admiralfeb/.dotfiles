#!/usr/bin/env bash

nu_path=$HOME/.config/nushell

echo "Processing nushell directory"
[[ -d $nu_path ]] && mv $nu_path $nu_path.bak
ln -s $HOME/.dotfiles/nushell $HOME/.config
