#!/usr/bin/env bash

FILES_TO_REPLACE=(
    .profile
    .bashrc
    .bash_aliases
)

for file_to_replace in ${FILES_TO_REPLACE[@]}; do
    [[ -f $HOME/$file_to_replace ]] && mv $HOME/$file_to_replace $HOME/$file_to_replace.backup
    ln -s $HOME/.dotfiles/$file_to_replace $HOME/$file_to_replace
done
