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

# easier to read disk human-readable sizes
alias df='df -h'                          
# show sizes in MB
alias free='free -m'                      

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'
# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'


alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias grep='grep --color=auto'

# git commands
alias gs='git status'
alias ga='git add'
alias ga-file='git add'

alias zshconfig='nvim ~/.zshrc'
alias zshsource='source ~/.zshrc'

alias alder='alder --exclude='"'"'.git|node_modules'"'"''
