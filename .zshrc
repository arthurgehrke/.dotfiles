eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH=$PATH:/usr/local/bin 
export PATH=$PATH:/usr/local/lib
export PATH="/usr/local/sbin:$PATH"

# ncurses
export LDFLAGS="-L/opt/homebrew/opt/ncurses/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ncurses/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ncurses/lib/pkgconfig"
export PATH="/opt/homebrew/opt/ncurses/bin:$PATH"

# brew mac m1
export PATH=/opt/homebrew/bin:$PATH

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

source "$HOME"/.zaliases
source "$HOME"/.zscripts
# source $HOME/.zprofile
source "$HOME"/.themes/zsh/.p10k.zsh
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

##############################################################################
# Config
##############################################################################
setopt NO_BEEP
setopt NO_LIST_BEEP
export LANG=en_US.UTF-8
export EDITOR=nvim
export PAGER=less

export TERM="tmux-256color"

export DISABLE_MAGIC_FUNCTIONS=true

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
setopt MENU_COMPLETE
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt PROMPT_SUBST
setopt NO_HUP

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
# edit current command in $EDITOR


# bindkey -e '^r' history-incremental-pattern-search-backward

peco-history-selection() {
  BUFFER=$(history -n 1 | tail -r  | awk '!a[$0]++' | peco)
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

bindkey -e '^f' history-incremental-pattern-search-forward

bindkey -e '^j' history-substring-search-up
bindkey -e '^k' history-substring-search-down

# exit proccess
stty intr \^k
##############################################################################
# Ruby
##############################################################################
if [ -d "$HOME/.rbenv" ]; then
  export RBENV_ROOT="$HOME/.rbenv"
  eval "$(rbenv init - zsh)"
fi

export GEM_HOME="$HOME/.gem"

##############################################################################
# Java
##############################################################################
export PATH="$HOME/.jenv/bin:$PATH" 
eval "$(jenv init -)" 
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8.0_252)

##############################################################################
# Fzf
##############################################################################
if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
fi

export BAT_THEME="gruvbox-dark"
export FZF_DEFAULT_OPTS="--height 75% --layout=reverse --border"
export FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build} --hidden --type file --no-ignore-vcs"
export FZF_ALT_C_COMMAND='fd --follow --type d --exclude "Library/" --exclude "Music/"'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
# Disable preview, useless for History completion
export FZF_CTRL_R_OPTS="--no-preview"

##############################################################################
# Python
##############################################################################
# export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_ROOT=$(pyenv root)

export PATH="$PYENV_ROOT/shims:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# needed
export PYTHONPATH="${PYTHONPATH}:[Python/*version*/bin]"

##############################################################################
# Php
##############################################################################
export PATH=~/.composer/vendor/bin:$PATH

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

##############################################################################
# Iterm2
##############################################################################
# iTerm integration (for OS X iTerm2)
# @see https://iterm2.com/shell_integration.html
if [[ "$(uname)" == "Darwin" ]] && [[ -z "$NVIM" ]] && [[ -f ${HOME}/.iterm2_shell_integration.zsh ]]; then
  export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES
  source "${HOME}"/.iterm2_shell_integration.zsh
fi

##############################################################################
# Docker
##############################################################################
# export PATH="$HOME/.docker/bin":$PATH
if [ -d "$HOME/.docker" ]; then
    export PATH="$PATH:$HOME/.docker/bin"
fi
