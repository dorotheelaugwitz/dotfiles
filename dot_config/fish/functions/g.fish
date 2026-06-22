# ~/.config/fish/functions/g.fish
#
# Translated from the old zsh `functions/g`.
# fish auto-loads functions from functions/ on first use.
#
#   * No arguments -> `git status`
#   * With arguments -> behaves like `git`
#
# `--wraps git` gives `g` the same tab-completions as `git`
# (the fish equivalent of zsh's `compdef g=git`).

function g --wraps git --description 'git status with no args, otherwise git <args>'
    if test (count $argv) -gt 0
        git $argv
    else
        git status
    end
end
