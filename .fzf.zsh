#!/usr/bin/env bash
# Setup fzf
# ---------
# Key bindings
# ------------
export RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build} --hidden --type file"
