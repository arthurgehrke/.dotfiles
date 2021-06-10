if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [ -e $HOME/.bash_aliases ]; then
	source $HOME/.bash_aliases
fi

if [ -e $HOME/.bash_scripts ]; then
 	source $HOME/.bash_scripts
fi

export NVM_DIR="$HOME/.nvm"
[ -s $NVM_DIR/nvm.sh"" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export ZSH="/home/arthurgehrke/.oh-my-zsh"

export FZF_BASE="$HOME/.fzf"

plugins=(
  git 
  nvm 
  z
  fzf
  zsh-syntax-highlighting
  zsh-autosuggestions
)

ZSH_THEME="powerlevel10k/powerlevel10k"
source $ZSH/oh-my-zsh.sh

DISABLE_AUTO_UPDATE="true"

autoload -U compinit && compinit
zstyle ':completion:*' menu select

bindkey '^$' beginning-of-line
bindkey '^e' end-of-line

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
