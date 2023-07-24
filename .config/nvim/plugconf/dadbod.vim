nnoremap <silent> <space>qt :DBUIToggle<CR>
nnoremap <silent> <space>du :DBUIToggle<CR>
nnoremap <silent> <space>ql :DBUILastQueryInfo<CR>
nnoremap <silent> <space>df :DBUIFindBuffer<CR>
" nnoremap <silent> <space>dl :DBUI_ToggleResultLayout<CR>
nnoremap <silent> <space>dl :DBUI_JumpToForeignKey<CR>
nnoremap <silent> <space>dy :DBUI_YankCellValue<CR>
nnoremap <silent> <space>dj :DBUI_SelectLineVsplit<CR>
nnoremap <silent> <space>da :DBUI_SelectLine<CR>
nnoremap <silent> <space>dn :DBUIAddConnection<CR>
nnoremap <silent> <space>ds :DBUI_SaveQuery<CR>
nmap <space>ds <Plug>(DBUI_SaveQuery)

let g:db_ui_save_location = '~/.config/db_ui'
" let g:db_ui_show_help = 0
let g:db_ui_winwidth = 25
let g:db_ui_icons = {
      \ 'expanded': '▾',
      \ 'collapsed': '▸',
      \ 'saved_query': '*',
      \ 'new_query': '',
      \ 'tables': '',
      \ 'buffers': '»',
      \ 'connection_ok': '✓',
      \ 'connection_error': '✕',
      \ }

let g:db_ui_dotenv_variable_prefix= 'DB_UI_'
let g:db_ui_auto_execute_table_helpers = 1
let g:db_ui_table_helpers = {
\   'postgresql': {
\     'List': 'select * from "{table}" order by id asc LIMIT 20'
\   }
\ }
let g:db_ui_default_query = 'select * from "{table}" limit 10'

autocmd FileType dbui nmap <buffer> v <Plug>(DBUI_SelectLineVsplit)
autocmd FileType dbui nmap <buffer> s <Plug>(DBUI_SelectLine)
autocmd BufRead,BufNewFile *.dbout set filetype=dbout

function! s:expand(expr) abort
  return exists('*DotenvExpand') ? DotenvExpand(a:expr) : expand(a:expr)
endfunction

let g:dbs = {
      \ }


