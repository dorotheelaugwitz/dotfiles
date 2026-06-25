# ~/.config/fish/conf.d/aliases.fish

# ls -> eza, with a plain-ls fallback if eza isn't installed
if type -q eza
    alias ls='eza --group-directories-first --icons=auto'
    alias ll='eza -la --git --group-directories-first --icons=auto'
    alias la='eza -a --group-directories-first --icons=auto'
    alias lt='eza --tree --level=2 --icons=auto'
else
    alias ls='ls -G'
    alias ll='ls -al'
end
alias ln='ln -v'
alias h='cd ~'
alias path='printf "%s\n" $PATH'

# cat -> bat
type -q bat; and alias cat='bat'

# Python
alias t='python -m pytest'
alias aenv='source ./.venv/bin/activate.fish'
alias denv='deactivate'
alias pip='pip3'

# dbt
alias dbt-clear='dbt run-operation drop_old_relations --args "{\"dryrun\": false}"'

# terraform
alias tg='terragrunt'
