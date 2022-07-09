# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/arthurrodrigues/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/arthurrodrigues/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/arthurrodrigues/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/arthurrodrigues/.fzf/shell/key-bindings.zsh"
