#!/usr/bin/env nu

let dotfiles_path = ([$nu.home-path '.dotfiles' 'git-configs'] | path join)
let files = [.gitconfig .gitignore]

for x in $files {
    let x_path = ([$nu.home-path $x] | path join)
    echo (["Processing" $x_path] | str join ' ')
    if ($x_path | path exists) {
        mv --interactive $x_path ([$x_path ".bak"] | str join)
    }
    ln -s ([$dotfiles_path $x] | path join) $x_path
}
