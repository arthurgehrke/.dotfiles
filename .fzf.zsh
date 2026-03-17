#!/usr/bin/env zsh

export RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case --hidden --type file"
source <(fzf --zsh)
set rtp+= "$HOMEBREW"/fzf
export BAT_THEME="gruvbox-dark"
export FZF_DEFAULT_OPTS='--height 30 --ansi --layout=reverse --preview "bat --style=numbers --color=always --line-range :200 {}" --preview-window=down:7:wrap'
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs --color=always'
export FZF_ALT_C_COMMAND='rg --files --hidden --follow --no-ignore-vcs --color=always | xargs -n1 dirname | sort -u'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_R_OPTS="--no-preview"
