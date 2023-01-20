#!/usr/bin/env bash

NU_FILES_TO_REPLACE=(
    config.nu
    env.nu
    login.nu
)

nu_path=$HOME/.config/nushell

mkdir -p $nu_path

for file_to_replace in ${NU_FILES_TO_REPLACE[@]}; do
    echo "Processing $file_to_replace"
    [[ -f $nu_path/$file_to_replace ]] && mv $nu_path/$file_to_replace $nu_path/$file_to_replace.bak
    ln -s $HOME/.dotfiles/nu/$file_to_replace $nu_path/$file_to_replace
done
