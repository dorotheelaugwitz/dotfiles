export ZSH="$HOME/.oh-my-zsh"
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

# zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# load rbenv if available
if command -v rbenv >/dev/null; then
  eval "$(rbenv init - --no-rehash)"
fi

# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/sbin:$PATH"

export -U PATH

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh
