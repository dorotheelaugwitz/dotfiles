export ZSH="/Users/doro/.oh-my-zsh"
export LANG=en_US.UTF-8

CASE_SENSITIVE="false"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
HYPHEN_INSENSITIVE="true"
ZSH_THEME="agnoster"

source $ZSH/oh-my-zsh.sh
source dotfiles/aliases

for function in ~/dotfiles/functions/*; do
  source $function
done

# List all files after changing current directory
cd () { builtin cd "$@" && ls -a; }

# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# load rbenv if available
if command -v rbenv >/dev/null; then
  eval "$(rbenv init - --no-rehash)"
fi

# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/sbin:$PATH"

export -U PATH

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
