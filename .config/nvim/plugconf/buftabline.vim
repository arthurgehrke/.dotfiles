" Make vim-buftabline show buffer numbers next to names.
let g:buftabline_numbers = 1
let g:buftabline_indicators = 1
let g:buftabline_numbers = 2 " idx of buffer
let g:buftabline_modified_char = ""
let g:buftabline_show = 1  "only if there are at least two buffers

highlight BufTabLineCurrent ctermbg=192 ctermfg=0
highlight BufTabLineHidden ctermbg=235 ctermfg=191
highlight BufTabLineModifiedCurrent ctermfg=0 ctermbg=168
highlight BufTabLineModifiedActive ctermfg=0 ctermbg=214
highlight BufTabLineModifiedHidden ctermfg=0 ctermbg=222

" hi BufTabLineCurrent ctermbg=234 ctermfg=12 cterm=NONE
" hi BufTabLineActive ctermbg=232 ctermfg=12 cterm=NONE
" hi BufTabLineHidden ctermbg=232 ctermfg=12 cterm=NONE
" hi BufTabLineFill ctermbg=232 ctermfg=12 cterm=NONE

hi NvimTreeStatusLineNC ctermbg=black ctermfg=black
hi NvimTreeStatusLine ctermbg=black ctermfg=black

au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
