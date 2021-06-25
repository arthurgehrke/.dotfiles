#!/usr/bin/env zsh

##############################################################################
# Source's
##############################################################################

export DOTFILES=$HOME/dotfiles
export INCLUDES=$HOME/.local/share/dotfiles

source $INCLUDES/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $INCLUDES/zsh-completions/zsh-completions.plugin.zsh
source $INCLUDES/zsh-history-substring-search/zsh-history-substring-search.zsh
source $INCLUDES/zsh-autosuggestions/zsh-autosuggestions.zsh 

source $INCLUDES/powerlevel10k/powerlevel10k.zsh-theme

source $HOME/.p10k.zsh 
source $HOME/.fzf.zsh
source $INCLUDES/nvm/nvm.sh
source $INCLUDES/z/z.sh

source $HOME/.shell_aliases
source $HOME/.shell_scripts

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

##############################################################################
# History
##############################################################################

HISTFILE=$HOME/.zsh_history
HISTSIZE=1024
SAVEHIST=1024

zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

autoload -U compinit && compinit
zmodload -i zsh/complist

# history
setopt append_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
setopt hist_expire_dups_first
setopt share_history
setopt inc_append_history
setopt extended_history

# completion
setopt always_to_end
setopt complete_in_word
setopt auto_list
setopt auto_remove_slash 

# various
setopt auto_cd
# setopt prompt_subst

##############################################################################
# Bindings
##############################################################################

bindkey '^$' beginning-of-line
bindkey '^e' end-of-line
bindkey '^k' up-line-or-search
bindkey '^j' down-line-or-search

##############################################################################
# Various
##############################################################################

DISABLE_AUTO_UPDATE="true"

# Share a same ssh-agent across sessions.
if [ -f ~/.ssh-agent.generated.env ]; then
  . ~/.ssh-agent.generated.env >/dev/null
  # If the $SSH_AGENT_PID is occupied by other process, we need to manually
  # remove ~/.ssh-agent.generated.env.
  if ! kill -0 $SSH_AGENT_PID &>/dev/null; then
    # Stale ssh-agent env file found. Spawn a new ssh-agent.
    eval `ssh-agent | tee ~/.ssh-agent.generated.env`
    ssh-add
  fi
else
  eval `ssh-agent | tee ~/.ssh-agent.generated.env`
  ssh-add
fi

# add custom terminal title
function settitle() {
  export PS1="\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n$ "
  echo -ne "\e]0;$1\a"
}

settitle "MinTTY - $(pwd)@$HOST"

