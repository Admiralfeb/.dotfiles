# Installs Ansible for managing other devices
export def InstallAnsible []: nothing -> nothing {
    pip3 install ansible
}

# Installs GitKraken on Linux
export def InstallGitKraken []: nothing -> nothing {
    if isWindows == false and isMac == false {
        let linux_path = '~/Downloads/gitkraken.deb'
        wget -O $linux_path https://release.gitkraken.com/linux/gitkraken-amd64.deb
        sudo dpkg -i $linux_path

        rm $linux_path
    } else {
        echo "Machine is Mac or Windows and this will not install"
    }
}

# Installs or updates nushell
export def InstallNushell []: nothing -> nothing {
    cargo install nu
}

# Installs starship for nushell.
# Configs are already set and the shell just needs to be reloaded.
export def InstallStarship []: nothing -> nothing {
    cargo install starship --locked
}

export def InstallTailscale []: nothing -> nothing {
    if (isWindows) == false and (isMac) == false {
        curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg | sudo tee /etc/apt/keyrings/tailscale.gpg
        sudo cp ~/.dotfiles/package-managers/apt/sources.list.d/tailscale.sources /etc/apt/sources.list.d/
        nala-update
        sudo nala install tailscale
    } else {
        echo "Machine is Mac or Windows and this will not install"
    }
}
