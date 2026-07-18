# ─────────────────────────────────────────────────────────────
#  Aurora — single-line Powerlevel10k with pill segments.
#
#  Style:  one-line, powerline pill segments separated by ❯ chevrons,
#          Catppuccin Mocha palette, contextual right side.
#
#  Layout (left):   user ❯ ✓/✘ ❯ dir ❯ git
#  Layout (right):  node ❯ aws ❯ k8s ❯ time   (only when relevant)
#
#  To activate, change in ~/.zshrc:
#    source "$HOME"/.themes/zsh/simple-theme/.p10k.zsh
#  to:
#    source "$HOME"/.themes/zsh/aurora/.p10k.zsh
# ─────────────────────────────────────────────────────────────

'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

  # ── Segments ───────────────────────────────────────────────
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    context           # username (only if ssh / root)
    status            # ✓ / ✘ pill
    dir               # current directory
    vcs               # git branch + state
  )
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    background_jobs   # only if any
    direnv            # only if .envrc active
    node_version      # only in node projects
    aws               # only when invoking aws/terraform/...
    kubecontext       # only when invoking kubectl/helm/...
    time              # HH:MM
  )

  # ── Palette (Catppuccin Mocha → 256-color) ─────────────────
  # pill_bg is the soft surface that all segments share; foreground colors
  # carry the meaning. This is what makes the row read as one cohesive bar
  # rather than a string of unrelated tags.
  local pill_bg=236 pill_dim=240
  local mauve=183 blue=111 sapphire=117 sky=153 teal=158
  local green=120 yellow=222 peach=216 red=210 pink=218
  local text=189 subtext=146 muted=244

  # ── Global look ────────────────────────────────────────────
  typeset -g POWERLEVEL9K_MODE=nerdfont-complete
  typeset -g POWERLEVEL9K_ICON_PADDING=none

  # One line, no extra blank line above prompt.
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false

  # Powerline pill chevrons — the iconic `>` shape between segments.
  #  = solid right arrow (segment-to-bg transition)
  #  = thin right chevron (same-bg subsegment divider)
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$''
  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=$''
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$''
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=$''
  typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=
  typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=$''
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL=$''
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=

  # Color the chevron dividers.
  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR_FOREGROUND=$pill_dim
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR_FOREGROUND=$pill_dim

  # All pills share the same soft bg — only fg changes per segment.
  typeset -g POWERLEVEL9K_BACKGROUND=$pill_bg

  # ── context (user) ─────────────────────────────────────────
  typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n'
  typeset -g POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND=$subtext
  typeset -g POWERLEVEL9K_CONTEXT_BACKGROUND=$pill_bg
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=$red
  typeset -g POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND=$mauve
  typeset -g POWERLEVEL9K_CONTEXT_REMOTE_SUDO_FOREGROUND=$red
  # Hide locally for normal user — only show in ssh/root/sudo.
  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_CONTENT_EXPANSION=

  # ── status (✓ / ✘) ─────────────────────────────────────────
  # The hallmark of the simple-theme look — keep the OK pill, kill SIGINT noise.
  typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true
  typeset -g POWERLEVEL9K_STATUS_OK=true
  typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=$green
  typeset -g POWERLEVEL9K_STATUS_OK_BACKGROUND=$pill_bg
  typeset -g POWERLEVEL9K_STATUS_OK_VISUAL_IDENTIFIER_EXPANSION='✓'
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE=true
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND=$green
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE_BACKGROUND=$pill_bg
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE_VISUAL_IDENTIFIER_EXPANSION='✓'
  typeset -g POWERLEVEL9K_STATUS_ERROR=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=$red
  typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=$pill_bg
  typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION='✘'
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND=$red
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_BACKGROUND=$pill_bg
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_VISUAL_IDENTIFIER_EXPANSION='✘'
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL=false
  typeset -g POWERLEVEL9K_STATUS_VERBOSE=false
  typeset -g POWERLEVEL9K_STATUS_HIDE_SIGNAME=true

  # ── dir ────────────────────────────────────────────────────
  typeset -g POWERLEVEL9K_DIR_BACKGROUND=$pill_bg
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=$blue
  typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=$muted
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=$blue
  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER='…'
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
  typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=40
  typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=50
  typeset -g POWERLEVEL9K_SHORTEN_FOLDER_MARKER='(.git|.hg|package.json|Cargo.toml|pyproject.toml|go.mod|deno.json)'

  typeset -g POWERLEVEL9K_HOME_ICON=
  typeset -g POWERLEVEL9K_HOME_SUB_ICON=
  typeset -g POWERLEVEL9K_FOLDER_ICON=
  typeset -g POWERLEVEL9K_ETC_ICON=
  typeset -g POWERLEVEL9K_DIR_HYPERLINK=false

  # ── vcs (git) ──────────────────────────────────────────────
  typeset -g POWERLEVEL9K_VCS_BACKGROUND=$pill_bg
  typeset -g POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=8192
  typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
  typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)
  typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND=$subtext
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=$green
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=$yellow
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=$peach
  typeset -g POWERLEVEL9K_VCS_CONFLICTED_FOREGROUND=$red

  # Minimal but expressive git formatter.
  #   main                — clean
  #   main ↑2 ↓1          — sync state
  #   main +3 ~2 ?1 *4    — staged / unstaged / untracked / stashed
  #   main ✕1             — conflicts
  function my_git_formatter() {
    emulate -L zsh
    if [[ -n $P9K_CONTENT ]]; then
      typeset -g my_git_format=$P9K_CONTENT
      return
    fi

    local res=''
    if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
      res+="${VCS_STATUS_LOCAL_BRANCH//\%/%%}"
    elif [[ -n $VCS_STATUS_TAG ]]; then
      res+="#${VCS_STATUS_TAG//\%/%%}"
    elif [[ -n $VCS_STATUS_COMMIT ]]; then
      res+="@${VCS_STATUS_COMMIT[1,8]}"
    fi

    (( VCS_STATUS_COMMITS_AHEAD  )) && res+=" ↑${VCS_STATUS_COMMITS_AHEAD}"
    (( VCS_STATUS_COMMITS_BEHIND )) && res+=" ↓${VCS_STATUS_COMMITS_BEHIND}"
    (( VCS_STATUS_STASHES        )) && res+=" *${VCS_STATUS_STASHES}"
    (( VCS_STATUS_NUM_CONFLICTED )) && res+=" ✕${VCS_STATUS_NUM_CONFLICTED}"
    (( VCS_STATUS_NUM_STAGED     )) && res+=" +${VCS_STATUS_NUM_STAGED}"
    (( VCS_STATUS_NUM_UNSTAGED   )) && res+=" ~${VCS_STATUS_NUM_UNSTAGED}"
    (( VCS_STATUS_NUM_UNTRACKED  )) && res+=" ?${VCS_STATUS_NUM_UNTRACKED}"

    typeset -g my_git_format=$res
  }
  functions -M my_git_formatter 2>/dev/null
  typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((my_git_formatter()))+${my_git_format}}'

  # ── background jobs ───────────────────────────────────────
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=$yellow
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND=$pill_bg
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VISUAL_IDENTIFIER_EXPANSION='⚙'

  # ── direnv ────────────────────────────────────────────────
  typeset -g POWERLEVEL9K_DIRENV_FOREGROUND=$yellow
  typeset -g POWERLEVEL9K_DIRENV_BACKGROUND=$pill_bg
  typeset -g POWERLEVEL9K_DIRENV_VISUAL_IDENTIFIER_EXPANSION='direnv'

  # ── node (project-only) ───────────────────────────────────
  typeset -g POWERLEVEL9K_NODE_VERSION_PROJECT_ONLY=true
  typeset -g POWERLEVEL9K_NODE_VERSION_FOREGROUND=$teal
  typeset -g POWERLEVEL9K_NODE_VERSION_BACKGROUND=$pill_bg
  typeset -g POWERLEVEL9K_NODE_VERSION_VISUAL_IDENTIFIER_EXPANSION='⬢'

  # ── aws (only when you actually use it) ───────────────────
  typeset -g POWERLEVEL9K_AWS_FOREGROUND=$sapphire
  typeset -g POWERLEVEL9K_AWS_BACKGROUND=$pill_bg
  typeset -g POWERLEVEL9K_AWS_VISUAL_IDENTIFIER_EXPANSION='aws'
  typeset -g POWERLEVEL9K_AWS_SHOW_ON_COMMAND='aws|terraform|cdk|sam|amplify|sst|serverless'

  # ── kubecontext (only when you actually use it) ───────────
  typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|k9s|stern|skaffold|kustomize|argocd|flux'
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_FOREGROUND=$sky
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_BACKGROUND=$pill_bg
  typeset -g POWERLEVEL9K_KUBECONTEXT_VISUAL_IDENTIFIER_EXPANSION='⎈'
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION='${P9K_KUBECONTEXT_CLUSTER//[^[:alnum:]_-]/_}${P9K_KUBECONTEXT_NAMESPACE:+/${P9K_KUBECONTEXT_NAMESPACE}}'

  # ── time ──────────────────────────────────────────────────
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=$muted
  typeset -g POWERLEVEL9K_TIME_BACKGROUND=$pill_bg
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'
  typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=true
  typeset -g POWERLEVEL9K_TIME_VISUAL_IDENTIFIER_EXPANSION=

  # ── perf & UX ─────────────────────────────────────────────
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=same-dir
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  (( ! $+functions[p10k] )) || p10k reload
}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
