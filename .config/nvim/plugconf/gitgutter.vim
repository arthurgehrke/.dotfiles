let g:gitgutter_signs = 0
let g:gitgutter_highlight_linenrs=0
let g:gitgutter_highlight_lines = 0
let g:gitgutter_highlight_linenrs = 0
let g:gitgutter_set_sign_backgrounds=0
let g:gitgutter_preview_win_floating = 0

map <Space>gt :GitGutterToggle<CR>

command! Gqf GitGutterQuickFix | copen

