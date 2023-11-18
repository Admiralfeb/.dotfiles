#!/usr/bin/env nu

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

# Rust
let cargoPath = ([$env.HOME '.cargo' 'bin'] | path join)
if ($cargoPath | path exists) {
    $env.PATH = ($env.PATH | split row (char esep) | append $cargoPath)
}

# fnm - fast node manager
# let fnm = ([$env.HOME '.local' 'share' 'fnm'] | path join)
# if ($fnm | path exists) {
#     $env.PATH = ($env.PATH | split row (char esep) | append $fnm)
#     load-fnm
# }
# let fnm2 = ([$env.HOME '.cargo' 'bin' 'fnm'] | path join)
# if ($fnm2 | path exists) {
#     $env.PATH = ($env.PATH | split row (char esep) | append $fnm2)
#     load-fnm
# }

# def-env load-fnm [] {
#     load-env (fnm env --shell bash | lines | str replace 'export ' '' | str replace -a '"' '' | split column = | rename name value | where name != "FNM_ARCH" and name != "PATH" | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value })
#     $env.PATH = ($env.PATH | split row (char esep) | append $"($env.FNM_MULTISHELL_PATH)/bin")
# }
