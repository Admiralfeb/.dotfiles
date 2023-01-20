# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# golang
if [ -d "/usr/local/go/bin" ] ; then
    PATH="$PATH:/usr/local/go/bin"
fi

if [ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ] ; then
    Path="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"
fi

if [[ $OSTYPE == 'darwin'* ]] && [ -d "/opt/homebrew/bin/go" ] ; then
    PATH="$PATH:/opt/homebrew/bin/go"
fi

if [[ $OSTYPE == 'darwin'* ]] ; then
    # Setting PATH for Python 3.9
    PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:${PATH}"
    export PATH
    eval "$(/opt/homebrew/bin/brew shellenv)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
