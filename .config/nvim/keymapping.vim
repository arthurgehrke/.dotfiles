" save with :W and :w
cnoreabbrev W w
" quit with :Q and :q
cnoreabbrev Q q

nnoremap <Space>h :wincmd h <cr>
nnoremap <Space>j :wincmd j <cr>
nnoremap <Space>k :wincmd k <cr>
nnoremap <Space>l :wincmd l <cr>

" Open files relative to current path:
nnoremap <space>ed :edit <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <space>sp :split <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <space>vs :vsplit <C-R>=expand("%:p:h") . "/" <CR>

" Ctrl H and L will move to buffer
nnoremap <C-l>   :bnext<CR>
nnoremap <C-h>   :bprevious<CR>

" Edit alternate file with <leader><leader>. See `:help CTRL-^`.
" Note: `:bprevious` is different because it "wraps around".
nnoremap tt <c-^><CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

nnoremap <silent><C-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><C-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

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

"Opens a vertical split and switches over (\v)
nnoremap <space>sv <C-w>vs
"Opens a horizontal split and switches over (\v)
nnoremap <space>ss <C-w>v
" Closes the split
nnoremap <space>sx :close<CR>

" Easy window split; C-w v -> vv, C-w - s -> ss
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s
nnoremap <silent> sx :close<CR>

" lsp
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gvd <cmd>:vsplit<cr><cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gsd <cmd>:split<cr><cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <space>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <space>vrh :lua vim.lsp.buf.signature_help()<CR>
nnoremap go <c-o>
nnoremap <space>= :lua vim.lsp.buf.formatting()<CR>

" diff view
nnoremap <space>do :DiffviewOpen<CR>
nnoremap <space>dc :DiffviewClose<CR>
nnoremap <space>dh :DiffviewFileHistory<CR>
nnoremap <space>dt :DiffviewToggleFiles<CR>
nnoremap <silent><space>doc :DiffviewFileHistory %<CR>

" ale
nmap <space>af <Plug>(ale_fix)
nmap <space>al <Plug>(ale_lint)
nmap <space><space>ro :ALEFix<CR>
nmap <silent><space>ri :ALEImport<CR>
nmap <silent><space>ral :ALEOrganizeImports<cr>
nnoremap <space>ao :ALEOrganizeImports \| sleep 1 \| ALEFix<CR>
nnoremap K :ALEHover<CR>
nnoremap <space>e mF:%!eslint_d --stdin --fix-to-stdout<CR>`F
" Autofix visual selection with eslint_d:
vnoremap <space>e :!eslint_d --stdin --fix-to-stdout<CR>gv
" Expand %% to directory of current buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
