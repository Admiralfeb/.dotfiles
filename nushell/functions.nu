#!/usr/bin/env nu

export def isMac [] {
  $nu.os-info.name == 'macos'
}

export def nala-update [] {
  ^sudo nala update
  ^nala list --upgradable
}

export def nala-upgrade [--yes (-y)] {
  if $yes {
    ^sudo nala upgrade -y
  } else {
    ^sudo nala upgrade
  }
}

export def dotfiles [] {
  code ~/.dotfiles
}

def hosts-location [] {
  if (isWindows) {
    "c:/Windows/System32/Drivers/etc/hosts"
  } else {
    "/etc/hosts"
  }
}

export def open-hosts [] {
  if (isWindows) {
    powershell Start-Process -FilePath vim -ArgumentList (hosts-location) -PassThru -Verb RunAs
  } else {
    ^sudo vim (hosts-location)
  }
}

export def view-hosts [] {
  open (hosts-location)
}

# Windows Specific
export def isWindows [] {
  $nu.os-info.name == 'windows'
}

export def setUserVar [name: string, value: string] {
  if(isWindows){
    powershell $"[Environment]::SetEnvironmentVariable\('($name)', '($value)', 'User'\)"
  }
}

def lsg [] { ls | sort-by name -i | grid -c }
def lss [...commands: string] { ls ($commands | str join ' ') | sort-by name -i }
