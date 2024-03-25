eval "$(/opt/homebrew/bin/brew shellenv)"
# Path
export PATH="/usr/local/sbin:$PATH"

# brew mac m1
export PATH=/opt/homebrew/bin:$PATH

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

source $HOME/.zaliases
source $HOME/.zscripts
# source $HOME/.zprofile
source $HOME/.themes/zsh/.p10k.zsh
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

##############################################################################
# Config
##############################################################################
setopt NO_BEEP

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ] ; then
    if [ -r ~/.dircolors ] ; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
fi

##############################################################################
# History
##############################################################################
export HISTFILE=~/.zsh_history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export HISTTIMEFORMAT="[%F %T] "
export HIST_STAMPS="yyyy-mm-dd"

##############################################################################
# SSH
##############################################################################
# brew install keychain
if hash keychain 2>/dev/null; then
  alias ssh-agent-start='eval `keychain --eval --agents ssh --inherit any gitlab github`'
  alias ssh-agent-stop='keychain --stop all'
fi

##############################################################################
# KeyMappings
##############################################################################
autoload -z edit-command-line
zle -N edit-command-line

bindkey -e "^x" edit-command-line
bindkey -e '^o' autosuggest-accept
bindkey -e '^b' backward-word
bindkey -e '^e' forward-word
bindkey -e '^h' backward-char
bindkey -e '^l' forward-char
bindkey -e '^i' expand-or-complete
bindkey -e '^F' autosuggest-accept-suggested-small-word
bindkey -e '^d' delete-char
#bindkey '^R' history-incremental-search-backward
bindkey -e '^a' beginning-of-line
bindkey -e '^e' end-of-line
bindkey -e "^y" yank
bindkey -e '^w' backward-kill-word
bindkey '^[[Z' reverse-menu-complete
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search
bindkey -e '^r' history-incremental-pattern-search-backward
bindkey -e '^f' history-incremental-pattern-search-forward
bindkey -e '^j' history-substring-search-up
bindkey -e '^k' history-substring-search-down

##############################################################################
# Ruby
##############################################################################
export GEM_HOME="$HOME/.gem"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

##############################################################################
# Java
##############################################################################
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"
export PATH=${JAVA_HOME}/bin:$PATH
alias jenv_set_java_home='export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"'

##############################################################################
# Python
##############################################################################
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PATH="$HOME/.pyenv/shims:$PATH"
export PYTHONPATH="${PYTHONPATH}:[Python/*version*/bin]"

##############################################################################
# Node
##############################################################################
export NPM_PACKAGES=${HOME}/.npm-global
export NPM_CONFIG_PREFIX=${HOME}/.npm-global
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$HOME/.nodenv/bin:$PATH"
export NODENV_VERSION="$(nodenv-global 2>/dev/null || true)"
eval "$(nodenv init -)"

##############################################################################
# Packages
##############################################################################
if command -V zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# ngrok
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

