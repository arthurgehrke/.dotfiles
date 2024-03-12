if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export NODENV_ROOT=~/.nodenv

export NODENV_VERSION=20.11.1
export PATH="/opt/homebrew/bin:$PATH" 

eval "$(nodenv init -)"
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(nodenv init - --no-rehash)"

export PATH="$HOME/.nodenv/bin:$PATH"

source $HOME/.themes/zsh/.p10k.zsh

[[ ! -f ~/.themes/zsh/.p10k.zsh ]] || source ~/.themes/zsh/.p10k.zsh
  source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# zoxide
if command -V zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

export PATH="/usr/local/opt/curl/bin:$PATH"
##############################################################################
# Source's
##############################################################################
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Homebrew zsh-completions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

 #Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $HOME/.themes/zsh/.p10k.zsh
# To customize prompt, run `p10k configure` or edit ~/.themes/zsh/circular/.p10k.zsh.
[[ ! -f ~/.themes/zsh/circular/.p10k.zsh ]] || source ~/.themes/zsh/.p10k.zsh
source $HOME/.zaliases
source $HOME/.zscripts
source $HOME/.zprofile

zmodload -i zsh/complist
zmodload -i zsh/zle

  autoload -U compinit
  compinit

##############################################################################
# Homebrew
##############################################################################
# mysql client
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

##############################################################################
# MacOs
##############################################################################
if [[ "$TERM" == "tmux-256color" ]]; then
  export TERM=screen-256color
fi

# prefer US English & utf-8
export LANG=en_US.UTF-8
##############################################################################
# History
##############################################################################
export HISTFILE=~/.
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
# Movement
bindkey -e '^a' beginning-of-line
bindkey -e '^e' end-of-line

bindkey "^y" yank
bindkey '^w' backward-kill-word

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
# change Ctrl+C to Ctrl+Q - enable only on interactive shells
[ "$PS1" ] && stty intr '^d'
[ "$PS1" ] && stty erase '^?'

##############################################################################
# Fzf
##############################################################################
if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
fi

export BAT_THEME="gruvbox-dark"
export FZF_DEFAULT_OPTS="--height 80% --reverse --border"
export FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build} --hidden --type file --no-ignore-vcs"
export FZF_ALT_C_COMMAND='fd --follow --type d --exclude "Library/" --exclude "Music/"'
# export FZF_ALT_C_COMMAND="fd -t d . $HOME"
export FZF_ALT_C_COMMAND="rg --files --hidden --null . 2>/dev/null | xargs -0 dirname | sort -u"

# Disable preview, useless for History completion
export FZF_CTRL_R_OPTS="--no-preview"
export FZF_ALT_C_OPTS="--no-preview"

##############################################################################
# Brew
##############################################################################
# java sdk - jenv

##############################################################################
# Various
##############################################################################
# kubernetes
export KUBECONFIG=.kubeconfig:$HOME/.kube/config

# zoxide 


##############################################################################
# Iterm2
##############################################################################
# iTerm integration (for OS X iTerm2)
# @see https://iterm2.com/shell_integration.html
if [[ "`uname`" == "Darwin" ]] && [[ -z "$NVIM" ]] && [[ -f ${HOME}/.iterm2_shell_integration.zsh ]]; then
  export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES
  source ${HOME}/.iterm2_shell_integration.zsh
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
# Nvm or n and Node
##############################################################################
# Give nodejs (a lot) more memory.
export NODE_OPTIONS="--max-old-space-size=65536"
# npm global
export NPM_PACKAGES="${HOME}/.npm-global"

#asdf
# Load asdf and asdf plugins

# export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME=".tool-versions"
# export ASDF_CONFIG_FILE="$HOME/.asdfrc"
# export ASDF_NPM_DEFAULT_PACKAGES_FILE="$HOME/.default-npm-packages"
# export ASDF_PYTHON_DEFAULT_PACKAGES_FILE="$HOME/.default-python-packages"

##############################################################################
# Completion
##############################################################################

##############################################################################
# Python
##############################################################################
export PYENV_ROOT="$HOME/.pyenv"

# Check if pyenv is there and initialize it
if command -v pyenv &> /dev/null; then
    # Make sure that we have pyenv initialized
    eval "$(pyenv init -)"
fi


##############################################################################
# Ruby
##############################################################################
export GEM_HOME="$HOME/.gem"

export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";

# Setup for pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="/usr/local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH" 

