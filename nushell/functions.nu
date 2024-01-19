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

# Windows Specific
export def isWindows [] {
  $nu.os-info.name == 'windows'
}

export def setUserVar [name: string, value: string] {
  if(isWindows){
    powershell $"[Environment]::SetEnvironmentVariable\('($name)', '($value)', 'User'\)"
  }
}
