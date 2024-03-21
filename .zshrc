# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi




  source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
##############################################################################
# Paths
##############################################################################

# # remove duplicat entries from $PATH
# # zsh uses $path array along with $PATH
# typeset -U PATH path

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

source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
#source $HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme
source $HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

  if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
  fi



##############################################################################
# MacOs
##############################################################################
source $HOME/.zaliases
source $HOME/.zscripts
source $HOME/.zprofile
#source $HOME/.themes/zsh/.p10k.zsh

zmodload -i zsh/complist
zmodload -i zsh/zle

export EDITOR=nvim
export LANG=en_US.UTF-8

# export TERM='xterm-256color'
export TERM="screen-256color"

[[ "${TMUX}" != "" ]] && export TERM='screen-256color'
# if [[ -z "$TMUX" ]]; then
[[ "${TMUX}" = "" ]] && export TERM='xterm-256color'
#   export TERM="tmux-256color"
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

peco-history-selection() {
  BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection
# bindkey '^R' history-incremental-search-backward

# Movement
bindkey -e '^a' beginning-of-line
bindkey -e '^e' end-of-line

bindkey -e "^y" yank
bindkey -e '^w' backward-kill-word

bindkey '^[[Z' reverse-menu-complete

## history-substring-search
# Control-P/N keys
bindkey -e '^p' up-history
bindkey -e '^n' down-history

# Search using patterns as documented here:
# http://zsh.sourceforge.net/Doc/Release/Expansion.html#Filename-Generation

bindkey -e '^r' history-incremental-pattern-search-backward
bindkey -e '^f' history-incremental-pattern-search-forward

bindkey -e '^j' history-substring-search-up
bindkey -e '^k' history-substring-search-down

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
  eval "$(jenv init -)"


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
#export PATH="$HOME/.nodenv/bin:$PATH"
#export NODENV_VERSION="$(nodenv-global 2>/dev/null || true)"

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




##############################################################################
# Python
##############################################################################

##############################################################################
# Ruby
##############################################################################

##############################################################################
# Packages
##############################################################################
#export TERMINFO_DIRS=$TERMINFO_DIRS:$HOME/.local/share/terminfo
# zoxide

# Add MySQL client to PATH, if it exists
if [ -d "/opt/homebrew/opt/mysql-client/bin" ]; then
  export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
fi


##############################################################################
# Iterm2
##############################################################################
# iTerm integration (for OS X iTerm2)
# @see https://iterm2.com/shell_integration.html
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# nodenv
#if which nodenv &> /dev/null; then eval "$(nodenv init --no-rehash -)"; fi
#export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

if command -V zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# ngrok
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
