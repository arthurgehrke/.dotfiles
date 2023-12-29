# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/arthurrodrigues/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/arthurrodrigues/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/Users/arthurrodrigues/.fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/Users/arthurrodrigues/.fzf/shell/key-bindings.zsh"
