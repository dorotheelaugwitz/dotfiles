export ZSH="/Users/Doro/.oh-my-zsh"
export LANG=en_US.UTF-8

CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"
HYPHEN_INSENSITIVE="true"
ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh
[[ -f aliases ]] && source aliases
# [[ -f g ]] && source g
for function in ~/dotfiles/functions/*; do
  source $function
done

# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
