export ZSH="/Users/Doro/.oh-my-zsh"
export LANG=en_US.UTF-8

CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"
HYPHEN_INSENSITIVE="true"
ZSH_THEME="agnoster"

source $ZSH/oh-my-zsh.sh
[[ -f aliases ]] && source aliases

for function in ~/dotfiles/functions/*; do
  source $function
done

# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# For capybara-webkit
export PATH="$(brew --prefix qt@5.5)/bin:$PATH"
