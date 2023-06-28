function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
  \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
  \ { 'type': 'commands',  'header': ['   Commands']       },
  \  { 'type': function('s:gitModified'),  'header': ['   git modified']},
  \  { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
  \ { 'type': 'files',     'header': ['   Files']            },
\ ]


let g:startify_skiplist = [
\ 'COMMIT_EDITMSG',
\ 'dbui',
\ ]

let g:startify_change_to_vcs_root = 1
let g:startify_change_to_dir = 1
let g:startify_session_persistence = 1
let g:startify_session_delete_buffers = 1
let g:startify_enable_special = 0

let g:startify_bookmarks = [
\ {'z': '~/.zshrc'},
\ {'t': '~/.tmux.conf'},
\ {'r': '~/repositores/doare/'},
\ {'p': '~/.config/nvim/init.vim'},
\ {'s': '~/.config/nvim/plugconf'},
\ {'z': '~/.zshrc' },
\ {'g': '~/.gitconfig' },
\ ]

let g:startify_commands = [
\ { 'i': [ 'Install PLugins', ':PlugInstall' ] },
\ { 'u': [ 'Update PLugins', ':PlugUpdate' ] },
\ { 'c': [ 'Clean PLugins', ':PlugClean' ] },
\ { 'h': [ 'Check Health', ':checkhealth' ] },
\ ]
