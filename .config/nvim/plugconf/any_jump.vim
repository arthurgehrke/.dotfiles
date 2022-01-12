" Normal mode: Jump to definition under cursor
nnoremap <space>j :AnyJump<CR>

" Visual mode: jump to selected text in visual mode
xnoremap <space>j :AnyJumpVisual<CR>

" Normal mode: open previous opened file (after jump)
nnoremap <space>ab :AnyJumpBack<CR>

" Normal mode: open last closed search window again
nnoremap <space>al :AnyJumpLastResults<CR>
