# Nushell Environment Config File

def create_left_prompt [] {
    let path_segment = ($env.PWD | str replace '/home/admiralfeb' '~')
    let user = ($env.USER)
    let computerName = (hostname | str trim)

    $"($user)@($computerName):($path_segment)"
}

def create_right_prompt [] {
    let time_segment = ([
        (date now | format date '%Y-%m-%d %R')
    ] | str join)

    $time_segment
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = { create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = { " 〉" }
$env.PROMPT_INDICATOR_VI_INSERT = { ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = { "〉" }
$env.PROMPT_MULTILINE_INDICATOR = { "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
$env.NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

source /home/admiralfeb/.config/nushell/path.nu

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | prepend '/some/path')


# $env.PATH = '/home/admiralfeb/.cargo/bin:/home/admiralfeb/.nvm/versions/node/v16.13.0/bin:/home/admiralfeb/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin:/home/admiralfeb/.dotnet/tools:/usr/local/go/bin'
# $env.PATH = ($env.PATH | prepend "/home/admiralfeb/.fnm")
# $env.PATH = ($env.PATH | prepend "/home/admiralfeb/go/bin")
