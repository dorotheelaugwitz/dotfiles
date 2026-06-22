# ~/.config/fish/config.fish

# Homebrew (Apple Silicon): put /opt/homebrew/bin on PATH.
if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv | source
end

set -gx LANG en_US.UTF-8
set -gx EDITOR micro
set -gx VISUAL micro
set -gx PKG_CONFIG_PATH /opt/homebrew/lib/pkgconfig

# Activate mise-managed runtimes.
if type -q mise
    mise activate fish | source
end

fish_add_path $HOME/.local/bin

# fzf key bindings (Ctrl-R history, Ctrl-T files, Alt-C cd)
if type -q fzf
    fzf --fish | source
end
