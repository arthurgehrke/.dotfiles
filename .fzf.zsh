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

export FZF_DEFAULT_OPTS="
--ansi --preview-window 'right:60%' --preview 'bat --color=always --theme='gruvbox-dark' --style=header,grid --line-range :300 {}' --bind ctrl-n:down,ctrl-p:up
--height 50% 
--layout=reverse 
"

bat() {
    BAT_PAGER='less-rs /dev/stdin' command bat --terminal-width="$(($COLUMNS - 4))" "$@"
    return $?
}
