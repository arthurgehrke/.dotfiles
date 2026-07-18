#!/usr/bin/env zsh

_confirm_run() {
  local cmd="$1"
  [[ -z "$cmd" ]] && return

  echo -n "\n\033[0;33mExecute?\033[0m \033[1;37m${cmd}\033[0m [y/N] "

  read -k 1 key
  echo

  if [[ "$key" == "y" || "$key" == "Y" ]]; then
    eval "$cmd"
  else
    echo "Cancelled."
  fi
}

function alfclip() {
  local db="$HOME/Library/Application Support/Alfred/Databases/clipboard.alfdb"
  [[ -f "$db" ]] || {
    print -u2 "alfclip: DB não encontrada: $db"
    return 1
  }
  local tmp="${TMPDIR:-/tmp}/alfred-clipboard.$$.txt"
  sqlite3 "$db" \
    "SELECT item || char(10) || '──────────────────────────────────────' FROM clipboard ORDER BY ts DESC;" \
    >"$tmp" || {
    print -u2 "alfclip: falha no dump"
    return 1
  }
  nvim "$tmp"
}

function irg() {
  local file
  local line

  local RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case --hidden --ignore-file $HOME/.rgignore"
  local INITIAL_QUERY="${*:-}"

  read -r file line <<<"$(
    FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY")" \
      fzf --ansi \
      --disabled \
      --query "$INITIAL_QUERY" \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --header='?:preview | CTRL-R:ripgrep | CTRL-F:fzf | CTRL-O:open & return' \
      --bind '?:toggle-preview' \
      --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
      --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
      --bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
      --bind "start:unbind(ctrl-r)" \
      --bind 'ctrl-o:execute(nvim {1} +{2})' \
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

function irgf() {
  if [[ $# -ne 2 ]]; then
    echo "Usage: irgf <query> <file>   (use quotes for multi-word query)" >&2
    return 1
  fi

  local INITIAL_QUERY="$1"
  local target_file="$2"

  if [[ ! -f "$target_file" ]]; then
    echo "irgf: file not found: $target_file" >&2
    return 1
  fi

  local quoted_file=$(printf %q "$target_file")
  # Multi-word queries become AND lookaheads; \Q...\E keeps each term literal
  local search_script='q="$1"; file="$2"; [ -z "$q" ] && exit 0; pattern=""; for w in $q; do pattern="${pattern}(?=.*\\Q${w}\\E)"; done; pattern="${pattern}.*"; rg --column --line-number --no-heading --color=always --smart-case --hidden --pcre2 --ignore-file "$HOME/.rgignore" -- "$pattern" "$file" || true'
  local quoted_script=$(printf %q "$search_script")

  FZF_DEFAULT_COMMAND="sh -c $quoted_script _ $(printf %q "$INITIAL_QUERY") $quoted_file" \
    fzf --ansi \
    --disabled \
    --query "$INITIAL_QUERY" \
    --color "hl:-1:underline,hl+:-1:underline:reverse" \
    --header="?:preview | Enter:open in nvim (return here) | CTRL-R:ripgrep | CTRL-F:fzf | file: $target_file" \
    --bind '?:toggle-preview' \
    --bind "change:reload:sleep 0.1; sh -c $quoted_script _ {q} $quoted_file" \
    --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
    --bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload(sh -c $quoted_script _ {q} $quoted_file)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
    --bind "start:unbind(ctrl-r)" \
    --bind "enter:execute(nvim $quoted_file +{1})" \
    --prompt '1. ripgrep> ' \
    --height 40% \
    --layout=reverse \
    --delimiter : \
    --preview-window 'up,50%,border-bottom,~2,+{1}+2/2' \
    --preview "bat --style=full --color=always --highlight-line {1} $quoted_file" >/dev/null
}
compdef '_arguments "1: :( )" "2:file:_files"' irgf

function ing() {
  local file
  local line

  local RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case --hidden --ignore-file $HOME/.rgignore --sortr created"
  local INITIAL_QUERY="${*:-}"
  read -r file line <<<"$(
    FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY")" \
      fzf --ansi \
      --disabled \
      --query "$INITIAL_QUERY" \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --header='?:preview | CTRL-R:ripgrep | CTRL-F:fzf | CTRL-O:open & return' \
      --bind '?:toggle-preview' \
      --bind "change:reload(sleep 0.1; $RG_PREFIX {q} || true)" \
      --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
      --bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
      --bind "start:unbind(ctrl-r)" \
      --bind 'ctrl-o:execute(nvim {1} +{2})' \
      --prompt '1. ripgrep> ' \
      --height 60% \
      --layout=reverse \
      --delimiter : \
      --preview-window 'up,60%,border-bottom' \
      --preview '
            FILE={1}
            LINE={2}
            CONTEXT=150
            START_LINE=$((LINE - CONTEXT))
            END_LINE=$((LINE + CONTEXT))
            [ "$START_LINE" -lt 1 ] && START_LINE=1
            HEADER_LINES=6
            SCROLL_TO=$((LINE - START_LINE + HEADER_LINES))
            
            printf "\033[1;33m--- File Info ---\033[0m\n"
            printf "Path: %s\n" "$(realpath "$FILE")"
            stat -t "%d/%m/%Y %H:%M:%S" -f "Created on: %SB | Modified: %Sm | Size: %z bytes" "$FILE"
            printf "Type: "
            file -b "$FILE"
            printf "\033[1;36m>>> Match at line %s\033[0m\n\n" "$LINE"
            
            bat --style=full --color=always --highlight-line "$LINE" --line-range "$START_LINE:$END_LINE" "$FILE"
          ' | awk -F: '{print $1, $2}'
  )"
  if [[ -n "$file" ]]; then
    nvim "$file" "+$line"
  fi
}

function isg() {
  local file line query fzf_out selection

  query="${*:-}"
  local search_script='q="$1"; [ -z "$q" ] && exit 0; pattern="^"; for w in $q; do pattern="${pattern}(?=.*\\Q${w}\\E)"; done; pattern="${pattern}.*"; rg --column --line-number --no-heading --color=always --smart-case --hidden --ignore-file "$HOME/.rgignore" --sortr created --pcre2 -- "$pattern" || true'
  local quoted_script
  quoted_script=$(printf %q "$search_script")

  while true; do
    fzf_out=$(
      FZF_DEFAULT_COMMAND="sh -c $quoted_script _ $(printf %q "$query")" \
        fzf --ansi \
        --disabled \
        --print-query \
        --query "$query" \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --header='?:preview | CTRL-R:ripgrep | CTRL-F:fzf | CTRL-O:open & return' \
        --bind '?:toggle-preview' \
        --bind "change:reload(sleep 0.1; sh -c $quoted_script _ {q})" \
        --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
        --bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload(sh -c $quoted_script _ {q})+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
        --bind "start:unbind(ctrl-r)" \
        --bind 'ctrl-o:execute(nvim {1} +{2})' \
        --prompt '1. ripgrep> ' \
        --height 60% \
        --layout=reverse \
        --delimiter : \
        --preview-window 'up,60%,border-bottom,wrap,+57-1/2' \
        --preview '
            FILE={1}
            LINE={2}
            CONTEXT=50
            START_LINE=$((LINE - CONTEXT))
            END_LINE=$((LINE + CONTEXT))
            PADDING=0
            
            # Se o match for no começo do arquivo, calcula as linhas vazias necessárias
            # para manter o scroll do fzf sempre perfeitamente centralizado.
            if [ "$START_LINE" -lt 1 ]; then
              PADDING=$((1 - START_LINE))
              START_LINE=1
            fi
            
            printf "\033[1;33m--- File Info ---\033[0m\n"
            printf "Path: %s\n" "$(realpath "$FILE")"
            stat -t "%d/%m/%Y %H:%M:%S" -f "Created on: %SB | Modified: %Sm | Size: %z bytes" "$FILE" 2>/dev/null || stat -c "Modified: %y | Size: %s bytes" "$FILE"
            printf "Type: "
            file -b "$FILE"
            printf "\033[1;36m>>> Match at line %s\033[0m\n\n" "$LINE"
            
            # Aplica o padding se necessário
            if [ "$PADDING" -gt 0 ]; then
              for i in $(seq 1 $PADDING); do echo ""; done
            fi
            
            # Executa o bat com quebra de linha (wrap) ativada
            bat --style=full --color=always --wrap=character --highlight-line "$LINE" --line-range "$START_LINE:$END_LINE" "$FILE"
          '
    )

    if [[ -z "$fzf_out" ]]; then
      break
    fi

    query=$(head -n 1 <<<"$fzf_out")
    selection=$(tail -n +2 <<<"$fzf_out")

    if [[ -z "$selection" ]]; then
      break
    fi

    file=$(awk -F: '{print $1}' <<<"$selection")
    line=$(awk -F: '{print $2}' <<<"$selection")

    if [[ -n "$file" ]]; then
      nvim "$file" "+$line"
    fi
  done
}

function itg() {
  local RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case --hidden"
  local INITIAL_QUERY="${*:-}"

  # Column-anchored AND: cada termo (separado por espaço OU vírgula) ancora na
  # próxima coluna delimitada por vírgula. Ex: "417401 02 28" -> col1~417401,
  # col2~02, col3~28. NF==0 -> nada (rg falha, fica vazio).
  local BUILD='awk "{gsub(/,/,\" \"); if(NF==0)exit; printf \"^\"; for(i=1;i<=NF;i++){printf \"[^,]*\"\$i\"[^,]*\"; if(i<NF) printf \",\"}}"'

  local INITIAL_PATTERN=""
  if [[ -n "$INITIAL_QUERY" ]]; then
    INITIAL_PATTERN=$(printf '%s' "$INITIAL_QUERY" | awk '{gsub(/,/," "); if(NF==0)exit; printf "^"; for(i=1;i<=NF;i++){printf "[^,]*"$i"[^,]*"; if(i<NF) printf ","}}')
  fi
  local INITIAL_CMD
  if [[ -n "$INITIAL_PATTERN" ]]; then
    INITIAL_CMD="$RG_PREFIX -P $(printf %q "$INITIAL_PATTERN") 2>/dev/null || true"
  else
    INITIAL_CMD="true"
  fi

  FZF_DEFAULT_COMMAND="$INITIAL_CMD" \
    fzf --ansi \
    --disabled \
    --query "$INITIAL_QUERY" \
    --color "hl:-1:underline,hl+:-1:underline:reverse" \
    --header='Enter:open (return) | ?:preview | CTRL-R:ripgrep | CTRL-F:fzf | CTRL-O:open' \
    --bind '?:toggle-preview' \
    --bind "change:reload:sleep 0.1; $RG_PREFIX -P \"\$(echo {q} | $BUILD)\" 2>/dev/null || true" \
    --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
    --bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload($RG_PREFIX -P \"\$(echo {q} | $BUILD)\" 2>/dev/null || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
    --bind "start:unbind(ctrl-r)" \
    --bind 'enter:execute(nvim {1} +{2})' \
    --bind 'ctrl-o:execute(nvim {1} +{2})' \
    --prompt '1. ripgrep> ' \
    --height 100% \
    --layout=reverse \
    --delimiter : \
    --preview-window 'up,70%,border-bottom,+{2}-/2' \
    --preview 'bat --style=full --color=always --highlight-line {2} -- {1} 2>/dev/null' \
    >/dev/null
}

function vdiff() {
  local file1_line file2_line file1 file2

  # 1. Seleciona o primeiro arquivo
  file1_line=$(lsd --long --timesort --color=always | fzf --ansi \
    --prompt="1. Arquivo Base > " \
    --layout=reverse --height=60% --header="Selecione o arquivo ORIGINAL")

  [[ -z "$file1_line" ]] && return

  # Limpa as cores (ANSI) com perl e pega a última palavra (o nome do arquivo) com awk
  file1=$(echo "$file1_line" | perl -pe 's/\x1b\[[0-9;]*[mK]//g' | awk '{print $NF}')

  # 2. Seleciona o segundo arquivo
  file2_line=$(lsd --long --timesort --color=always | fzf --ansi \
    --prompt="2. Arquivo Modificado > " \
    --layout=reverse --height=60% --header="Selecione o arquivo para comparar")

  [[ -z "$file2_line" ]] && return

  # Repete a limpeza para o segundo arquivo
  file2=$(echo "$file2_line" | perl -pe 's/\x1b\[[0-9;]*[mK]//g' | awk '{print $NF}')

  # 3. Trava de segurança: impede o nvim de abrir se não encontrar o arquivo
  if [[ ! -f "$file1" || ! -f "$file2" ]]; then
    echo "Erro: Não foi possível ler os arquivos. (1: $file1, 2: $file2)"
    return 1
  fi

  # 4. A mágica do bash: ordena em memória antes de abrir o diff!
  echo "Ordenando arquivos e abrindo diff..."
  nvim -d <(sort "$file1") <(sort "$file2")
}

fgr() {
  local file
  local line

  read -r file line <<<"$(rg --no-heading --line-number "$@" | fzf -0 -1 | awk -F: '{print $1, $2}')"

  if [[ -n $file ]]; then
    vim "$file" +"$line"
  fi
}

fg() {
  rg --color=always --line-number --no-heading --smart-case "${*:-}" -g '!{**/node_modules/*,**/.git/*,**lock,**/zig-cache/*}' |
    fzf \
      --ansi \
      --delimiter : \
      --prompt="Live Grep ▶ " \
      --preview "bat --color=always --style=plain {1} --highlight-line {2}" \
      --preview-window "right:60%:wrap" \
      --bind "enter:execute:(${EDITOR:-nvim} {1} +{2})"
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

rga-fzf() {
  local REAL_TESS=$(command -v tesseract)

  local TMP_BIN=$(mktemp -d)

  echo "#!/bin/bash" >"$TMP_BIN/tesseract"
  echo "exec \"$REAL_TESS\" \"\$@\" -l por" >>"$TMP_BIN/tesseract"
  chmod +x "$TMP_BIN/tesseract"

  local RG_PREFIX="rga --files-with-matches --rga-adapters=+tesseract"

  local file
  file="$(
    PATH="$TMP_BIN:$PATH" FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
      fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 --rga-adapters=+tesseract {q} {}" \
      --phony -q "$1" \
      --bind "change:reload:$RG_PREFIX {q}" \
      --preview-window="70%:wrap"
  )" &&
    echo "Abrindo $file" &&
    open "$file"

  rm -rf "$TMP_BIN"
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
      --header 'Enter your phrase with spaces. Showing top 300 results.'
  )

  if [[ -n "$selection" ]]; then
    local file=$(echo "$selection" | cut -d: -f1)
    local line=$(echo "$selection" | cut -d: -f2)

    nvim "$file" "+$line" -c "normal! zz"
  fi
}

# Ugrep and Data Processing
function udump() {
  local term="$1"

  if [[ -z "$term" ]]; then
    echo -n "Enter the exact search term: "
    read term
  fi

  if [[ -z "$term" ]]; then
    echo "Empty search"
    return 1
  fi

  local safe_name=$(echo "$term" | tr ' ' '_')
  local output_dir="./${safe_name}"
  local output_file="${output_dir}/result_${safe_name}.txt"

  echo "🔍 Searching for: '$term'..."

  mkdir -p "$output_dir"
  ugrep -F -r -n -I --color=never "$term" . >"$output_file"

  if [[ -s "$output_file" ]]; then
    local count=$(wc -l <"$output_file" | tr -d ' ')
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

  sed -E 's/^([^:]*):([0-9]*):/"\1",\2,/' "$input_file" >"$output_file"

  if [[ -s "$output_file" ]]; then
    echo "Success! CSV file created:"
    echo "$output_file"
  else
    echo "Failed to create file."
  fi
}

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

  sed -E 's/,,+/,/g; s/,+$//' "$input_file" >"$output_file"

  if [[ -s "$output_file" ]]; then
    echo "Clean file saved to:"
    echo "$output_file"

    echo "\n--- Preview ---"
    head -n 3 "$output_file" | cut -c -100
    echo "..."
  else
    echo "⚠️  Error processing file."
  fi
}

# File Management
function findBigFiles() {
  find ~/Documents/ -size +100M -ls | sort -k7nr
}

fo() {
  local file
  file=$(
    fd --type f --hidden \
      --ignore-file "$HOME/.rgignore" \
      --exclude .git --exclude node_modules --exclude zig-cache |
      awk -F/ '{print NF, $0}' |
      sort -n |
      cut -d' ' -f2- |
      fzf-tmux --query="$1" --select-1 --exit-0
  )
  [[ -n "$file" ]] && "${EDITOR:-nvim}" "$file"
}

fcf() {
  fd --type f --hidden \
    --ignore-file "$HOME/.rgignore" \
    --exclude .git --exclude node_modules --exclude zig-cache |
    fzf \
      --query="$1" \
      --prompt="Find File ▶ " \
      --color dark \
      --color fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#98c379 \
      --color info:#98c379,prompt:#61afef,pointer:#e5c07b,marker:#e5c07b,spinner:#61afef,header:#61afef \
      --preview "bat --color=always --style=plain {1}" \
      --preview-window "right:60%:wrap" \
      --bind "enter:become(nvim {1})"
}

fnf() {
  local file
  file=$(rg --files --hidden \
    --ignore-file "$HOME/.rgignore" \
    --sortr modified \
    --glob '!.git' --glob '!node_modules' --glob '!zig-cache' |
    fzf \
      --query="$1" \
      --prompt="Find Newest ▶ " \
      --color dark \
      --color fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#98c379 \
      --color info:#98c379,prompt:#61afef,pointer:#e5c07b,marker:#e5c07b,spinner:#61afef,header:#61afef \
      --header='Sorted by most recently modified ↓' \
      --preview '
        FILE={1}
        printf "\033[1;33m--- File Info ---\033[0m\n"
        printf "Path: %s\n" "$(realpath "$FILE")"
        stat -t "%d/%m/%Y %H:%M:%S" -f "Modified: %Sm | Created: %SB | Size: %z bytes" "$FILE"
        printf "Type: "
        file -b "$FILE"
        echo ""
        bat --color=always --style=plain "$FILE"
    ' \
      --preview-window "right:60%:wrap")

  if [[ -n "$file" ]]; then
    nvim "$file"
    cd "$(dirname "$file")"
  fi
}

# Git
fgb() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
    branch=$(echo "$branches" |
      fzf-tmux -d $((2 + $(wc -l <<<"$branches"))) +m) &&
    git checkout "$(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")"
}

