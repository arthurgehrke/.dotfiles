alias config='/usr/bin/git --git-dir=/home/arthurgehrke/dotfiles/.git --work-tree=/home/arthurgehrke'

# dir commands
alias ll='ls -alF'
alias l='ls -CF'
# List all files colorized in long format
alias ll='ls -lh'
# List all files colorized in long format, including dot files
alias la="ls -lha"
# List only directories
alias lsd='ls -l | grep "^d"'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias grep='grep --color'

# git commands
alias gs='git status'
alias ga='git add'
alias ga-file='git add'

alias zshconfig='nvim ~/.zshrc'
alias zshsource='source ~/.zshrc'

alias alder='alder --exclude='"'"'.git|node_modules'"'"''
alias tree_dir='tree -I '"''"'node_modules|.git'"''"''
