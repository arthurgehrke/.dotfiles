#!/usr/bin/env zsh
# shellcheck shell=bash

function irg() {
  local file
  local line
  local RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case"
  local INITIAL_QUERY="${*:-}"

  read -r file line <<<"$(
    FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY")" \
      fzf --ansi \
          --disabled \
          --query "$INITIAL_QUERY" \
          --color "hl:-1:underline,hl+:-1:underline:reverse" \
          --header='Press ? to toggle preview / CTRL-R for ripgrep / CTRL-F for fzf' \
          --bind '?:toggle-preview' \
          --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
          --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
          --bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
          --bind "start:unbind(ctrl-r)" \
          --prompt '1. ripgrep> ' \
          --height 40% \
          --layout=reverse \
          --delimiter : \
          --preview-window 'up,70%,border-bottom,~2,+{2}+2/2' \
          --preview 'bat --style=full --color=always --highlight-line {2} {1}' | awk -F: '{print $1, $2}'
  )"

  if [[ -n "$file" ]]; then
    nvim "$file" "+$line"
  fi
}

function fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!"
    return 1
  fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

function findBigFiles() {
  find ~/Documents/ -size +100M -ls | sort -k7nr
}

function geoip() {
  curl ipinfo.io/"$1"
}

function upper() {
  echo "$*" | tr '[:lower:]' '[:upper:]'
}

function lower() {
  echo "$*" | tr '[:upper:]' '[:lower:]'
}

function capitalize() {
  echo "$*" | tr '[:upper:]' '[:lower:]' | sed 's/^\w\|\s\w/\U&/g'
}

function cf() {
  cmd=$(complete-fzf --alias="$(alias)" --command="$*")
  _confirm_run "$cmd"
}

function cr() {
  cmd=$(history | sed 's/\s\+[0-9]\+\s\+//g' | sort -rn | awk '!x[$0]++' | fzf --layout=reverse --prompt='Cmd> ')
  _confirm_run "$cmd"
}

## FZF FUNCTIONS ##

# fo [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fo() {
  local files
  IFS=$'\n' files=("$(fzf-tmux --query="$1" --multi --select-1 --exit-0)")
  [[ -n "$files" ]] && "${EDITOR:-vim}" "${files[@]}"
}

# fh [FUZZY PATTERN] - Search in command history
fh() {
  print -z "$( ([ "$ZSH_NAME" != "" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')"
}

# fbr [FUZZY PATTERN] - Checkout specified branch
# Include remote branches, sorted by most recent commit and limited to 30
fgb() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
  fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout "$(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")"
}

# tm [SESSION_NAME | FUZZY PATTERN] - delete tmux session
# Running `tm` will let you fuzzy-find a session mame to delete
# Passing an argument to `ftm` will delete that session if it exists
ftmk() {
  if [ "$1" ]; then
    tmux kill-session -t "$1"; return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux kill-session -t "$session" || echo "No session found to delete."
}

# fuzzy grep via rg and open in vim with line number
fgr() {
  local file
  local line

  read -r file line <<<"$(rg --no-heading --line-number "$@" | fzf -0 -1 | awk -F: '{print $1, $2}')"

  if [[ -n $file ]]
  then
    vim "$file" +"$line"
  fi
}

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fzstash() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
    --expect=ctrl-d,ctrl-b);
  do
    mapfile -t out <<< "$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff "$sha"
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" "$sha"
      break;
    else
      git stash show -p "$sha"
    fi
  done
}

pyenv-brew-relink() {
    rm -f "$HOME/.pyenv/versions/*-brew"
    for i in "$(brew --cellar)"/python* ; do
        ln -s -f "$p" "$HOME/.pyenv/versions/${i##/*/}-brew"
    done
    pyenv rehash
}

fg() {
    rg --color=always --line-number --no-heading --smart-case "${*:-}" -g '!{**/node_modules/*,**/.git/*,**lock,**/zig-cache/*}' | \
    fzf \
    --ansi \
    --delimiter : \
    --prompt="Live Grep ▶ " \
    --preview "bat --color=always --style=plain {1} --highlight-line {2}" \
    --preview-window "right:60%:wrap" \
    --bind "enter:execute:(${EDITOR:-nvim} {1} +{2})"
}

ff() {
    fdfind --type f --hidden --exclude .git --exclude node_modules --exclude zig-cache | \
    fzf \
    --prompt="Find File ▶ " \
    --color dark \
    --color fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#98c379 \
    --color info:#98c379,prompt:#61afef,pointer:#e5c07b,marker:#e5c07b,spinner:#61afef,header:#61afef \
    --preview "bat --color=always --style=plain {1}" \
    --preview-window "right:60%:wrap" \
    --bind "enter:execute:(${EDITOR:-nvim} {})"
}

fcf() {
    fdfind --type f --hidden --exclude .git --exclude node_modules --exclude zig-cache | \
    fzf \
    --prompt="Find File ▶ " \
    --color dark \
    --color fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#98c379 \
    --color info:#98c379,prompt:#61afef,pointer:#e5c07b,marker:#e5c07b,spinner:#61afef,header:#61afef \
    --preview "bat --color=always --style=plain {1}" \
    --preview-window "right:60%:wrap" \
    --bind "enter:execute:(nvim --server ./nvim/nvimsocket --remote {})"
}

# Keep the default fg functionality
fgg() {
    [[ -z $(jobs) ]] && return 1
    [ $# -gt 0 ] && builtin fg "$@" || builtin fg
}

