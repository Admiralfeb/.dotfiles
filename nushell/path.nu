#!/usr/bin/env nu

export def --env addLinuxPaths []: nothing -> nothing {
  addCommonPaths

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
}

export def --env addMacPaths []: nothing -> nothing {
  addCommonPaths

  let jetbrainsToolbox = ([$env.HOME 'Library' 'Application Support' 'JetBrains' 'Toolbox' 'scripts'] | path join)
  if ($jetbrainsToolbox | path exists) {
    $env.PATH = ($env.PATH | split row (char esep) | append $jetbrainsToolbox)
  }

  let vscode = (['/Applications' 'Visual Studio Code.app' 'Contents' 'Resources' 'app' 'bin'] | path join)
  if ($vscode | path exists) {
    $env.PATH = ($env.PATH | split row (char esep) | append $vscode)
  }

  let homebrew = (['/opt' 'homebrew' 'bin'] | path join)
  if ($homebrew | path exists) {
    $env.PATH = ($env.PATH | split row (char esep) | append $homebrew)
  }
}

export def --env addWindowsPaths []: nothing -> nothing {
  # fnm
  # load-env (fnm env --version-file-strategy=recursive --shell bash | lines | str replace 'export ' '' | str replace -a '"' '' | where ($it | str contains '=') | split column = | rename name value | where name != "FNM_ARCH" and name != "PATH" | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value })
  # $env.Path = ($env.Path | split row (char esep) | append $"($env.FNM_MULTISHELL_PATH)/bin")
  # let fnm_path = ([$nu.home-path '.fnm'] | path join)
  # if ($fnm_path | path exists) {
  #   $env.Path = ($env.Path | split row (char esep) | append $fnm_path)
  # }

  $env.Path = ($env.Path | append ([$env.FNM_DIR 'node-versions' 'v20.11.0' 'installation'] | path join))

  # Rust
  let cargoPath = ([$nu.home-path '.cargo' 'bin'] | path join)
  if ($cargoPath | path exists) {
    $env.Path = ($env.Path | split row (char esep) | append $cargoPath)
  }
}

def --env addCommonPaths []: nothing -> nothing {
  # Users private bins
  let homeBin = ([$env.HOME 'bin'] | path join)
  if ($homeBin | path exists) {
    $env.PATH = ($env.PATH | split row (char esep) | append $homeBin)
  }

  let localBin = ([$env.HOME '.local' 'bin'] | path join)
  if ($localBin | path exists) {
    $env.PATH = ($env.PATH | split row (char esep) | append $localBin)
  }

  let cargoPath = ([$env.HOME '.cargo' 'bin'] | path join)
  if ($cargoPath | path exists) {
    $env.PATH = ($env.PATH | split row (char esep) | append $cargoPath)
  }

  # fnm
  if ([$cargoPath 'fnm'] | path join | path exists) {
    load-env (fnm env --use-on-cd --version-file-strategy=recursive --shell bash | lines | str replace 'export ' '' | str replace -a '"' '' | split column = | rename name value | where name != "FNM_ARCH" and name != "PATH" | where ($it.name | str starts-with FNM) | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value })
    $env.PATH = ($env.PATH | split row (char esep) | append $"($env.FNM_MULTISHELL_PATH)/bin")
  }
}
