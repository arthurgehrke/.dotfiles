" save with :W and :w
cnoreabbrev W w
" quit with :Q and :q
cnoreabbrev Q q

" Save as root
" cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

nnoremap <Space>h :wincmd h <cr>
nnoremap <Space>j :wincmd j <cr>
nnoremap <Space>k :wincmd k <cr>
nnoremap <Space>l :wincmd l <cr>

" Open files relative to current path:
nnoremap <space>ed :edit <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <space>sp :split <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <space>vs :vsplit <C-R>=expand("%:p:h") . "/" <CR>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" TAB in general mode will move to buffer
" nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
" nnoremap <S-TAB> :bprevious<CR>

" Ctrl H and L will move to buffer
nnoremap <C-l>   :bnext<CR>
nnoremap <C-h>   :bprevious<CR>

" Edit alternate file with <leader><leader>. See `:help CTRL-^`.
" Note: `:bprevious` is different because it "wraps around".
nnoremap <space><space> <c-^>

" Don't jump when using * for search
" nnoremap * *<c-o>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <space>ss :call StripWhitespace()<CR>

nnoremap <silent><C-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><C-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

nnoremap <space>cd :NvimTreeOpen %:p:h<CR>
nnoremap <space>dc :exec('NvimTreeOpen ' . trim(system('git rev-parse --show-toplevel')))<CR>
"""""""""""""""""""""
" Change to directory of current file, and then print the working
" directory
"""""""""""""""""""""
nnoremap <space>cD :lcd %:p:h<CR>:pwd<CR>

" Toggle relative line numbers and regular line numbers.
nnoremap <space>tt :set relativenumber!<CR>

" Go to start of line with H and to the end with L
noremap H ^
noremap L $

" close all buffers but the current one
command! BufOnly execute '%bdelete|edit #|normal `"'

" Search for visually-selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Don't jump when using * for search
" nnoremap * *<c-o>

" get file name on clipboard
nnoremap <space>fn :let @*=expand("%:t")<CR>
"Opens a vertical split and switches over (\v)
nnoremap <space>sv <C-w>vs
"Opens a horizontal split and switches over (\v)
nnoremap <space>ss <C-w>v
" Closes the split
nnoremap <space>sx :close<CR>

nnoremap <space>cp :let @" = expand("%")<cr>

" Easy window split; C-w v -> vv, C-w - s -> ss
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s
nnoremap <silent> sx :close<CR>

" if !exists("*DeleteHiddenBuffers") " Clear all hidden buffers when running 
" 	function DeleteHiddenBuffers() " Vim with the 'hidden' option
" 		let tpbl=[]
" 		call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
" 		for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
" 			silent execute 'bwipeout' buf
" 		endfor
" 	endfunction
" endif
" command! DeleteHiddenBuffers call DeleteHiddenBuffers()
