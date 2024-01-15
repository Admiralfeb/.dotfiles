#!/usr/bin/env nu

let dotfiles_path = ([$env.HOME '.dotfiles' 'nushell'] | path join)
echo $dotfiles_path
let os_config_path = ($nu.default-config-dir | path dirname)
echo $os_config_path

echo "Processing nushell directory"
if ($nu.default-config-dir | path exists) {
    mv --interactive $nu.default-config-dir ([$nu.default-config-dir ".bak"] | str join)
    ln -s $dotfiles_path $os_config_path
}
