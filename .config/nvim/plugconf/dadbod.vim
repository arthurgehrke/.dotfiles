
nnoremap <silent> <space>du :DBUI<CR>
nnoremap <silent> <space>qt :DBUIToggle<CR>
nnoremap <silent> <space>ql :DBUILastQueryInfo<CR>
nnoremap <silent> <space>df :DBUIFindBuffer<CR>
nnoremap <silent> <space>dy :DBUIYankCellValue<CR>
nnoremap <silent> <space>da :DBUISelectLine<CR>
nnoremap <silent> <space>dn :DBUIAddConnection<CR>
nnoremap <silent> <space>dr :DBUI_Redraw<CR>
nnoremap <silent> <space>djf :DBUI_JumpToForeignKey<CR>
nnoremap <silent> <space>dov :DBUI_SelectLineVsplit<CR>

autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
autocmd FileType sql vmap <buffer><silent><space>drq <Plug>(DBUI_ExecuteQuery)
autocmd FileType sql nmap <buffer><silent><space>drq <Plug>(DBUI_ExecuteQuery)
autocmd FileType sql nmap <buffer><silent><space>ds <Plug>(DBUI_SaveQuery)
autocmd FileType sql nmap <buffer><silent><space>da :DBUIFindBuffer<CR>

autocmd FileType dbui nmap <buffer> <S-k> <Plug>(DBUI_GotoFirstSibling)
autocmd FileType dbui nmap <buffer> <S-j> <Plug>(DBUI_GotoLastSibling)
autocmd FileType dbui nmap <buffer> k <up>
autocmd FileType dbui nmap <buffer> j <down>

nnoremap <silent> <space>dq :DBUI_Quit<CR>

let g:db_ui_execute_on_save=0
let g:db_ui_winwidth = 35
let g:db_ui_notification_width = 30
let g:db_ui_save_location = '~/.config/db_ui'
let g:db_ui_dotenv_variable_prefix= 'DB_UI_'
let g:db_ui_show_database_icon=1
let g:db_ui_use_nerd_fonts=1
" let g:db_ui_disable_mappings=1
let g:db_ui_execute_on_save=0
let g:db_ui_force_echo_notifications=1

autocmd BufRead,BufNewFile *.dbout set filetype=dbout

autocmd User DBUIOpened let b:dotenv = DotenvRead('.envrc') | norm R
function! s:expand(expr) abort
  return exists('*DotenvExpand') ? DotenvExpand(a:expr) : expand(a:expr)
endfunction
