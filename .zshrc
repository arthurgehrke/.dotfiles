##############################################################################
# Source's
##############################################################################
export DOTFILES=$HOME/dotfiles
export INCLUDES=$HOME/.local/share/dotfiles

source $INCLUDES/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $INCLUDES/zsh-completions/zsh-completions.plugin.zsh
source $INCLUDES/zsh-history-substring-search/zsh-history-substring-search.zsh
source $INCLUDES/zsh-autosuggestions/zsh-autosuggestions.zsh
source $INCLUDES/z/z.sh
source $INCLUDES/powerlevel10k/powerlevel10k.zsh-theme
source $INCLUDES/powerlevel10k/powerlevel10k.zsh-theme

source $HOME/.themes/zsh/.p10k.zsh
source $HOME/.shell_aliases
source $HOME/.shell_scripts
source $HOME/.fzf.zsh
source $HOME/.zprofile

zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

autoload -U compinit && compinit -d $HOME/.zsh/compdump
zmodload -i zsh/complist
zmodload -i zsh/zle

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
# Configs
##############################################################################
export EDITOR='nvim'

##############################################################################
# History
##############################################################################
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt APPENDHISTORY     #Append history to the history file (no overwriting)
setopt INCAPPENDHISTORY  #Immediately append to the history file, not just when a term is killed

##############################################################################
# Navigation
##############################################################################
setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.

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
## zsh-autosuggestions
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty bracketed-paste accept-line push-line-or-edit)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true

bindkey '^r' history-incremental-search-backward
bindkey '^o' autosuggest-accept
bindkey '^b' backward-word
bindkey '^f' forward-word
bindkey '^h' beginning-of-line
bindkey '^l' end-of-line
bindkey '^i' expand-or-complete

## history-substring-search
# Control-P/N keys
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down
bindkey '^r' history-incremental-search-backward 

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
# java sdk
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

export PATH="/Users/arthurrodrigues/.local/bin:$PATH"

eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"

##############################################################################
# Various
##############################################################################
# kubernetes
export KUBECONFIG=.kubeconfig:$HOME/.kube/config

##############################################################################
# Iterm2
##############################################################################
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

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

