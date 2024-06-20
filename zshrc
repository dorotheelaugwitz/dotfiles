export ZSH=$HOME/.oh-my-zsh
export LANG=en_US.UTF-8
export EDITOR=code
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

CASE_SENSITIVE=false
COMPLETION_WAITING_DOTS=true
DEFAULT_USER=doro
HIST_STAMPS="yyyy-mm-dd"
HYPHEN_INSENSITIVE=true
ZSH_THEME="agnoster"

zstyle ':omz:update' mode auto

plugins=(pip pipenv)

source $ZSH/oh-my-zsh.sh
source ~/dotfiles/aliases

for function in ~/dotfiles/functions/*; do
  source $function
done

# zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if command -v asdf >/dev/null; then
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# ensure dotfiles bin directory is loaded first
export PATH=$HOME/bin:/usr/local/bin:$PATH
