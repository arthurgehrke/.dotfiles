# Make things in my homedir the first to be tried for easy customization
export PATH=~/bin:$PATH

# remove duplicat entries from $PATH
# zsh uses $path array along with $PATH
export PATH="/opt/homebrew/sbin:$PATH"
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/lib
export PATH=$(brew --prefix openssl)/bin:$PATH
# export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm@17/bin:$PATH"
export PATH="/opt/homebrew/opt/ncurses/bin:$PATH"
# export LDFLAGS="-L/opt/homebrew/opt/ncurses/lib"
export LDFLAGS="-L/opt/homebrew/opt/llvm@17/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/ncurses/include"
export CPPFLAGS="-I/opt/homebrew/opt/llvm@17/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ncurses/lib/pkgconfig"

##############################################################################
# Brew
##############################################################################
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS

if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
fi

source "$HOME"/.zaliases
source "$HOME"/.zscripts
source "$HOME"/.zprofile
source "$HOME"/.themes/zsh/circular/.p10k.zsh
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh #should come before substring-search plugin
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/forgit/forgit.plugin.zsh

##############################################################################
# Config
##############################################################################
autoload -U colors && colors

# export NO_COLOR=1
export LANG=en_US.UTF-8
export EDITOR=nvim
export VISUAL="$EDITOR"
export PAGER=less
export DISABLE_AUTO_TITLE=true

# VCS display
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -U colors && colors

export TERM="tmux-256color"
# export TERM=screen-256color

export DISABLE_MAGIC_FUNCTIONS=true

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  if [ -r ~/.dircolors ]; then
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
export SAVEHIST=1000000000
export HISTTIMEFORMAT="[%F %T] "
export HIST_STAMPS="yyyy-mm-dd"

setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt BANG_HIST
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS # Do not display a previously found event.
setopt HIST_IGNORE_SPACE # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS # Do not write a duplicate event to the history file.
setopt HIST_VERIFY       # Do not execute immediately upon history expansion.
setopt INC_APPEND_HISTORY
setopt INC_APPEND_HISTORY_TIME
setopt HIST_REDUCE_BLANKS
setopt IGNORE_EOF
setopt AUTO_PUSHD        # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS # Do not store duplicates in the stack.
setopt PUSHD_SILENT      # Do not print the directory stack after pushd or popd.
setopt AUTO_LIST
setopt AUTO_REMOVE_SLASH
setopt LIST_AMBIGUOUS
setopt EXTENDED_GLOB
setopt NO_BEEP
setopt CASE_MATCH
setopt CASE_PATHS
setopt CSH_NULL_GLOB
setopt COMPLETE_IN_WORD
setopt PROMPT_SUBST
setopt NO_HUP
setopt NO_LIST_BEEP

##############################################################################
# Completion
##############################################################################
# Force the usage of Emacs keybindings. Otherwise they will be set
# depending on whether the literal string "vi" appears in the value of
# EDITOR, which is a terrible idea for many reasons (not least of
# which being that my EDITOR is Vim while I want to use Emacs
# keybindings in Zsh).
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list \
  'm:{[:lower:]}={[:upper:]}' \
  '+r:|[._-]=* r:|=*' \
  '+l:|=*'

# color
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:*:cp:*' file-sort size
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*' completer _expand _complete _approximate

unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND
unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND

##############################################################################
# KeyMappings
##############################################################################
bindkey -e
autoload -z edit-command-line
zle -N edit-command-line

bindkey -e "^x" edit-command-line
bindkey -e '^o' autosuggest-accept
bindkey -e '^b' backward-word
bindkey -e '^e' forward-word
bindkey -e '^h' backward-char
bindkey -e '^l' forward-char
bindkey -e '^F' autosuggest-accept-suggested-small-word
bindkey -e '^d' delete-char
#bindkey '^R' history-incremental-search-backward
bindkey -e '^a' beginning-of-line
bindkey -e '^e' end-of-line
# bindkey -e "^y" yank
bindkey -e '^Y' accept-search
bindkey -e '^w' backward-kill-word

bindkey '\t' autosuggest-accept

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

bindkey -e '^j' history-substring-search-up
bindkey -e '^k' history-substring-search-down

# shift + tab
bindkey -e '^I' complete-word # tab          | complete
bindkey '^[[Z' reverse-menu-complete

bindkey -e '^u' expand-or-complete

# bindkey -e '^r' history-incremental-pattern-search-backward

peco-history-selection() {
  BUFFER=$(history -n 1 | tail -r | awk '!a[$0]++' | peco)
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

# exit proccess
stty intr \^k

##############################################################################
# Ruby
##############################################################################
export RBENV_ROOT=~/.rbenv
eval "$(rbenv init -)"

alias clean-gems='gem list | cut -d" " -f1 | xargs gem uninstall -aIx'
alias insecure-chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --disable-web-security --user-data-dir=/Users/$USER/Library/Application\\ Support/Google/ChromeInsecure > /dev/null 2>&1 &"

##############################################################################
# Java
##############################################################################
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8.0_252)

##############################################################################
# Php
##############################################################################
export PATH=~/.composer/vendor/bin:$PATH

##############################################################################
# Node
##############################################################################
export NPM_PACKAGES=${HOME}/.npm-global
export NPM_CONFIG_PREFIX=${HOME}/.npm-global
export PATH="$HOME/.npm-global/bin:$PATH"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$HOME/.nodenv/bin:$PATH"
export NODENV_VERSION="$(nodenv-global 2>/dev/null || true)"
eval "$(nodenv init -)"

##############################################################################
# Python
##############################################################################
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PIPENV_PYTHON="$PYENV_ROOT/shims/python"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

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

set rtp+= "$HOMEBREW"/fzf

#############################################################################
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
# Git
##############################################################################
export GIT_MERGE_AUTOEDIT=1

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

##############################################################################
# Paths
##############################################################################
# Homebrew requires this path.

source /Users/arthurgehrke/.config/broot/launcher/bash/br
