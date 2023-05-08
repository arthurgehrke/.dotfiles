let g:startify_session_dir = '~/.config/nvim/session'

let g:startify_lists = [
      \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'files',     'header': ['   Files']            },
      \ { 'type': 'commands',  'header': ['   Commands']       },
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
\ ]

let g:startify_commands = [
\ { 'i': [ 'Install PLugins', ':PlugInstall' ] },
\ { 'u': [ 'Update PLugins', ':PlugUpdate' ] },
\ { 'u': [ 'Check Health', ':checkhealth' ] },
\ ]

