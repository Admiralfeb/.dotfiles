#!/usr/bin/env bash

function parse_git_branch {
	git branch 2> /dev/null | grep "^*" | colrm 1 2
}
