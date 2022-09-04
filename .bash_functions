#!/usr/bin/env bash

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

get_current_git_branch() {
	if [ -n $(parse_git_branch) ]; then
		local retval=' ($(parse_git_branch))'
		echo "$retval"
	else
		local retval=''
		echo "$retval"
	fi
}

get_installed_apps() {
	echo "get installed apps"
}

get_apt_packages() {
    apt list --installed
}

get_flatpak_packages() {
    flatpak list
}

get_snap_packages() {
    snap list
}
