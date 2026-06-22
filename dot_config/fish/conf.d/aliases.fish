# ~/.config/fish/conf.d/aliases.fish
#
# Translated from the old zsh `aliases` file.
# fish auto-loads everything in conf.d/, so there's no need to `source` this.

alias ll='ls -al'
alias ls='ls -G'
alias ln='ln -v'
alias h='cd ~'
alias gf='git flow'

# Pretty print the PATH, one entry per line.
# In fish, $PATH is a list, so we print each element on its own line.
alias path='printf "%s\n" $PATH'

# Rails
alias be='bundle exec'
alias s='bundle exec rspec'
alias rc='bundle exec rails console'
alias rs='bundle exec rails server'

# Python
alias t='python -m pytest'
# fish uses the dedicated .fish activation script, not the POSIX one.
alias aenv='source ./.venv/bin/activate.fish'
alias denv='deactivate'

# pip
alias pip='pip3'

# dbt (Fusion). The `dbtf` alias is provided by the dbt binary itself.
alias dbt-clear='dbt run-operation drop_old_relations --args "{\"dryrun\": false}"'

# terraform
alias tg='terragrunt'
