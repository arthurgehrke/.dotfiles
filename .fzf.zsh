# Setup fzf
# ---------
if [[ ! "$PATH" == */home/arthurgehrke/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/arthurgehrke/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/arthurgehrke/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/arthurgehrke/.fzf/shell/key-bindings.zsh"
