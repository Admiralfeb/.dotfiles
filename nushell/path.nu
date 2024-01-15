#!/usr/bin/env nu

export def addLinuxPaths []: nothing -> nothing {

  # Users private bins
  let homeBin = ([$env.HOME 'bin'] | path join)
  if ($homeBin | path exists) {
    $env.PATH = ($env.PATH | split row (char esep) | append $homeBin)
  }

  let localBin = ([$env.HOME '.local' 'bin'] | path join)
  if ($localBin | path exists) {
    $env.PATH = ($env.PATH | split row (char esep) | append $localBin)
  }

  # golang
  let golang = 'usr/local/go/bin'
  if ($golang | path exists) {
    $env.PATH = ($env.PATH | split row (char esep) | append $golang)
  }

  # jetbrains
  let jetbrainsToolbox = ([$env.HOME '.local' 'share' 'JetBrains' 'Toolbox' 'scripts'] | path join)
  if ($jetbrainsToolbox | path exists) {
    $env.PATH = ($env.PATH | split row (char esep) | append $jetbrainsToolbox)
  }

  # Fly.io
  let flyIo = ([$env.HOME '.fly' 'bin'] | path join)
  if ($flyIo | path exists) {
    $env.PATH = ($env.PATH | split row (char esep) | append $flyIo)
  }

  addCommonPaths
}

export def addMacPaths []: nothing -> nothing {
  # jetbrains
  let jetbrainsToolbox = ([$env.HOME 'Library' 'Application Support' 'JetBrains' 'Toolbox' 'scripts'] | path join)
  if ($jetbrainsToolbox | path exists) {
    $env.PATH = ($env.PATH | split row (char esep) | append $jetbrainsToolbox)
  }

  addCommonPaths
}

export def addWindowsPaths []: nothing -> nothing {
  # nothing here yet
}

def addCommonPaths []: nothing -> nothing {
  # fnm
  let fnm_path = ([$env.HOME '.fnm'] | path join)
  if ($fnm_path | path exists) {
    $env.PATH = ($env.PATH | split row (char esep) | append $fnm_path)
    load-env (fnm env --use-on-cd --version-file-strategy=recursive --shell bash | lines | str replace 'export ' '' | str replace -a '"' '' | split column = | rename name value | where name != "FNM_ARCH" and name != "PATH" | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value })
    $env.PATH = ($env.PATH | prepend $"($env.FNM_MULTISHELL_PATH)/bin")
  }

  # Rust
  let cargoPath = ([$env.HOME '.cargo' 'bin'] | path join)
  if ($cargoPath | path exists) {
    $env.PATH = ($env.PATH | split row (char esep) | append $cargoPath)
  }
}
