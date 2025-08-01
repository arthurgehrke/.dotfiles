# Hopefully this loads powerlevel10k theme faster

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

##############################################################################
# Homebrew Configurações
##############################################################################
if type brew &>/dev/null; then
  export PATH="$(brew --prefix)/bin:$PATH"
  # export HOMEBREW_NO_AUTO_UPDATE=1
  export HOMEBREW_BUNDLE_FILE_GLOBAL="$HOME"/Brewfile
fi


##############################################################################
# Sourcing e Plugins
##############################################################################
autoload -Uz compinit
compinit

source "$HOME"/.zaliases
source "$HOME"/.zprofile
source "$HOME"/.zfunctions.zsh
source "$HOME"/.themes/zsh/minimalist/.p10k.zsh

source "$(brew --prefix)"/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source "$(brew --prefix)"/share/powerlevel10k/powerlevel10k.zsh-theme
source "$(brew --prefix)"/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source "$(brew --prefix)"/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

##############################################################################
# Prompt & Completion
##############################################################################
unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND
unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]=fg=#ebdbb2,bold
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=#fb4934
# ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=#fb4934,standout
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=#fb4934
ZSH_HIGHLIGHT_STYLES[alias]=fg=#fe8019,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=#b8bb26,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=#d3869b,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=#83a598,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=#fabd2f,bold
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=#fabd2f,bold
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=#b8bb26,bold
ZSH_HIGHLIGHT_STYLES[path]=fg=#8ec07c,underline
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=fg=#d79921,underline
ZSH_HIGHLIGHT_STYLES[path_prefix]=fg=#b16286,underline
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=fg=#d79921,underline
ZSH_HIGHLIGHT_STYLES[globbing]=fg=#fabd2f,bold
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=#fabd2f,bold,underline
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=#fabd2f,bold
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=#d79921,bold
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=fg=#8ec07c,bold
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=#d3869b,bold
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=#b16286,bold
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]=fg=#cc241d,bold
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=#fabd2f,bold
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=#fe8019,bold
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=#fabd2f,bold
ZSH_HIGHLIGHT_STYLES[comment]=fg=#928374,bold
ZSH_HIGHLIGHT_STYLES[redirection]=fg=#fe8019,bold
ZSH_HIGHLIGHT_STYLES[assign]=fg=#b16286,bold

##############################################################################
# Configurações Gerais
##############################################################################
export LANG=en_US.UTF-8
export EDITOR='nvim'
export VISUAL="$EDITOR"
export PAGER=less

# if [[ "$TERM" != "xterm-256color" ]]; then
#   export TERM="xterm-256color"
# fi

export DISABLE_AUTO_TITLE=true
export DISABLE_MAGIC_FUNCTIONS=true

# ls com cores
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
export HISTSIZE=500000
export SAVEHIST=500000
export HISTFILESIZE=500000
# export HISTTIMEFORMAT="[%F %T] "
# export HIST_STAMPS="yyyy-mm-dd"

HISTCONTROL=ignoredups
setopt HISTIGNORESPACE
setopt BANG_HIST
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt HIST_REDUCE_BLANKS
setopt INTERACTIVECOMMENTS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt IGNORE_EOF
setopt PUSHD_IGNORE_DUPS # Do not store duplicates in the stack.
setopt PUSHD_SILENT      # Do not print the directory stack after pushd or popd.
setopt AUTO_PUSHD        # Make cd push the old directory onto the directory stack.
setopt AUTOPARAMSLASH    # tab completing directory appends a slash
setopt LIST_AMBIGUOUS
setopt EXTENDED_GLOB # Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation, etc. (An initial unquoted ‘~’ always produces named directory expansion.)
setopt ALWAYS_TO_END   
setopt NO_BEEP
setopt COMPLETE_ALIASES
setopt CASE_PATHS
setopt COMPLETE_IN_WORD
setopt PROMPT_SUBST
setopt NO_HUP
setopt NO_NOMATCH

unsetopt GLOB_COMPLETE
unsetopt MENU_COMPLETE
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
# zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' '+l:|=* r:|=*'
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache

##############################################################################
# KeyMappings
##############################################################################
autoload -U promptinit && promptinit
autoload -U add-zsh-hook
autoload -Uz edit-command-line
autoload -Uz modify-current-argument
autoload -Uz history-substring-search-up history-substring-search-down

bindkey -e

# navigation
bindkey -e '^l' forward-char
bindkey -e '^h' backward-char
bindkey -e '^e' forward-word
bindkey -e '^b' backward-word
bindkey -e '^d' delete-char
bindkey -e '^a' beginning-of-line
bindkey -e '^f' end-of-line
bindkey -e '^g' backward-kill-word
bindkey -e '^I' expand-or-complete-prefix

