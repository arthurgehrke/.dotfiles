command! -bang -complete=buffer -nargs=? Bclose Bdelete<bang> <args>
" bbye
noremap <space>q :Bdelete<CR>
" alias bbye -> bclose
command! -bang -complete=buffer -nargs=? Ball Bdelete<bang> <args>
command! -bang -complete=buffer -nargs=? Bw Bwipeout<bang> <args>

