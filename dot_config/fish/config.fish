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

# bobthefish prompt (powerline, gruvbox)
set -g theme_color_scheme gruvbox
set -g theme_nerd_fonts yes
set -g theme_powerline_fonts yes
set -g theme_display_git yes
set -g theme_display_git_dirty yes
