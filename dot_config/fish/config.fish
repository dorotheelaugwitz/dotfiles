# ~/.config/fish/config.fish  (managed by chezmoi)
#
# Tool versions (python, node, terraform, terragrunt, ...) are managed by
# mise. dbt Fusion is a standalone binary installed via Homebrew
# (`brew install dbt`), not via mise — it has BigQuery and other dialects
# built in and needs no adapter package.
#
# Aliases live in conf.d/aliases.fish (auto-loaded).
# The `g` git helper lives in functions/g.fish (auto-loaded).

# Homebrew (Apple Silicon): make sure /opt/homebrew/bin is on PATH so that
# brew-installed tools (fish, mise, dbt, ...) are found in login shells.
if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv | source
end

# You may need to manually set your language environment
set -gx LANG en_US.UTF-8

# Editors: micro for quick terminal edits (and git commit messages).
# Launch Zed explicitly with `zed` for GUI editing.
set -gx EDITOR micro
set -gx VISUAL micro

# Homebrew pkg-config
set -gx PKG_CONFIG_PATH /opt/homebrew/lib/pkgconfig

# mise: activates the managed runtimes/shims for this shell. This replaces
# the old nvm/bun/cargo PATH wrangling — add new tools with `mise use -g`.
if type -q mise
    mise activate fish | source
end

# dbt Fusion installs its binary here (and provides a `dbtf` alias itself).
fish_add_path $HOME/.local/bin
