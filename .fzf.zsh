#!/usr/bin/env zsh
# Setup fzf
# ---------
export RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case  --hidden --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,~/dotfiles/**} --type file"

source <(fzf --zsh)
set rtp+= "$HOMEBREW"/fzf
export BAT_THEME="gruvbox-dark"
export FZF_DEFAULT_OPTS="--height 30 --ansi --layout=reverse --preview 'echo {} | batcat --color=always --language=bash --style=plain' --preview-window down:7:wrap"
export FZF_DEFAULT_COMMAND="fd --hidden --follow --type file --no-ignore-vcs --exclude {.git,.idea,.vscode,.sass-cache,node_modules,build,Library,Music,Movies,Applications,.DS_Store,.cache,.cargo,.npm,.local,.bin,.Trash,.pyenv,.rbenv,.redis-insight,.rustup,.stack,.julia,.matplotlib,.stack,Alfred,go,.config/nvim/undodir}"
export FZF_ALT_C_COMMAND='fd --follow --type d --exclude "Library/" --exclude "Music/"'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_R_OPTS="--no-preview"

