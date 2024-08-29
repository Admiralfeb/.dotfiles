#!/usr/bin/env nu

use std log

def --env addToPath [path: string]: nothing -> nothing {
  if ($path | path exists) == false {
    log info $"($path) does not exist. Not adding."
    return
  }

  if (isWindows) {
    if ($path not-in $env.Path) {
      log info $"($path) path being added for Windows"
      $env.Path = ($env.Path | split row (char esep) | append $path)
    }
  } else if ($path not-in $env.PATH) {
    log info $"($path) path being added for mac/linux"
    $env.PATH = ($env.PATH | split row (char esep) | append $path)
  }
}

def --env prependToPath [path: string]: nothing -> nothing {
  if ($path | path exists) == false {
    log info $"($path) does not exist. Not adding."
    return
  }

  if (isWindows) {
    if ($path not-in $env.Path) {
      log info $"($path) path being added for Windows"
      $env.Path = ($env.Path | split row (char esep) | prepend $path)
    }
  } else if ($path not-in $env.PATH) {
    log info $"($path) path being added for mac/linux"
    $env.PATH = ($env.PATH | split row (char esep) | prepend $path)
  }
}

export def --env addLinuxPaths []: nothing -> nothing {
  addUnixPaths
  addCommonPaths
  addDotnet

  # golang
  addToPath (['/usr' 'local' 'go' 'bin'] | path join)

  # jetbrains
  addToPath ([$nu.home-path '.local' 'share' 'JetBrains' 'Toolbox' 'scripts'] | path join)

  # Fly.io
  addToPath ([$nu.home-path '.fly' 'bin'] | path join)
}

export def --env addMacPaths []: nothing -> nothing {
  addUnixPaths
  addCommonPaths

  # Jetbrains
  addToPath ([$nu.home-path 'Library' 'Application Support' 'JetBrains' 'Toolbox' 'scripts'] | path join)

  # VS Code for Mac
  addToPath (['/Applications' 'Visual Studio Code.app' 'Contents' 'Resources' 'app' 'bin'] | path join)

  # homebrew
  addToPath (['/opt' 'homebrew' 'bin'] | path join)
}

export def --env addWindowsPaths []: nothing -> nothing {
  addCommonPaths
  # load-env (fnm env --shell power-shell | lines | str replace '$env:' '' | str replace -a '"' '' | where ($it | str contains '=') | split column = | rename name value | where name != "FNM_ARCH" and name != "PATH" | reduce -f {} {|it, acc| $acc | upsert ($it.name | str trim) ($it.value | str trim) })
  # $env.Path = ($env.Path | append ([$env.FNM_MULTISHELL_PATH 'bin'] | path join))


  # addToPath ([$env.FNM_DIR 'node-versions' 'v20.11.0' 'installation'] | path join)
}

# def --env replaceFnmMultishell

def --env addUnixPaths []: nothing -> nothing {
  # Users private bins
  addToPath ([$nu.home-path 'bin'] | path join)

  addToPath ([$nu.home-path '.local' 'bin'] | path join)
}

def --env addCommonPaths []: nothing -> nothing {
  addToPath ([$nu.home-path '.dotnet' 'tools'] | path join)

  let cargoPath = ([$nu.home-path '.cargo' 'bin'] | path join)
  prependToPath $cargoPath

  addFnm $cargoPath
}

def --env addFnm [cargoPath:string]: nothing -> nothing {
  if (isWindows) {
    if (([$cargoPath 'fnm'] | path join | path exists) or
      ([$cargoPath 'fnm.exe'] | path join | path exists)) {
      load-env (fnm env --shell bash | lines | str replace 'export ' '' | str replace -a '"' '' | split column "=" | rename name value | where name != "FNM_ARCH" and name != "PATH" | where ($it.name | str starts-with FNM) | reduce -f {} {|it, acc| $acc | upsert $it.name ($it.value | str replace --all '\\' '\') })
      addToPath ([$env.FNM_MULTISHELL_PATH] | path join)
    }
  } else {
    if (([$cargoPath 'fnm'] | path join | path exists) or
     ([$cargoPath 'fnm.exe'] | path join | path exists)) {
      load-env (fnm env --shell bash | lines | str replace 'export ' '' | str replace -a '"' '' | split column "=" | rename name value | where name != "FNM_ARCH" and name != "PATH" | where ($it.name | str starts-with FNM) | reduce -f {} {|it, acc| $acc | upsert $it.name ($it.value | str replace --all '\\' '\') })
      addToPath ([$env.FNM_MULTISHELL_PATH bin] | path join)
    }
  }
}

def --env addDotnet []: nothing -> nothing {
  let dotnet_root = ([$nu.home-path '.dotnet'] | path join)
  $env.DOTNET_ROOT = $dotnet_root

  addToPath ($dotnet_root)
  addToPath ([$dotnet_root "tools"] | path join)
}
