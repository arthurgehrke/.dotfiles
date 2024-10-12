# Hopefully this loads powerlevel10k theme faster
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if type brew &>/dev/null
then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi

##############################################################################
# Homebrew Configurações
##############################################################################
if [ -d "/opt/homebrew/bin" ]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi

##############################################################################
# Sourcing e Plugins
##############################################################################
source "$HOME"/.zaliases
source "$HOME"/.zprofile
source "$HOME"/.zfunctions

fpath=( "$HOME/.zfunctions" $fpath )

source "$HOME"/.themes/zsh/minimalist/.p10k.zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

source "$(brew --prefix)"/share/powerlevel10k/powerlevel10k.zsh-theme
source "$(brew --prefix)"/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source "$(brew --prefix)"/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source "$(brew --prefix)"/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# homebrew completion
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

##############################################################################
# Prompt & Completion
##############################################################################
# autoload -U colors && colors

unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND
unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
typeset -A ZSH_HIGHLIGHT_STYLES
# Default style
ZSH_HIGHLIGHT_STYLES[default]=fg=#ebdbb2,bold
# Errors and unknown tokens
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=#fb4934
# Reserved words like if, then, etc.
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=#fb4934,standout
# Alias commands
ZSH_HIGHLIGHT_STYLES[alias]=fg=#fe8019,bold
# Built-in shell commands like `cd`
ZSH_HIGHLIGHT_STYLES[builtin]=fg=#b8bb26,bold
# Functions
ZSH_HIGHLIGHT_STYLES[function]=fg=#d3869b,bold
# External commands like `ls`
ZSH_HIGHLIGHT_STYLES[command]=fg=#83a598,bold
# Commands before pipes, like `sudo` or `time`
ZSH_HIGHLIGHT_STYLES[precommand]=fg=#fabd2f,bold
# Command separator (`;` or `&&`)
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=#fabd2f,bold
# Hashed commands from `$PATH`
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=#b8bb26,bold
# File paths
ZSH_HIGHLIGHT_STYLES[path]=fg=#8ec07c,underline
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=fg=#d79921,underline
ZSH_HIGHLIGHT_STYLES[path_prefix]=fg=#b16286,underline
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=fg=#d79921,underline
# Globbing (wildcards like `*`)
ZSH_HIGHLIGHT_STYLES[globbing]=fg=#fabd2f,bold
# History expansion (`!`)
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=#fabd2f,bold,underline
# Options (like `-a`, `--help`)
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=#fabd2f,bold
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=#d79921,bold
# Quoted arguments
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=fg=#8ec07c,bold
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=#d3869b,bold
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=#b16286,bold
ZSH_HIGHLIGHT_STYLES[double-quoted-argument_unclosed]=fg=#cc241d,bold
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=#fabd2f,bold
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=#fe8019,bold
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=#fabd2f,bold
# Comments
ZSH_HIGHLIGHT_STYLES[comment]=fg=#928374,bold
# Redirection (`>`, `>>`)
ZSH_HIGHLIGHT_STYLES[redirection]=fg=#fe8019,bold
# Assignments (like `foo=bar`)
ZSH_HIGHLIGHT_STYLES[assign]=fg=#b16286,bold
# Highlight the word "sudo"
ZSH_HIGHLIGHT_REGEXP+=('\bsudo\b' fg=#d79921,bold)

##############################################################################
# Configurações Gerais
##############################################################################
export LANG=en_US.UTF-8
export EDITOR=nvim
export VISUAL="$EDITOR"
export PAGER=less
export TERM="xterm-256color"

export DISABLE_AUTO_TITLE=true
export DISABLE_MAGIC_FUNCTIONS=true

# ls com cores
# if [ -x /usr/bin/dircolors ]; then
#     if [ -r ~/.dircolors ]; then
#         eval "$(dircolors -b ~/.dircolors)"
#     else
#         eval "$(dircolors -b)"
#     fi
# fi

if which dircolors > /dev/null 2>&1; then
  eval $(dircolors ${ZDOTDIR:-${HOME}}/.dircolors)
fi

##############################################################################
# History
##############################################################################
export HISTFILE=~/.zsh_history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export SAVEHIST=1000000000
# export HISTTIMEFORMAT="[%F %T] "
# export HIST_STAMPS="yyyy-mm-dd"

HISTCONTROL=ignoredups
setopt HISTIGNORESPACE
unsetopt EXTENDED_HISTORY
setopt BANG_HIST
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt HIST_REDUCE_BLANKS

setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt IGNORE_EOF
setopt PUSHD_IGNORE_DUPS # Do not store duplicates in the stack.
setopt PUSHD_SILENT      # Do not print the directory stack after pushd or popd.
# setopt AUTO_LIST
# setopt AUTO_MENU
setopt LIST_AMBIGUOUS
setopt EXTENDED_GLOB
setopt NO_BEEP
setopt GLOB_COMPLETE
setopt MENU_COMPLETE
setopt COMPLETE_ALIASES
setopt CASE_PATHS
setopt COMPLETE_IN_WORD
setopt PROMPT_SUBST
setopt NO_HUP
setopt NO_NOMATCH

##############################################################################
# KeyMappings
##############################################################################
bindkey -e

bindkey -e '^o' autosuggest-accept
bindkey -e '^l' forward-char
bindkey -e '^e' forward-word
bindkey -e '^h' backward-char
bindkey -e '^b' backward-word
bindkey -e '^d' delete-char
bindkey -e '^0' beginning-of-line
bindkey -e '^;' end-of-line
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

bindkey -r ^M accept-search
# bindkey -e '^Y' accept-search
bindkey -r ^Y accept-line

bindkey '^[[Z' reverse-menu-complete
bindkey '^R'   fzf-history-widget

autoload -z edit-command-line
zle -N edit-command-line
bindkey -e '^x' edit-command-line

autoload -U modify-current-argument
# Esc + s
_quote-previous-word-in-single() {
    modify-current-argument '${(qq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
bindkey '^z' _quote-previous-word-in-single
zle -N _quote-previous-word-in-single

## insert sudo {{{
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    zle end-of-line                 # move cursor to end-of-line
}
zle -N sudo-command-line
bindkey "\e\e" sudo-command-line

user-complete(){
    case $BUFFER in
        "" )                       # 空行填入 "cd "
            BUFFER="cd "
            zle end-of-line
            zle expand-or-complete
            ;;
        * )
            zle expand-or-complete
            ;;
    esac
}
zle -N user-complete
bindkey "\t" user-complete

