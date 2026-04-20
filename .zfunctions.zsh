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

# function ing() {
#   local file
#   local line
#   
#   local RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case --hidden --ignore-file $HOME/.rgignore"
#   local INITIAL_QUERY="${*:-}"

#   read -r file line <<<"$(
#     FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY")" \
#       fzf --ansi \
#           --disabled \
#           --query "$INITIAL_QUERY" \
#           --color "hl:-1:underline,hl+:-1:underline:reverse" \
#           --header='?:preview | CTRL-R:ripgrep | CTRL-F:fzf | CTRL-O:open & return' \
#           --bind '?:toggle-preview' \
#           --bind "change:reload(sleep 0.1; $RG_PREFIX {q} || true)" \
#           --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
#           --bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
#           --bind "start:unbind(ctrl-r)" \
#           --bind 'ctrl-o:execute(nvim {1} +{2})' \
#           --prompt '1. ripgrep> ' \
#           --height 60% \
#           --layout=reverse \
#           --delimiter : \
#           --preview-window 'up,60%,border-bottom,~5,+{2}+2/2' \
#           --preview '
#             FILE={1}
#             LINE={2}
#             END_LINE=$((LINE + 150))
#             
#             printf "\033[1;33m--- File Info ---\033[0m\n"
#             printf "Path: %s\n" "$(realpath "$FILE")"
#             stat -t "%d/%m/%Y %H:%M:%S" -f "Created on: %SB | Modified: %Sm | Size: %z bytes" "$FILE"
#             printf "Type: "
#             file -b "$FILE"
#             echo ""
#             
#             bat --style=full --color=always --highlight-line "$LINE" --line-range 1:$END_LINE "$FILE"
#           ' | awk -F: '{print $1, $2}'
#   )"

#   if [[ -n "$file" ]]; then
#     nvim "$file" "+$line"
#   fi
# }

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
  local RG_BASE="rg --column --line-number --no-heading --color=always --smart-case --hidden --ignore-file $HOME/.rgignore --sortr created"

  while true; do
    fzf_out=$(
      FZF_DEFAULT_COMMAND="q=\"$query\"; pcre=\"^\"; for w in \$q; do pcre=\"\${pcre}(?=.*\${w})\"; done; eval \"$RG_BASE -P '\$pcre'\"" \
      fzf --ansi \
          --disabled \
          --print-query \
          --query "$query" \
          --color "hl:-1:underline,hl+:-1:underline:reverse" \
          --header='?:preview | CTRL-R:ripgrep | CTRL-F:fzf | CTRL-O:open & return' \
          --bind '?:toggle-preview' \
          --bind "change:reload(sleep 0.1; q={q}; pcre=\"^\"; for w in \$q; do pcre=\"\${pcre}(?=.*\${w})\"; done; eval \"$RG_BASE -P '\$pcre'\" || true)" \
          --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
          --bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload(q={q}; pcre=\"^\"; for w in \$q; do pcre=\"\${pcre}(?=.*\${w})\"; done; eval \"$RG_BASE -P '\$pcre'\" || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
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

    query=$(head -n 1 <<< "$fzf_out")
    selection=$(tail -n +2 <<< "$fzf_out")

    if [[ -z "$selection" ]]; then
      break
    fi

    file=$(awk -F: '{print $1}' <<< "$selection")
    line=$(awk -F: '{print $2}' <<< "$selection")

    if [[ -n "$file" ]]; then
      nvim "$file" "+$line"
    fi
  done
}

function itg() {
  local file line query fzf_out selection
  query="${*:-}"
  
  # Base do Ripgrep com suporte a PCRE2
  local RG_BASE="rg --column --line-number --no-heading --color=always --smart-case --hidden"

  # Função para criar o Regex de AND (converte espaço em lookahead e vírgula em ponto)
  function build_rg_pcre() {
    echo "$1" | sed 's/,/./g' | awk '{
      printf "^"
      for (i=1; i<=NF; i++) printf "(?=.*" $i ")"
    }'
  }

  while true; do
    fzf_out=$(
      fzf --ansi \
          --disabled \
          --query "$query" \
          --bind "change:reload:sleep 0.1; $RG_BASE -P \"\$(build_rg_pcre {q})\" || true" \
          --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)" \
          --bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+rebind(change,ctrl-f)+reload($RG_BASE -P \"\$(build_rg_pcre {q})\" || true)" \
          --bind 'ctrl-o:execute(nvim {1} +{2})' \
          --header='?:preview | CTRL-O:nvim' \
          --prompt '1. ripgrep> ' \
          --delimiter : \
          --preview-window 'up,60%,border-bottom,wrap,+{2}-1/2' \
          --preview '
            FILE={1}
            LINE={2}
            # Se LINE for vazio (apenas nome de arquivo), define como 1
            [[ -z "$LINE" ]] && LINE=1
            
            if [[ -f "$FILE" ]]; then
              printf "\033[1;33m--- File: %s ---\033[0m\n" "$FILE"
              # Calcula range seguro para o bat
              START=$(( LINE > 50 ? LINE - 50 : 1 ))
              bat --style=full --color=always --highlight-line "$LINE" --line-range "$START:$((LINE + 50))" "$FILE"
            else
              echo "Aguardando seleção válida..."
            fi
          '
    )

    [[ -z "$fzf_out" ]] && break

    # Divide a seleção do fzf (file:line:col:text)
    selection=$(echo "$fzf_out" | tail -n 1)
    file=$(echo "$selection" | cut -d: -f1)
    line=$(echo "$selection" | cut -d: -f2)

    if [[ -n "$file" ]]; then
      nvim "$file" "+${line:-1}"
      break # Sai do loop após abrir o nvim, ou remova para continuar pesquisando
    fi
  done
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

  if [[ -n $file ]]
  then
    vim "$file" +"$line"
  fi
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
    
    echo "#!/bin/bash" > "$TMP_BIN/tesseract"
    echo "exec \"$REAL_TESS\" \"\$@\" -l por" >> "$TMP_BIN/tesseract"
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

  sed -E 's/,,+/,/g; s/,+$//' "$input_file" > "$output_file"

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
    fd --type f --hidden --exclude .git --exclude node_modules --exclude zig-cache \
      | awk -F/ '{print NF, $0}' \
      | sort -n \
      | cut -d' ' -f2- \
      | fzf-tmux --query="$1" --select-1 --exit-0
  )
  [[ -n "$file" ]] && "${EDITOR:-nvim}" "$file"
}

fcf() {
    fd --type f --hidden --exclude .git --exclude node_modules --exclude zig-cache | \
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

# Git
fgb() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
  fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout "$(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")"
}

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
    tmux kill-session -t "$1"; return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux kill-session -t "$session" || echo "No session found to delete."
}

fgg() {
    [[ -z $(jobs) ]] && return 1
    [ $# -gt 0 ] && builtin fg "$@" || builtin fg
}

# Environment
pyenv-brew-relink() {
    rm -f "$HOME/.pyenv/versions/*-brew"
    for i in "$(brew --cellar)"/python* ; do
        ln -s -f "$p" "$HOME/.pyenv/versions/${i##/*/}-brew"
    done
    pyenv rehash
}