fzstash() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
      fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b
  ); do
    mapfile -t out <<<"$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff "$sha"
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" "$sha"
      break
    else
      git stash show -p "$sha"
    fi
  done
}

# History
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

# String Manipulation
function upper() {
  echo "$*" | tr '[:lower:]' '[:upper:]'
}

function lower() {
  echo "$*" | tr '[:upper:]' '[:lower:]'
}

function capitalize() {
  echo "$*" | tr '[:upper:]' '[:lower:]' | sed 's/^\w\|\s\w/\U&/g'
}

# Network
function geoip() {
  curl ipinfo.io/"$1"
}

# Tmux and Process Control
ftmk() {
  if [ "$1" ]; then
    tmux kill-session -t "$1"
    return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) && tmux kill-session -t "$session" || echo "No session found to delete."
}

fgg() {
  [[ -z $(jobs) ]] && return 1
  [ $# -gt 0 ] && builtin fg "$@" || builtin fg
}

# Environment
pyenv-brew-relink() {
  rm -f "$HOME/.pyenv/versions/*-brew"
  for i in "$(brew --cellar)"/python*; do
    ln -s -f "$p" "$HOME/.pyenv/versions/${i##/*/}-brew"
  done
  pyenv rehash
}

# CSV: pick file → pick column → show column data
frgcsv() {
  local file
  if [[ -n "$1" && -f "$1" ]]; then
    file="$1"
  else
    file=$(fd -e csv --hidden --ignore-file "$HOME/.rgignore" 2>/dev/null |
      fzf --prompt='CSV file> ' \
        --preview 'xsv table {} 2>/dev/null | head -30 || head -30 {}' \
        --preview-window 'right,60%,border-left' \
        --height 60% --layout=reverse) || return
  fi
  [[ -z "$file" || ! -f "$file" ]] && return

  local col
  col=$(xsv headers "$file" 2>/dev/null |
    fzf --prompt="Column ($file:t)> " \
      --preview "idx=\$(echo {} | awk '{print \$1}'); xsv select \$idx '$file' 2>/dev/null | head -200 | csvlook 2>/dev/null || xsv select \$idx '$file' | head -200" \
      --preview-window 'right,60%,border-left' \
      --height 60% --layout=reverse \
      --header='Enter: print column | Ctrl-V: open in visidata') || return
  [[ -z "$col" ]] && return

  local idx=$(echo "$col" | awk '{print $1}')
  xsv select "$idx" "$file" | csvlook 2>/dev/null | bat --paging=always --style=plain ||
    xsv select "$idx" "$file" | bat --paging=always --style=plain
}

# Docker container picker
fdc() {
  command -v docker >/dev/null || {
    echo "docker not found"
    return 1
  }
  local fmt='table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}'
  local row
  row=$(docker ps --format "$fmt" |
    fzf --header-lines=1 \
      --prompt='Container> ' \
      --header=$'Enter:exec sh | Ctrl-L:logs | Ctrl-X:stop | Ctrl-R:restart | Ctrl-I:inspect' \
      --bind "ctrl-l:execute(docker logs -f --tail 100 {1})" \
      --bind "ctrl-x:execute-silent(docker stop {1})+reload(docker ps --format '$fmt')" \
      --bind "ctrl-r:execute-silent(docker restart {1})+reload(docker ps --format '$fmt')" \
      --bind "ctrl-i:execute(docker inspect {1} | less)" \
      --preview 'docker logs --tail 30 {1} 2>&1' \
      --preview-window 'down,50%,border-top' \
      --layout=reverse --height 70%) || return
  [[ -z "$row" ]] && return
  local id=$(echo "$row" | awk '{print $1}')
  docker exec -it "$id" sh -c 'command -v bash >/dev/null && exec bash || exec sh'
}

# Kill process via fzf
fkill() {
  local sig="${1:-15}"
  local pids
  pids=$(ps -eo pid,user,%cpu,%mem,start,time,command |
    sed 1d |
    fzf --multi \
      --prompt="kill -$sig> " \
      --header=$'TAB: multi-select | Enter: send signal '"$sig"$'\nPID  USER  %CPU  %MEM  START   TIME      COMMAND' \
      --preview 'echo {}' \
      --preview-window 'down,3,border-top' \
      --layout=reverse --height 60% |
    awk '{print $1}')
  [[ -z "$pids" ]] && return
  echo "$pids" | xargs kill -"$sig"
  echo "Sent SIG$sig to: $(echo $pids | tr '\n' ' ')"
}

# Environment variables fuzzy picker with value preview
fenv() {
  local sel
  sel=$(env | sort |
    fzf --prompt='env> ' \
      --delimiter='=' \
      --preview 'echo {} | cut -d= -f2- | bat --color=always --style=plain --language=bash' \
      --preview-window 'down,40%,border-top,wrap' \
      --header='Enter: copy value to clipboard | Ctrl-N: copy name' \
      --bind 'ctrl-n:execute-silent(echo -n {1} | pbcopy)+abort' \
      --layout=reverse --height 70%) || return
  [[ -z "$sel" ]] && return
  echo "$sel" | cut -d= -f2- | tr -d '\n' | pbcopy
  echo "Copied value of: $(echo $sel | cut -d= -f1)"
}

# Listening ports picker → kill process on selected port
fport() {
  local row
  row=$(lsof -nP -iTCP -sTCP:LISTEN 2>/dev/null |
    fzf --header-lines=1 \
      --prompt='listening port> ' \
      --header=$'Enter:kill PID | Ctrl-I:lsof detail of PID' \
      --bind 'ctrl-i:execute(lsof -p {2} | less)' \
      --preview 'ps -p {2} -o pid,user,%cpu,%mem,start,time,command' \
      --preview-window 'down,5,border-top,wrap' \
      --layout=reverse --height 60%) || return
  [[ -z "$row" ]] && return
  local pid=$(echo "$row" | awk '{print $2}')
  local cmd=$(echo "$row" | awk '{print $1}')
  echo -n "kill PID $pid ($cmd)? [y/N] "
  read -k 1 ans
  echo
  [[ "$ans" == "y" || "$ans" == "Y" ]] && kill "$pid" && echo "killed $pid"
}

##############################################################################
# CSV/TXT helpers (vellasc / remessas) — termos AND, vírgula vira ".".
##############################################################################

# _csv_pcre <termos...> -> regex column-anchored AND (espaço/vírgula = próxima coluna)
_csv_pcre() {
  printf '%s' "$*" | awk '{
    gsub(/,/, " ")
    if(NF==0) exit
    printf "^"
    for (i=1; i<=NF; i++) {
      printf "[^,]*" $i "[^,]*"
      if(i<NF) printf ","
    }
  }'
}

