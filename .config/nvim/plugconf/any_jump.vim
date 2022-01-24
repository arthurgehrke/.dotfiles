let g:any_jump_disable_default_keybindings = 1

" Normal mode: Jump to definition under cursor
nnoremap <space>jp :AnyJump<CR>

" Visual mode: jump to selected text in visual mode
xnoremap <space>jp :AnyJumpVisual<CR>

" Normal mode: open previous opened file (after jump)
nnoremap <space>ab :AnyJumpBack<CR>

" Normal mode: open last closed search window again
nnoremap <space>al :AnyJumpLastResults<CR>
