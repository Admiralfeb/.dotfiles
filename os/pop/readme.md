# Pop!_OS Installation

This will install all packages held in the popOS configs in this directory.

Note that this will ask for the sudo password at least once.

## Execute

To execute full setup, run install.sh from this directory

## Process

1. Copy bash configs to user
2. Load sources for apt, including their trusted key
3. Load flatpak sources
4. Enable snapd
5. Install apt packages
6. Install flatpack packages
7. Install any snap packages
8. Install separate applications not contained in the package manager, but have a direct download link