# csvg <termos...>  -> grep coluna-a-coluna em todos .csv/.txt do diretório atual
# Ex: csvg 417401 02 2028   -> col1~417401, col2~02, col3~2028
csvg() {
  if [ "$#" -eq 0 ]; then
    echo "uso: csvg <termo1> [termo2 ...]" >&2
    return 1
  fi
  local pat
  pat=$(_csv_pcre "$@")
  [[ -z "$pat" ]] && return 0
  rg --color=always --line-number --no-heading --smart-case -P "$pat" -g '*.csv' -g '*.txt'
}

# itgf <arquivo|dir> [termos...] -> mesma UI do itg.
#   arquivo: restringe a 1 arquivo.
#   dir (ex: .): busca em *.csv e *.txt do diretório (recursivo).
# Ex: itgf . 417401 02,28
itgf() {
  local target="$1"
  shift
  if [[ -z "$target" || ( ! -f "$target" && ! -d "$target" ) ]]; then
    echo "uso: itgf <arquivo|dir> [termos...]   (use '.' para o dir atual)" >&2
    return 1
  fi

  local INITIAL_QUERY="${*:-}"
  # Column-anchored AND (mesmo que itg).
  local BUILD='awk "{gsub(/,/,\" \"); if(NF==0)exit; printf \"^\"; for(i=1;i<=NF;i++){printf \"[^,]*\"\$i\"[^,]*\"; if(i<NF) printf \",\"}}"'

  # Monta um comando que injeta o padrão -P como argumento de rg.
  local RG_RUN
  if [[ -d "$target" ]]; then
    RG_RUN="rg --column --line-number --no-heading --color=always --smart-case --hidden -g '*.csv' -g '*.txt' -P \"\$(echo {q} | $BUILD)\" $(printf %q "$target") 2>/dev/null || true"
  else
    RG_RUN="rg --column --line-number --no-heading --color=always --smart-case --hidden -P \"\$(echo {q} | $BUILD)\" -- $(printf %q "$target") 2>/dev/null || true"
  fi

  # Pattern inicial column-aware para FZF_DEFAULT_COMMAND
  local INITIAL_PATTERN=""
  if [[ -n "$INITIAL_QUERY" ]]; then
    INITIAL_PATTERN=$(printf '%s' "$INITIAL_QUERY" | awk '{gsub(/,/," "); if(NF==0)exit; printf "^"; for(i=1;i<=NF;i++){printf "[^,]*"$i"[^,]*"; if(i<NF) printf ","}}')
  fi
  local INITIAL_CMD="true"
  if [[ -n "$INITIAL_PATTERN" ]]; then
    if [[ -d "$target" ]]; then
      INITIAL_CMD="rg --column --line-number --no-heading --color=always --smart-case --hidden -g '*.csv' -g '*.txt' -P $(printf %q "$INITIAL_PATTERN") $(printf %q "$target") 2>/dev/null || true"
    else
      INITIAL_CMD="rg --column --line-number --no-heading --color=always --smart-case --hidden -P $(printf %q "$INITIAL_PATTERN") -- $(printf %q "$target") 2>/dev/null || true"
    fi
  fi

  FZF_DEFAULT_COMMAND="$INITIAL_CMD" \
    fzf --ansi --disabled --query "$INITIAL_QUERY" \
    --color "hl:-1:underline,hl+:-1:underline:reverse" \
    --header="alvo: $target | Enter:open (return) | ?:preview | CTRL-R:ripgrep | CTRL-F:fzf | CTRL-O:open" \
    --bind '?:toggle-preview' \
    --bind "change:reload:sleep 0.1; $RG_RUN" \
    --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
    --bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload($RG_RUN)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
    --bind "start:unbind(ctrl-r)" \
    --bind 'enter:execute(nvim {1} +{2})' \
    --bind 'ctrl-o:execute(nvim {1} +{2})' \
    --prompt '1. ripgrep> ' --height 100% --layout=reverse --delimiter : \
    --preview-window 'up,70%,border-bottom,+{2}-/2' \
    --preview 'bat --style=full --color=always --highlight-line {2} -- {1} 2>/dev/null' \
    >/dev/null
}

