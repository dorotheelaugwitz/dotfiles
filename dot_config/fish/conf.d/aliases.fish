# ~/.config/fish/conf.d/aliases.fish

alias ll='ls -al'
alias ls='ls -G'
alias ln='ln -v'
alias h='cd ~'
alias gf='git flow'
alias path='printf "%s\n" $PATH'

# Rails
alias be='bundle exec'
alias s='bundle exec rspec'
alias rc='bundle exec rails console'
alias rs='bundle exec rails server'

# Python
alias t='python -m pytest'
alias aenv='source ./.venv/bin/activate.fish'
alias denv='deactivate'
alias pip='pip3'

# dbt
alias dbt-clear='dbt run-operation drop_old_relations --args "{\"dryrun\": false}"'

# terraform
alias tg='terragrunt'
