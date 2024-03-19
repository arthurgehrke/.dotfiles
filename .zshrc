if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

##############################################################################
# Paths
##############################################################################
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

export XDG_CONFIG_HOME=$HOME/.config
# mosh server
export PATH=$PATH:/usr/local/bin

# remove duplicat entries from $PATH
# zsh uses $path array along with $PATH
typeset -U PATH path

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

##############################################################################
# Homebrew
##############################################################################
if [[ "$(/usr/bin/uname -m)" == "arm64" ]]; then
  # ARM macOS
  export HOMEBREW_PREFIX="/opt/homebrew"
else
  # Intel macOS
  export HOMEBREW_PREFIX="/usr/local"
fi


if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

export HOMEBREW_BREWFILE=$HOME/Brewfile
# export HOMEBREW_CASK_OPTS="--appdir=/Applications"

##############################################################################
# MacOs
##############################################################################
source $HOME/.zaliases
source $HOME/.zscripts
source $HOME/.zprofile
source $HOME/.themes/zsh/.p10k.zsh

zmodload -i zsh/complist
zmodload -i zsh/zle

export EDITOR=nvim
export LANG=en_US.UTF-8

export TERM=xterm-256color

export TERM='xterm-256color'

[[ "${TMUX}" != "" ]] && export TERM='screen-256color'
# if [[ -z "$TMUX" ]]; then
#   export TERM="xterm-256color"
# fi

export DISABLE_MAGIC_FUNCTIONS=true

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
  alias ssh-agent-start='eval `keychain --eval --agents ssh --inherit any gitlab github`'
  alias ssh-agent-stop='keychain --stop all'
fi

##############################################################################
# KeyMappings
##############################################################################
autoload -z edit-command-line
zle -N edit-command-line

bindkey -e
bindkey -e "^x" edit-command-line
bindkey -e '^o' autosuggest-accept
bindkey -e '^b' backward-word
bindkey -e '^e' forward-word
bindkey -e '^h' backward-char
bindkey -e '^l' forward-char
bindkey -e '^i' expand-or-complete
bindkey -e '^F' autosuggest-accept-suggested-small-word
bindkey -e '^d' delete-char


bindkey '^R' history-incremental-search-backward

# Movement
bindkey -e '^a' beginning-of-line
bindkey -e '^e' end-of-line

bindkey -e "^y" yank
bindkey -e '^w' backward-kill-word

bindkey '^[[Z' reverse-menu-complete

## history-substring-search
# Control-P/N keys
# History
# bindkey -e '^p' up-history
# bindkey -e '^n' down-history

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

# Search using patterns as documented here:
# http://zsh.sourceforge.net/Doc/Release/Expansion.html#Filename-Generation

bindkey -e '^r' history-incremental-pattern-search-backward
bindkey -e '^f' history-incremental-pattern-search-forward

bindkey -e '^j' history-substring-search-up
bindkey -e '^k' history-substring-search-down

##############################################################################
# Bindings
##############################################################################
# change Ctrl+C to Ctrl+Q - enable only on interactive shells
PS1=$PROMPT
[ "$PS1" ] && stty intr '^d'
[ "$PS1" ] && stty erase '^?'

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
# export FZF_ALT_C_COMMAND="fd -t d . $HOME"
export FZF_ALT_C_COMMAND="rg --files --hidden --null . 2>/dev/null | xargs -0 dirname | sort -u"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
# Disable preview, useless for History completion
export FZF_CTRL_R_OPTS="--no-preview"
export FZF_ALT_C_COMMAND="fd --type d . --color=never"

##############################################################################
# Java
##############################################################################
export PATH="$HOME/.jenv/bin:$PATH"

##############################################################################
# Docker & Kube
##############################################################################
# kubernetes
export KUBECONFIG=.kubeconfig:$HOME/.kube/config

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
ZSH_HIGHLIGHT_STYLES[suffix-alias]='none'

##############################################################################
# Nvm or n and Node
##############################################################################
# nodenv
# export NODENV_VERSION=20.11.1
export PATH="$HOME/.nodenv/bin:$PATH"
export NODENV_VERSION="$(nodenv-global 2>/dev/null || true)"

# npm global
export NPM_PACKAGES=${HOME}/.npm-global
export NPM_CONFIG_PREFIX=${HOME}/.npm-global
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$NPM_PACKAGES/bin:$PATH"
MANPATH="$NPM_PACKAGES/share/man:$MANPATH"

# Give nodejs (a lot) more memory.
export NODE_OPTIONS="--max-old-space-size=65536"

##############################################################################
# Zsh lugins
##############################################################################
ZSH_AUTOSUGGESTIONS="$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
[ -f "$ZSH_AUTOSUGGESTIONS" ] && source "$ZSH_AUTOSUGGESTIONS"

source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme
source $HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh


##############################################################################
# Python
##############################################################################
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# export PATH="$(brew --prefix python)/libexec/bin:$PATH"

export PATH="$HOME/.pyenv/bin:$PATH"

# pipx
# Setup for pyenv
export PATH="/usr/local/bin:$PATH"

##############################################################################
# Ruby
##############################################################################
export GEM_HOME="$HOME/.gem"

##############################################################################
# Packages
##############################################################################
# zoxide

# Add MySQL client to PATH, if it exists
if [ -d "/opt/homebrew/opt/mysql-client/bin" ]; then
  export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
fi

# autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
##############################################################################
# Iterm2
##############################################################################
# iTerm integration (for OS X iTerm2)
# @see https://iterm2.com/shell_integration.html
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

python-update() {
  latest=$(pyenv install --list | sed -e '/^.*[a-zA-Z].*$/d' | tail -1 | tr -d '\n ')
  current=$(cat "${HOME}/.anyenv/envs/pyenv/version")
  [[ ${latest} != ${current} ]] && pyenv install ${latest} && pyenv global ${latest} && pyenv rehash
}

node-update() {
  latest=$(curl --silent "https://api.github.com/repos/nodejs/node/releases" | jq -r '[.[]][].name' | grep LTS |  cut -f 3 -d " " | sort | tail -1 | tr -d '\n')
  current=$(cat "${HOME}/.anyenv/envs/nodenv/version")
  [[ ${latest} != ${current} ]] && nodenv install ${latest} && nodenv global ${latest} && nodenv rehash
}

ruby-update() {
  latest=$(rbenv install --list | sed -e '/^.*[a-zA-Z].*$/d' | tail -1 | tr -d '\n ')
  IsMacOS && latest=$(rbenv install --list | sed -e '/^.*[a-zA-Z].*$/d' | grep "2." | tail -1 | tr -d '\n ')
  current=$(cat "${HOME}/.anyenv/envs/rbenv/version")
  [[ ${latest} != ${current} ]] &&  rbenv install ${latest} && rbenv global ${latest} && rbenv rehash
}

export PATH="$HOME/.anyenv/bin:$PATH"