##############################################################################
# Fzf
##############################################################################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source <(fzf --zsh)
set rtp+= "$HOMEBREW"/fzf
export BAT_THEME="gruvbox-dark"
export FZF_DEFAULT_OPTS="--height 30 --ansi --layout=reverse --preview 'echo {} | batcat --color=always --language=bash --style=plain' --preview-window down:7:wrap"
export FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build} --hidden --type file --no-ignore-vcs"
export FZF_ALT_C_COMMAND='fd --follow --type d --exclude "Library/" --exclude "Music/"'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_R_OPTS="--no-preview"

##############################################################################
# Misc
##############################################################################

# exit proccess
# if [ -t 0 ]; then
#     stty intr \^k
# fi

# stty intr \^q

# stty -ixon -ixoff
stty intr "^K"
# stty intr \^k

stty intr    "^q"          2> /dev/null

autoload -U compinit && compinit
autoload -U promptinit && promptinit
autoload -U add-zsh-hook

##############################################################################
# Packages
##############################################################################
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# ngrok
if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)"
fi

##############################################################################
# Path
##############################################################################
# npm global
export NPM_PACKAGES=${HOME}/.npm-global
export NPM_CONFIG_PREFIX=${HOME}/.npm-global
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$NPM_PACKAGES/bin:$PATH"
MANPATH="$NPM_PACKAGES/share/man:$MANPATH"

# Created by `pipx`
export PATH="$PATH:/Users/arthurgehrke/.local/bin"
export PYENV_ROOT="$HOME/.pyenv"
export PATH=$(pyenv root)/shims:$PATH

export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

export GOPATH=$HOME/go
export PATH=$PATH:/Users/arthurgehrke/go/bin

# rbenv (Ruby)
if command -v rbenv &>/dev/null; then
    export RBENV_ROOT=~/.rbenv
    eval "$(rbenv init -)"
fi

# jenv (Java)
if command -v jenv &>/dev/null; then
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init - --no-rehash)"
fi

# Composer (PHP)
if command -v composer &>/dev/null; then
    export PATH="$HOME/.composer/vendor/bin:$PATH"
fi

# nodenv (Node.js)
if command -v nodenv &>/dev/null; then
    export PATH="$HOME/.nodenv/bin:$PATH"
    eval "$(nodenv init -)"
fi

# rye (Python)
if command -v pyenv &>/dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi


export PATH="$HOME/.cargo/bin:$PATH"
. "$HOME/.cargo/env"


source /Users/arthurgehrke/.config/broot/launcher/bash/br


function upper() {
    echo "$*" | tr '[:lower:]' '[:upper:]'
}

function lower() {
    echo "$*" | tr '[:upper:]' '[:lower:]'
}

function capitalize() {
    echo "$*" | tr '[:upper:]' '[:lower:]' | sed 's/^\w\|\s\w/\U&/g'
}

function cf() {
    cmd=$(complete-fzf --alias="$(alias)" --command="$*")
    _confirm_run "$cmd"
}

function cr() {
    cmd=`history | sed 's/\s\+[0-9]\+\s\+//g' | sort -rn | awk '!x[$0]++' | fzf --layout=reverse --prompt='Cmd> '`
    _confirm_run "$cmd"
}


if [ ! -z "$MY_TERMINAL" ]; then
    if [ "$MY_TERMINAL" != "alacritty"  ] ;then
        stty -ixon
    fi
fi

