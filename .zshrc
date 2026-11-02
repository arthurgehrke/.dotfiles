if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

BREW_PREFIX="/opt/homebrew"

if type brew &>/dev/null; then
  export PATH="$BREW_PREFIX/bin:$PATH"
  export HOMEBREW_SANDBOX_DENY_PATHS="/Users/arthurgehrke/Applications (Parallels)"
  export HOMEBREW_BUNDLE_FILE_GLOBAL="$HOME"/Brewfile
fi

setopt EXTENDED_GLOB
typeset -U path PATH
export LS_COLORS="$LS_COLORS:ow=:tw=:"
autoload -Uz compinit

if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

source "$HOME"/.zaliases
source "$HOME"/.zfunctions.zsh
[ -f ~/.zsecrets ] && source ~/.zsecrets

source "$BREW_PREFIX"/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source "$BREW_PREFIX"/share/powerlevel10k/powerlevel10k.zsh-theme
source "$BREW_PREFIX"/share/zsh-history-substring-search/zsh-history-substring-search.zsh
FAST_THEME_NAME="$HOME/.themes/zsh-fast-syntax-highlighting/default.ini"
source "$BREW_PREFIX"/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source "$HOME"/.themes/zsh/simple-theme/.p10k.zsh

if [ -f "$HOME/.zsh/plugins/zsh-directory-history/zsh-directory-history.plugin.zsh" ]; then
  source "$HOME/.zsh/plugins/zsh-directory-history/zsh-directory-history.plugin.zsh"
fi

unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND
unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND

export LANG=en_US.UTF-8
export VISUAL=nvim
export EDITOR=nvim
export PAGER=less

export NVIM_NOTTYFAST=1

export DISABLE_AUTO_TITLE=true
export DISABLE_MAGIC_FUNCTIONS=true

export HISTFILE=~/.zsh_history
export HISTSIZE=500000000
export SAVEHIST=500000000
export HISTFILESIZE=50000000

HISTCONTROL=ignoredups
setopt BANG_HIST
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_VERIFY
setopt HIST_REDUCE_BLANKS
setopt INTERACTIVECOMMENTS
setopt IGNORE_EOF
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt AUTO_PUSHD
setopt AUTOPARAMSLASH
setopt LIST_AMBIGUOUS
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

zmodload zsh/complist

zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list \
  'm:{[:lower:]}={[:upper:]}'
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' sort false
zstyle ':completion:*' select-prompt ''
zstyle ':completion:*' list-prompt ''

autoload -U add-zsh-hook
autoload -Uz edit-command-line
autoload -Uz modify-current-argument
autoload -Uz history-substring-search-up history-substring-search-down

bindkey -e

bindkey -e '^l' forward-char
bindkey -e '^h' backward-char
bindkey -e '^e' forward-word
bindkey -e '^b' backward-word
bindkey -e '^d' delete-char
bindkey -e '^a' beginning-of-line
bindkey -e '^f' end-of-line
bindkey -e '^g' backward-kill-word
bindkey -e '^I' expand-or-complete-prefix

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

bindkey -e '^y' accept-search
bindkey -e '^o' autosuggest-accept

bindkey '^M' accept-line

bindkey '^[[Z' reverse-menu-complete
bindkey '^R' fzf-history-widget

zle -N edit-command-line
bindkey -e '^x' edit-command-line

bindkey -e '^j' history-substring-search-up
bindkey -e '^k' history-substring-search-down

_quote-previous-word-in-single() {
  modify-current-argument '${(qq)${(Q)ARG}}'
  zle vi-forward-blank-word
}
bindkey '^z' _quote-previous-word-in-single
zle -N _quote-previous-word-in-single

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

export NPM_PACKAGES=${HOME}/.npm-global
export NPM_CONFIG_PREFIX=${HOME}/.npm-global
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$NPM_PACKAGES/bin:$PATH"
MANPATH="$NPM_PACKAGES/share/man:$MANPATH"

if command -v pipx &>/dev/null; then
  export PIPX_HOME="$HOME/.local"
  export PATH="$HOME/.local/bin:$PATH"
  export PATH="$PIPX_HOME/bin:$PATH"
fi

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$HOME/.local/bin:$PATH

export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

if command -v rbenv &>/dev/null; then
  export RBENV_ROOT="$HOME/.rbenv"
  export PATH="$RBENV_ROOT/bin:$PATH"
  eval "$(rbenv init - --no-rehash)"
fi

if command -v composer &>/dev/null; then
  export PATH="$HOME/.composer/vendor/bin:$PATH"
fi

if command -v nodenv &>/dev/null; then
  export PATH="$HOME/.nodenv/bin:$PATH"
  eval "$(nodenv init -)"
fi

if command -v pyenv &>/dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  export PATH=$(pyenv root)/shims:$PATH
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

export PIPENV_PYTHON="$PYENV_ROOT/shims/python"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH" || true

if [ -d "/opt/homebrew/opt/rustup/bin" ]; then
  export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
fi

if [ -d "$HOME/Library/Android/sdk" ]; then
  export ANDROID_HOME="$HOME/Library/Android/sdk"
  export PATH="$PATH:$ANDROID_HOME/platform-tools"
  export PATH="$PATH:$ANDROID_HOME/build-tools/36.0.0"
fi

export PATH="/Users/arthurgehrke/.local/bin:$PATH"

export PATH="/Users/arthurgehrke/osmedeus-base/external-binaries:$PATH"
export PATH="$HOME/go/bin:$PATH"
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="${PATH:+$PATH:}$HOME/.local/bin" ;; esac
