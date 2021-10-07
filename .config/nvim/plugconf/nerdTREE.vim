nnoremap <expr> <space>f g:NERDTree.IsOpen() ? ':NERDTreeClose<cr>' : ':NERDTreeFind<cr>'
nnoremap <expr> <space>F g:NERDTree.IsOpen() ? ':NERDTreeClose<cr>' : ':NERDTreeVCS<cr>'

let g:NERDTreeIgnore = ['^node_modules$', '\.git$']
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeWinSize = 35

" if it is set to 0 then the CWD is never changed by the NERD tree.
" let g:NERDTreeChDirMode=0
let g:NERDTreeChDirMode=2
"
" call NERDTreeAddKeyMap({
"             \ 'key':           '_C',
"             \ 'callback':      'NERDTreeEnterDirectoryAndCD',
"             \ 'quickhelpText': 'Enter directory and cd into it' })

" function! NERDTreeEnterDirectoryAndCD()
"   let node = g:NERDTreeDirNode.GetSelected()

"   exec 'cd ' . node.path.str({'format': 'Cd'})
"   NERDTreeCWD
" endfunction

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Prevent buffers dont open on NERDTree buffer
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif


