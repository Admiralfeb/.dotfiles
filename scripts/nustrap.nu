#!/usr/bin/env nu


if ($nu.os-info.name != 'windows') {
    let dotfiles_path = ([$env.HOME '.dotfiles' 'nushell'] | path join)
    echo $dotfiles_path
    let os_config_path = ($nu.default-config-dir | path dirname)
    echo $os_config_path

    echo "Processing nushell directory - Linux/mac"
    if ($nu.default-config-dir | path exists) {
        mv --interactive $nu.default-config-dir ([$nu.default-config-dir ".bak"] | str join)
        ln -s $dotfiles_path $os_config_path
    }
} else {
    let dotfiles_path = ([$env.HOMEPATH '.dotfiles' 'nushell'] | path join)
    echo $dotfiles_path
    let os_config_path = $env.APPDATA
    echo $os_config_path
    let default_config_dir = ([$env.APPDATA 'nushell'] | path join)

    echo "Processing nushell directory - Windows"
    if ($default_config_dir | path exists) {
        mv --interactive $default_config_dir ([$default_config_dir '.bak'] | str join)
        mklink /J $default_config_dir $dotfiles_path
    }
}
