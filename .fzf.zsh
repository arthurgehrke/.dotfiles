# Setup fzf
# ---------
FZF_COMMON_OPTIONS="
  --bind='?:toggle-preview'
  --bind='ctrl-u:preview-page-up'
  --bind='ctrl-d:preview-page-down'
  --preview-window 'right:60%:hidden:wrap'
  --preview '([[ -d {} ]] && tree -C {}) || ([[ -f {} ]] && bat --style=full --color=always {}) || echo {}'"

command -v fd > /dev/null && export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
command -v bat > /dev/null && command -v tree > /dev/null && export FZF_DEFAULT_OPTS="$FZF_COMMON_OPTIONS"
command -v fd > /dev/null && export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
command -v fd > /dev/null && export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden --follow --exclude .git'