# history
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# Autossugestões
bindkey -e '^y' accept-search
bindkey -e '^o' autosuggest-accept

bindkey -r ^M accept-search

bindkey '^[[Z' reverse-menu-complete
# bindkey '^R' fzf-history-widget
bindkey '^R' atuin-search

zle -N edit-command-line
bindkey -e '^x' edit-command-line

# Esc + s
_quote-previous-word-in-single() {
  modify-current-argument '${(qq)${(Q)ARG}}'
  zle vi-forward-blank-word
}
bindkey '^z' _quote-previous-word-in-single
zle -N _quote-previous-word-in-single

##############################################################################
# Fzf
##############################################################################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

##############################################################################
# Misc
##############################################################################

# if [ -t 0 ]; then
#   stty sane

#   tty intr \^k
#   # stty intr '^k'
# else
#   stty sane
#   tty intr \^k
#   # stty intr   '^k'
# fi

# function set_interrupt_key {
#     stty intr "\^k"
# }

# add-zsh-hook precmd set_interrupt_key

# if [[ $- == *i* ]]; then
#     stty intr   '^k'
# fi

# exit with C-k
if [[ $- == *i* ]]; then
  stty -ixon <"$TTY" >"$TTY"
  function set_interrupt_key {
    if [ -t 0 ]; then
      stty intr "^k"
    fi
  }
  add-zsh-hook precmd set_interrupt_key
else
  stty intr "^k" 2>/dev/null || true
fi

if [ ! -z "$MY_TERMINAL" ]; then
  if [ "$MY_TERMINAL" != "alacritty" ]; then
    stty -ixon
  fi
fi

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

# Pipx
if command -v pipx &>/dev/null; then
  export PIPX_HOME="$HOME/.local"
  export PATH="$PIPX_HOME/bin:$PATH"
fi

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH:/bin

export LDFLAGS="-L/opt/homebrew/opt/openssl/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl/lib/pkgconfig"
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# rbenv (Ruby)
# if command -v rbenv &>/dev/null; then
#   # export RBENV_ROOT=~/.rbenv
#   eval "$(rbenv init -)"
#   export PATH=$HOME/.rbenv/shims:$PATH
#   export RBENV_ROOT="$(brew --prefix rbenv)"
#   export GEM_HOME="$(brew --prefix)/opt/gems"
#   export GEM_PATH="$(brew --prefix)/opt/gems"
# fi

# jenv (Java)
# export JAVA_HOME="/opt/homebrew/opt/openjdk@11/"
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
if command -v jenv &>/dev/null; then
  export PATH="$HOME/.jenv/bin:$PATH"
  # eval "$(jenv init - --no-rehash)"
  eval "$(jenv init -)"
fi

# Composer (PHP)
if command -v composer &>/dev/null; then
  export PATH="$HOME/.composer/vendor/bin:$PATH"
fi

export VIRTUAL_ENV_DISABLE_PROMPT=1                                             # My personal prompt has it's own display for Python virtualenvs.

if command -v pipenv &>/dev/null; then
  export PIPENV_DONT_LOAD_ENV=1                                                   # Direnv manages our '.env', tell Pipenv not to load it.
  export PIPENV_IGNORE_VIRTUALENVS=1                                              # Don't try and detect running in an existing Python virtualenv.
  export PIPENV_VENV_IN_PROJECT=1                                                 # Place Pipenv virtualenvs in '.venv' directories.
  export PIP_REQUIRE_VIRTUALENV=1                                                 # Require that Pip is run inside a virtualenv.
 eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"
fi

# nodenv (Node.js)
if command -v nodenv &>/dev/null; then
  export PATH="$HOME/.nodenv/bin:$PATH"
  eval "$(nodenv init -)"
fi

if command -v pyenv &>/dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH=$(pyenv root)/shims:$PATH
  # [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# Rustup (via Homebrew)
if [ -d "/opt/homebrew/opt/rustup/bin" ]; then
  export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
fi

if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

# Cargo (Rust)
if command -v cargo &>/dev/null; then
  export CARGO_HOME="$HOME/.cargo"
  export PATH="$CARGO_HOME/bin:$PATH"
  
  # Verifica se o arquivo de ambiente do Cargo existe antes de carregá-lo
  if [ -f "$CARGO_HOME/env" ]; then
    source "$CARGO_HOME/env"
  fi
fi

# chruby (Ruby)
if [ -f "/opt/homebrew/opt/chruby/share/chruby/chruby.sh" ]; then
  source "/opt/homebrew/opt/chruby/share/chruby/chruby.sh"
  source "/opt/homebrew/opt/chruby/share/chruby/auto.sh"

  # Definir versão padrão do Ruby, se necessário
  if command -v ruby &>/dev/null; then
    chruby ruby-3.4.2
  fi
fi
