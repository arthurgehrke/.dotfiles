function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
  \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
  \ { 'type': 'commands',  'header': ['   Commands']       },
  \  { 'type': function('s:gitModified'),  'header': ['   git modified']},
  \  { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
  \ { 'type': 'files',     'header': ['   Files']            },
\ ]

let g:startify_skiplist = [
\ 'COMMIT_EDITMSG',
\ 'dbui',
\ ]

let g:startify_commands = [
\ { 'i': [ 'Install PLugins', ':PlugInstall' ] },
\ { 'u': [ 'Update PLugins', ':PlugUpdate' ] },
\ { 'c': [ 'Clean PLugins', ':PlugClean' ] },
\ { 'h': [ 'Check Health', ':checkhealth' ] },
\ ]

let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1

