use std log

def --env addConfigs []: nothing -> nothing {


# $env.COLORTERM = 'truecolor'
#     $env.
}

def --env addToPath [path: string]: nothing -> nothing {
    if ($path | path exists) and ($path not-in $env.PATH) {
        log info $"login path ($path) added"
        $env.PATH = ($env.PATH | split row (char esep) | prepend $path)
    }
}

def --env addPaths []: nothing -> nothing {
    addToPath ([$nu.home-path .local bin] | path join)

    addToPath ([$nu.home-path 'bin'] | path join)

    addToPath (['/usr' 'local' 'sbin'] | path join)

    addToPath (['/usr' 'local' 'bin'] | path join)

    addToPath (['/usr' 'sbin'] | path join)

    addToPath (['/usr' 'bin'] | path join)

    addToPath '/sbin'

    addToPath '/bin'

    addToPath (['/usr' 'games'] | path join)

    addToPath (['/usr' 'local' 'games'] | path join)

    # addToPath ([])


}

# addPaths
