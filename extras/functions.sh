#!/usr/bin/env bash

elevate_to_sudo() {
    if [ $EUID != 0 ]; then
        sudo "$0" "$@"
        exit $?
    fi
}
