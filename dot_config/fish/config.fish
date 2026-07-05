# ~/.config/fish/config.fish

# Homebrew (Apple Silicon): put /opt/homebrew/bin on PATH.
if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv | source
end

set -gx LANG en_US.UTF-8
set -gx EDITOR micro
set -gx VISUAL micro
set -gx PKG_CONFIG_PATH /opt/homebrew/lib/pkgconfig
set -gx LESS "-R --mouse"   # mouse-wheel scrolling in pagers (git diff, man, ...)
set -gx HOMEBREW_NO_UPGRADE_QUIT_CASKS 1   # brew upgrade won't force-quit running apps

# Activate mise-managed runtimes.
if type -q mise
    mise activate fish | source
end

fish_add_path $HOME/.local/bin

# fzf: fuzzy finder (Ctrl-R history, Ctrl-T files, Alt-C cd), sourced from fd
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git'
set -gx FZF_DEFAULT_OPTS '--height 40% --layout reverse --border'
if type -q fzf
    fzf --fish | source
end

# zoxide: smart cd (use `z <dir>`)
if type -q zoxide
    zoxide init fish | source
end
