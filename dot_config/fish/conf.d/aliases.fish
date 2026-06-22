# ~/.config/fish/conf.d/aliases.fish

# ls -> eza, with a plain-ls fallback if eza isn't installed
if type -q eza
    alias ls='eza --group-directories-first'
    alias ll='eza -la --git --group-directories-first'
    alias la='eza -a --group-directories-first'
    alias lt='eza --tree --level=2'
else
    alias ls='ls -G'
    alias ll='ls -al'
end
alias ln='ln -v'
alias h='cd ~'
alias gf='git flow'
alias path='printf "%s\n" $PATH'

# cat -> bat
type -q bat; and alias cat='bat'

# Rails
alias be='bundle exec'
alias s='bundle exec rspec'
alias rc='bundle exec rails console'
alias rs='bundle exec rails server'

# Python
alias t='python -m pytest'
alias aenv='source ./.venv/bin/activate.sh'
alias denv='deactivate'
alias pip='pip3'

# dbt
alias dbt-clear='dbt run-operation drop_old_relations --args "{\"dryrun\": false}"'

# terraform
alias tg='terragrunt'
