# config.nu
# See https://www.nushell.sh/book/configuration.html
# This file is loaded after env.nu and before login.nu
# See: `help config nu`

$env.config.show_banner = false

$env.config.edit_mode = 'vi'
$env.EDITOR = 'nvim'

$env.config.rm.always_trash = true
$env.config.filesize.metric = true

$env.config.completions.algorithm = "fuzzy"

$env.config.history.file_format = "sqlite"
$env.config.history.isolation = true

source ~/.cache/carapace/init.nu

$env.path ++= [("~/bin" | path expand)]

####################################################################################################
# ALIASES
####################################################################################################

alias g = git
# nu function that takes all args
def --wrapped nvim5 [...args] {
  $env.NVIM_APPNAME = "astronvim_v5"
  nvim ...$args
}

####################################################################################################
# Always at end
####################################################################################################
# starship
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
# zoxide
source ~/.zoxide.nu

# https://starship.rs/presets/gruvbox-rainbow
# starship preset gruvbox-rainbow -o ~/.config/starship.toml

# https://starship.rs/presets/nerd-font
# starship preset nerd-font-symbols -o ~/.config/starship.toml
