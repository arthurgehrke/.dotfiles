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

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --extended -i -m'
export FZF_DEFAULT_COMMAND="fd --type file --follow --hidden --exclude 'Library' --exclude 'Music' --exclude 'Pictures'"
export FZF_ALT_C_COMMAND='fd --follow --type d --exclude "Library/" --exclude "Music/"'

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export BAT_THEME="gruvbox-dark"
export FZF_CTRL_T_COMMAND='find *~Library~Applications~qmk_firmware~Creative\ Cloud\ Files~Pictures notes/  2>/dev/null'

export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

export BAT_THEME="gruvbox-dark"
