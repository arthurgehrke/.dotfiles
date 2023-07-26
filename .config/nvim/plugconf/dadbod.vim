let g:db_ui_use_nerd_fonts=1
let g:db_ui_show_database_icon=1
let g:db_ui_auto_execute_table_helpers=1

nnoremap <silent> <space>du :DBUI<CR>
nnoremap <silent> <space>qt :DBUIToggle<CR>
nnoremap <silent> <space>ql :DBUILastQueryInfo<CR>
nnoremap <silent> <space>df :DBUIFindBuffer<CR>
nnoremap <silent> <space>dl :DBUI_JumpToForeignKey<CR>
nnoremap <silent> <space>dy :DBUI_YankCellValue<CR>
nnoremap <silent> <space>dj :DBUI_SelectLineVsplit<CR>
nnoremap <silent> <space>da :DBUI_SelectLine<CR>
nnoremap <silent> <space>dn :DBUIAddConnection<CR>
nnoremap <silent> <space>dn :DBUIAddConnection<CR>
nnoremap <silent> <space>de :DBUI_SelectLineVsplit<CR>

let g:db_ui_winwidth = 35
let g:db_ui_save_location = '~/.config/db_ui'
let g:db_ui_dotenv_variable_prefix= 'DB_UI_'
let g:db_ui_auto_execute_table_helpers = 1

autocmd BufRead,BufNewFile *.dbout set filetype=dbout
autocmd User DBUIOpened let b:dotenv = DotenvRead('.envrc') | norm R

