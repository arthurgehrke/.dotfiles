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

source $HOME/.themes/zsh/circular/.p10k.zsh 
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
# Configs
##############################################################################
DISABLE_AUTO_UPDATE="true"
EDITOR=nvim

autoload -U colors
autoload -U compinit

setopt no_nomatch                # Don't error when there's nothing to glob, leave it unchanged
##############################################################################
# History
##############################################################################
HISTFILE=$HOME/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
DIRSTACKSIZE=8

setopt auto_pushd
setopt append_history            
setopt interactivecomments       # Enable comments in interactive mode (useful)
setopt extended_glob             # More powerful glob features
setopt append_history            # Append to history on exit, don't overwrite it.
setopt extended_history          # Save timestamps with history
setopt hist_no_store             # Don't store history commands
setopt hist_save_no_dups         # Don't save duplicate history entries
setopt hist_ignore_all_dups      # Ignore old command duplicates (in current session)
setopt pushdsilent

##############################################################################
# Completions
##############################################################################

##############################################################################
# KeyMappings
##############################################################################

##############################################################################
# Bindings
##############################################################################
_copy-using-win32yank() {
  if ((REGION_ACTIVE)) then
    zle copy-region-as-kill
    printf -rn -- $CUTBUFFER | win32yank.exe -i < "${1:-/dev/stdin}"
    ((REGION_ACTIVE = 0))
  fi
}

zle -N _copy-using-win32yank
bindkey '^C' _copy-using-win32yank

_cut-using-win32yank() {
  if ((REGION_ACTIVE)) then
     zle copy-region-as-kill
     printf -rn -- $CUTBUFFER | win32yank.exe -i < "${1:-/dev/stdin}"
     zle kill-region
  fi
}

zle -N _cut-using-win32yank
bindkey '^X' _cut-using-win32yank 

_paste-copy-using-win32yank() {
	if ((REGION_ACTIVE)); then
    zle kill-region
  fi
  LBUFFER+="$(win32yank.exe -o)"
}

zle -N _paste-copy-using-win32yank
bindkey '^V' _paste-copy-using-win32yank 

exit_zsh() { exit }

zle -N exit_zsh
bindkey '^W' exit_zsh

##############################################################################
# Various
##############################################################################
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
