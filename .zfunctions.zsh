#!/usr/bin/env zsh

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
          --preview-window 'up,50%,border-bottom,~2,+{2}+2/2' \
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

_confirm_run() {
  local cmd="$1"
  [[ -z "$cmd" ]] && return

  # Display the command in color
  echo -n "\n\033[0;33mExecute?\033[0m \033[1;37m${cmd}\033[0m [y/N] "
  
  # Read a single key (-k 1)
  read -k 1 key
  echo # Newline after key press
  
  if [[ "$key" == "y" || "$key" == "Y" ]]; then
    eval "$cmd"
  else
    echo "Cancelled."
  fi
}

fh() {
  local cmd
  cmd=$(fc -rnl 1 | awk '!seen[$0]++' | fzf +s --tiebreak=index --header='[History -> Edit]' --query="$1")
  
  [[ -n "$cmd" ]] && print -z "$cmd"
}

cr() {
  local cmd
  cmd=$(fc -rnl 1 | awk '!seen[$0]++' | fzf --layout=reverse --prompt='Run> ' --header='[History -> Execute]')
  _confirm_run "$cmd"
}

fo() {
  local files
  IFS=$'\n' files=("$(fzf-tmux --query="$1" --multi --select-1 --exit-0)")
  [[ -n "$files" ]] && "${EDITOR:-vim}" "${files[@]}"
}

fgb() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
  fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout "$(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")"
}

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

fgg() {
    [[ -z $(jobs) ]] && return 1
    [ $# -gt 0 ] && builtin fg "$@" || builtin fg
}

rgcsv() {
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case -F "

  fzf --disabled --ansi --bind "start:reload:$RG_PREFIX {q}" \
      --bind "change:reload:$RG_PREFIX {q} || true" \
      --delimiter : \
      --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
      --prompt 'Search exactly> '
}

turbo_csv() {
    local LIMIT=300
    local rg_base="rg --column --line-number --no-heading --color=always --smart-case -F"
    local preview_cmd='bat --style=header,grid --color=always --line-range 1:1 --line-range {2}:+2 {1}'

    local selection=$(
        fzf --disabled --ansi \
            --bind "start:reload:$rg_base {q} | head -n $LIMIT" \
            --bind "change:reload:$rg_base {q} | head -n $LIMIT || true" \
            --delimiter : \
            --preview "$preview_cmd" \
            --preview-window 'up,50%,border-bottom' \
            --prompt '🚀 Fast CSV > ' \
            --header 'Digite sua frase com espaços. Mostrando top 300 resultados.'
    )

    if [[ -n "$selection" ]]; then
        local file=$(echo "$selection" | cut -d: -f1)
        local line=$(echo "$selection" | cut -d: -f2)

        nvim "$file" "+$line" -c "normal! zz"
    fi
}


function udump() {
    local term="$1"

    if [[ -z "$term" ]]; then
        echo -n "Enter the exact search term: "
        read term
    fi

    if [[ -z "$term" ]]; then
        echo "❌ Empty search."
        return 1
    fi

    local safe_name=$(echo "$term" | tr ' ' '_')
    local output_dir="./${safe_name}"
    local output_file="${output_dir}/result_${safe_name}.txt"

    echo "🔍 Searching for: '$term'..."

    mkdir -p "$output_dir"
    ugrep -F -r -n -I --color=never "$term" . > "$output_file"

    if [[ -s "$output_file" ]]; then
        local count=$(wc -l < "$output_file" | tr -d ' ')
        echo "✅ Success! $count lines saved to:"
        echo "📂Directory: $output_dir"
        echo "📄File:      $(basename "$output_file")"
    else
        echo "⚠️  No results found."
        rm -rf "$output_dir"
    fi
}

function uconvert() {
    local input_file="$1"

    if [[ -z "$input_file" ]]; then
        input_file=$(find . -maxdepth 2 -name "result_*.txt" -type f -print0 | xargs -0 ls -t 2>/dev/null | head -n 1)
    fi

    if [[ -z "$input_file" || ! -f "$input_file" ]]; then
        echo "❌ Error: File not found or not specified."
        return 1
    fi

    local output_file="${input_file%.*}.csv"

    echo "⚙️  Converting '$input_file' to CSV..."

    sed -E 's/^([^:]*):([0-9]*):/"\1",\2,/' "$input_file" > "$output_file"

    if [[ -s "$output_file" ]]; then
        echo "✅ Success! CSV file created:"
        echo "📄 $output_file"
    else
        echo "⚠️  Failed to create file."
    fi
}

# function udump() {
#     local term="$1"

#     if [[ -z "$term" ]]; then
#         echo -n "Enter the exact search term: "
#         read term
#     fi

#     if [[ -z "$term" ]]; then
#         echo "❌ Empty search."
#         return 1
#     fi

#     local safe_name=$(echo "$term" | tr ' ' '_')
#     local output_file="./result_${safe_name}.txt"

#     echo "🔍 Searching for: '$term'..."

#     ugrep -F -r -n -I --color=never "$term" . > "$output_file"

#     if [[ -s "$output_file" ]]; then
#         local count=$(wc -l < "$output_file" | tr -d ' ')
#         echo "✅ Success! $count lines saved to:"
#         echo "📄 $output_file"
#     else
#         echo "⚠️  No results found."
#         rm "$output_file"
#     fi
# }

# function uconvert() {
#     local input_file="$1"

#     if [[ -z "$input_file" ]]; then
#         echo "❌ Error: Please provide the .txt file to convert."
#         echo "Usage: uconvert file.txt"
#         return 1
#     fi

#     if [[ ! -f "$input_file" ]]; then
#         echo "❌ Error: File '$input_file' not found."
#         return 1
#     fi

#     local output_file="${input_file%.*}.csv"

#     echo "⚙️  Converting '$input_file' to CSV..."

#     sed -E 's/^([^:]*):([0-9]*):/"\1",\2,/' "$input_file" > "$output_file"

#     if [[ -s "$output_file" ]]; then
#         echo "✅ Success! CSV file created:"
#         ls -lh "$output_file"
#         echo "💡 Hint: The first two columns are now 'Source File' and 'Line'."
#     else
#         echo "⚠️  Failed to create file."
#     fi
# }

function uclean() {
  local input_file="$1"

  if [[ -z "$input_file" ]]; then
    input_file=$(ls -t result_*.txt 2>/dev/null | head -n 1)
  fi

  if [[ ! -f "$input_file" ]]; then
    echo "❌ No input file found or specified."
    return 1
  fi

  local output_file="${input_file%.*}_clean.csv"

  echo "🧹 Cleaning empty columns in: $input_file ..."

  sed -E 's/,,+/,/g; s/,+$//' "$input_file" > "$output_file"

  if [[ -s "$output_file" ]]; then
    echo "✅ Clean file saved to:"
    echo "📄 $output_file"

    echo "\n--- Preview ---"
    head -n 3 "$output_file" | cut -c -100
    echo "..."
  else
    echo "⚠️  Error processing file."
  fi
}
