" let g:gitgutter_sign_added = ''
" let g:gitgutter_sign_modified = ''
" let g:gitgutter_sign_removed = ''
" let g:gitgutter_sign_removed_first_line = ''
" let g:gitgutter_sign_modified_removed = ''
let g:gitgutter_signs = 0
let g:gitgutter_highlight_linenrs=0
let g:gitgutter_highlight_lines = 0
let g:gitgutter_highlight_linenrs = 0
let g:gitgutter_set_sign_backgrounds=0
let g:gitgutter_preview_win_floating = 0

map <Space>gt :GitGutterToggle<CR>


command! Gqf GitGutterQuickFix | copen

" disable folding to git files
" autocmd BufWritePost,BufEnter * set nofoldenable foldmethod=manual foldlevelstart=99

