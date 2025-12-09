# config.nu
# See https://www.nushell.sh/book/configuration.html
# This file is loaded after env.nu and before login.nu
# See: `help config nu`

$env.config.show_banner = false

$env.config.edit_mode = 'vi'
$env.EDITOR = 'nvim'

$env.config.rm.always_trash = true
#$env.config.filesize.metric = true

$env.config.completions.algorithm = "fuzzy"

$env.config.history.file_format = "sqlite"
$env.config.history.isolation = true

$env.config.keybindings ++= [{
    name: completion_menu
    modifier: control
    keycode: space
    mode: vi_insert
    event: {
        send: HistoryHintWordComplete
    }
}]
$env.config.keybindings ++= [{
    name: completion_menu
    modifier: control_shift
    keycode: space
    mode: vi_insert
    event: {
        send: HistoryHintComplete
    }
}]

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

alias gnp = git --no-pager
alias ga = git add
alias gst = git status
alias gs = git status --short --branch
alias gfp = git fetch --prune
alias gcp = git cherry-pick
alias gcpc = git cherry-pick --continue
alias gcpa = git cherry-pick --abort
alias gco = git checkout
alias gd = git diff
alias gdca = git diff --cached
alias gupa = git pull --rebase --autostash
alias gbr = git branch
alias grbi = git rebase -i
alias grbs = git rebase --skip
alias grba = git rebase --abort
alias grbc = git rebase --continue


####################################################################################################
# LF change directory on exit
####################################################################################################
def --env lf [...args] {
    let temp_file = (mktemp path.XXXX)
    ^lf.exe --last-dir-path $temp_file ...$args
    if ($temp_file | path exists) {
        let last_dir = (open $temp_file | str trim)
        rm $temp_file
        if not ($last_dir | is-empty) and ($last_dir | path type) == "dir" {
            cd $last_dir
        }
    }
}


####################################################################################################
# Always at end
####################################################################################################
# starship
# mkdir ($nu.data-dir | path join "vendor/autoload")
# starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
# zoxide
source ~/.zoxide.nu

# https://starship.rs/presets/gruvbox-rainbow
# starship preset gruvbox-rainbow -o ~/.config/starship.toml

# https://starship.rs/presets/nerd-font
# starship preset nerd-font-symbols -o ~/.config/starship.toml
