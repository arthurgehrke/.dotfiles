# Setup fzf
# ---------
if [[ ! "$PATH" == */home/arthurgehrke/.local/share/dotfiles/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/arthurgehrke/.local/share/dotfiles/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/arthurgehrke/.local/share/dotfiles/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/arthurgehrke/.local/share/dotfiles/fzf/shell/key-bindings.zsh"

export FZF_DEFAULT_COMMAND='rg --files --hidden'  # Respect .gitignore, show hidden files
export FZF_DEFAULT_OPTS='--bind ctrl-l:select-all,ctrl-n:toggle+up,ctrl-f:preview-page-down,ctrl-b:preview-page-up,::abort'
export FZF_COMPLETION_OPTS='-m'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"    # Respect .gitignore for ^t
# install bat
export FZF_CTRL_T_OPTS="--preview 'bat --color \"always\" {}'"
export FZF_TMUX_HEIGHT=70%

#export FZF_DEFAULT_COMMAND="fd --type f --hidden"
#export FZF_CTRL_T_COMMAND="fd --type f --hidden"
#export FZF_ALT_C_COMMAND="fd --type d --hidden"
#export FZF_DEFAULT_OPTS='--color fg:-1,bg:-1,hl:33,fg+:235,bg+:-1,hl+:33 --color info:136,prompt:136,pointer:230,marker:230,spinner:136'