# csvfind <numero> -> procura um valor exato em coluna (delim vírgula) em todos .csv/.txt
# Casa apenas se for um campo completo, evitando match dentro de outro número.
csvfind() {
  local needle="$1"
  if [[ -z "$needle" ]]; then
    echo "uso: csvfind <valor>" >&2
    return 1
  fi
  # boundaries de campo CSV: início-de-linha ou vírgula, e fim ou vírgula.
  rg --color=always --line-number --no-heading -P "(^|,)\Q$needle\E(,|$)" -g '*.csv' -g '*.txt'
}

# csvcol <arquivo> <N> -> imprime a N-ésima coluna (1-based, delim vírgula).
csvcol() {
  local file="$1" n="$2"
  if [[ -z "$file" || -z "$n" || ! -f "$file" ]]; then
    echo "uso: csvcol <arquivo> <num_coluna>" >&2
    return 1
  fi
  awk -F',' -v c="$n" 'NF>=c {print $c}' "$file"
}

# csvcount <arquivo...> -> conta linhas úteis (ignora cabeçalho se 1ª col não for número)
csvcount() {
  if [ "$#" -eq 0 ]; then
    echo "uso: csvcount <arquivo> [arquivo...]" >&2
    return 1
  fi
  local f total=0 n
  for f in "$@"; do
    [[ ! -f "$f" ]] && { echo "skip (não é arquivo): $f" >&2; continue; }
    n=$(awk -F',' 'NR==1 && $1 !~ /^[0-9]+$/ {next} {c++} END{print c+0}' "$f")
    printf '%8d  %s\n' "$n" "$f"
    total=$((total + n))
  done
  printf '%8d  TOTAL\n' "$total"
}

# csvuniq <arquivo> -> imprime linhas únicas pela 1ª coluna, preservando ordem
csvuniq() {
  local file="$1"
  if [[ -z "$file" || ! -f "$file" ]]; then
    echo "uso: csvuniq <arquivo>" >&2
    return 1
  fi
  awk -F',' '!seen[$1]++' "$file"
}

# csvdiff <A> <B> -> valores da 1ª coluna que estão em A mas não em B
csvdiff() {
  local a="$1" b="$2"
  if [[ ! -f "$a" || ! -f "$b" ]]; then
    echo "uso: csvdiff <fileA> <fileB>" >&2
    return 1
  fi
  awk -F',' 'NR==FNR{s[$1]=1; next} !($1 in s)' "$b" "$a"
}
