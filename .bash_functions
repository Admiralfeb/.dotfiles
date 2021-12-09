#!/usr/bin/env bash

function parse_git_branch {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function get_current_git_branch {
	if [ -n $(parse_git_branch) ]; then
		local retval=' ($(parse_git_branch))'
		echo "$retval"
	else
		local retval=''
		echo "$retval"
	fi
}
