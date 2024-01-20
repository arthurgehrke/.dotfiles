#!/usr/bin/env bash
# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# # Auto-completion
# # ---------------
source "/opt/homebrew/opt/fzf/shell/completion.zsh"

# # Key bindings
# # ------------
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

# Two-phase filtering with Ripgrep and fzf
#
# 1. Search for text in files using Ripgrep
# 2. Interactively restart Ripgrep with reload action
#    * Press alt-enter to switch to fzf-only filtering
# 3. Open the file in Vim
export RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build} --hidden --type file"
