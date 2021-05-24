alias config='/usr/bin/git --git-dir=/home/arthurgehrke/dotfiles/.git --work-tree=/home/arthurgehrke'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias grep='grep --color'

alias zshconfig='nvim ~/.zshrc'
alias zshsource='source ~/.zshrc'

# Attaches tmux to the last session; creates a new session with 3 window if none exists.
alias tl='tmux attach || tmux new-session\; new-window\; new-window'

alias attach_ide='~/attach_ide.sh'

alias alder='alder --exclude='"'"'.git|node_modules'"'"''
alias tree_dir='tree -I '""'node_modules|.git'""''
