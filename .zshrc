##############################################################################
# Source's
##############################################################################
export DOTFILES=$HOME/dotfiles
export OPTBREWPATH=/opt/homebrew/share
export INCLUDES=$HOME/.local/share/dotfiles

source $OPTBREWPATH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $OPTBREWPATH/zsh-history-substring-search/zsh-history-substring-search.zsh
source $OPTBREWPATH/zsh-autosuggestions/zsh-autosuggestions.zsh
source $OPTBREWPATH/powerlevel10k/powerlevel10k.zsh-theme

source $HOME/.themes/zsh/.p10k.zsh
source $HOME/.zaliases
source $HOME/.zscripts
# source $HOME/.zbindings
source $HOME/.zprofile

zmodload -i zsh/complist
zmodload -i zsh/zle

# zsh-completions plugin
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -U compinit
  compinit
fi

##############################################################################
# Homebrew
##############################################################################
if [[ "$(/usr/bin/uname -m)" == "arm64" ]]; then
  # ARM macOS
  HOMEBREW_PREFIX="/opt/homebrew"
else
  # Intel macOS
  HOMEBREW_PREFIX="/usr/local"
fi

eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"

# mysql client
# export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
# brew packages
export PATH="$PYENV_ROOT/bin:$PATH"
# export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# Setup for pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

##############################################################################
# MacOs
##############################################################################
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

if [[ "$TERM" == "tmux-256color" ]]; then
  export TERM=screen-256color
fi

# npm global
export NPM_PACKAGES="/usr/local/npm_packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$NPM_PACKAGES/bin:$PATH"

# prefer US English & utf-8
export LANG=en_US.UTF-8

##############################################################################
# History
##############################################################################
export HISTFILE=~/.zhistory
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export HISTTIMEFORMAT="[%F %T] "
export EDITOR=nvim

export DISABLE_MAGIC_FUNCTIONS=true

setopt EXTENDED_HISTORY          
setopt SHARE_HISTORY             
setopt BANG_HIST
setopt HIST_EXPIRE_DUPS_FIRST    
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt INC_APPEND_HISTORY
setopt INC_APPEND_HISTORY_TIME
setopt HIST_REDUCE_BLANKS
setopt IGNORE_EOF 
setopt HIST_VERIFY  
setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt AUTO_LIST
setopt AUTO_REMOVE_SLASH
setopt LIST_AMBIGUOUS
setopt EXTENDED_GLOB  NO_BEEP      # Use extended globbing syntax.
setopt CASE_MATCH
setopt CASE_PATHS
setopt CSH_NULL_GLOB
setopt PROMPT_SP
setopt NO_LIST_BEEP
setopt NO_BEEP
setopt MENU_COMPLETE
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt PROMPT_SUBST
setopt NO_HUP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps

##############################################################################
# SSH
# brew install keychain
if hash keychain 2>/dev/null; then
  alias ssh-agent-start='eval `keychain --eval --agents ssh --inherit any gitlab id_rsa`'
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
# Movement
bindkey -e '^a' beginning-of-line
bindkey -e '^e' end-of-line

bindkey '^[[Z' reverse-menu-complete
## history-substring-search
# Control-P/N keys
# History
bindkey -e '^p' up-history
bindkey -e '^n' down-history
# Search using patterns as documented here:
# http://zsh.sourceforge.net/Doc/Release/Expansion.html#Filename-Generation
bindkey -e '^r' history-incremental-pattern-search-backward
bindkey -e '^f' history-incremental-pattern-search-forward

bindkey -e '^j' history-substring-search-up
bindkey -e '^k' history-substring-search-down

##############################################################################
# Bindings
##############################################################################
# change Ctrl+C to Ctrl+Q
stty intr '^d'
stty erase '^?'

##############################################################################
# Fzf
##############################################################################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --extended -i -m'
export FZF_DEFAULT_COMMAND="fd --type file --follow --hidden --exclude 'Library' --exclude 'Music' --exclude 'Pictures'"
export FZF_ALT_C_COMMAND='fd --follow --type d --exclude "Library/" --exclude "Music/"'

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export BAT_THEME="gruvbox-dark"
export FZF_CTRL_T_COMMAND='find *~Library~Applications~qmk_firmware~Creative\ Cloud\ Files~Pictures notes/  2>/dev/null'

export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
export BAT_THEME="gruvbox-dark"

##############################################################################
# Brew
##############################################################################
# java sdk - jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

##############################################################################
# Various
##############################################################################
# kubernetes
export KUBECONFIG=.kubeconfig:$HOME/.kube/config

# zoxide 
eval "$(zoxide init zsh)"
##############################################################################
# Iterm2
##############################################################################
source "${HOME}/.iterm2_shell_integration.zsh"

if [[ -z "$ITERM2_INTEGRATION_DETECTED" ]]; then
  export ITERM2_INTEGRATION_DETECTED=true
  export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES
fi

##############################################################################
# Ls and Less
##############################################################################
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES

# disable zsh underline
ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
ZSH_HIGHLIGHT_STYLES[precommand]='none'
ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[assign]='none'
# ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[suffix-alias]='none'
# ZSH_HIGHLIGHT_STYLES[precommand]=fg=blue,underline

##############################################################################
# Nvm
##############################################################################

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

# _nvmrc_hook() {
#   if [[ $PWD == $PREV_PWD ]]; then
#     return
#   fi
#   
#   PREV_PWD=$PWD
#   [[ -f ".nvmrc" ]] && nvm use
# }

# if ! [[ "${PROMPT_COMMAND:-}" =~ _nvmrc_hook ]]; then
#   PROMPT_COMMAND="_nvmrc_hook${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
# fi

##############################################################################
# Completion
##############################################################################
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

##############################################################################
# Python
##############################################################################
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

##############################################################################
# Ruby
##############################################################################
# if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
#   export PATH=/opt/homebrew/opt/ruby/bin:$PATH
#   export PATH=`gem environment gemdir`/bin:$PATH
# fi

# eval "$(rbenv init - zsh)"
