" save with :W and :w
cnoreabbrev W w
" quit with :Q and :q
cnoreabbrev Q q

" Save as root
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

nnoremap <Space>h :wincmd h <cr>
nnoremap <Space>j :wincmd j <cr>
nnoremap <Space>k :wincmd k <cr>
nnoremap <Space>l :wincmd l <cr>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" TAB in general mode will move to buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

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

" Insert new line without entering insert mode
nnoremap <space>bL cc<ESC>
" Blank line above
nnoremap <space>bq mzO<ESC>`z
" Blank line below
nnoremap <space>bt mzo<ESC>`z

nnoremap <space>cd :NvimTreeOpen %:p:h<CR>
nnoremap <space>dc :exec('NvimTreeOpen ' . trim(system('git rev-parse --show-toplevel')))<CR>
"""""""""""""""""""""
" Change to directory of current file, and then print the working
" directory
"""""""""""""""""""""
nnoremap <space>cD :lcd %:p:h<CR>:pwd<CR>

" Toggle relative line numbers and regular line numbers.
nnoremap <leader>tt :set relativenumber!<CR>
inoremap <leader>tt <C-o>:set relativenumber!<CR>

" Go to start of line with H and to the end with L
noremap H ^
noremap L $

" close all buffers but the current one
command! BufOnly execute '%bdelete|edit #|normal `"'

" jumps from buffers
" nnoremap <silent> <space><C-o> :call jumps#fileCO(v:true)<CR>
" nnoremap <silent> <space><C-i> :call jumps#fileCO(v:false)<CR>

" Insert common snippets
inoremap <C-c> console.log(
inoremap <C-d> describe('', () => {});<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
inoremap <C-t> test('', () => {});<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

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
