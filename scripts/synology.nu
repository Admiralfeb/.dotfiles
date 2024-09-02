#!/usr/bin/env nu

# Replaces the folders in the home directory with symlinks to the synology drive directory.

let folders = ['Desktop' 'Documents' 'Downloads' 'Pictures' 'Templates' 'Videos']

$folders | each { |it|}
