#!/usr/bin/env bash

# This script adds all the appropriate config files from the repo.

# git config files
GIT_FILES_TO_REPLACE=(
    .gitconfig
    .gitignore
)

for file_to_replace in ${GIT_FILES_TO_REPLACE[@]}; do
    echo "Processing $file_to_replace"
    [[ -f $HOME/$file_to_replace ]] && mv $HOME/$file_to_replace $HOME/$file_to_replace.bak
    ln -s $HOME/.dotfiles/$file_to_replace $HOME/$file_to_replace
done

# user config files
USER_FILES_TO_REPLACE=(
    .profile
    .bashrc
    .bash_aliases
    .bash_functions
)

for file_to_replace in ${USER_FILES_TO_REPLACE[@]}; do
    echo "Processing $file_to_replace"
    [[ -f $HOME/$file_to_replace ]] && mv $HOME/$file_to_replace $HOME/$file_to_replace.bak
    ln -s $HOME/.dotfiles/$file_to_replace $HOME/$file_to_replace
done
