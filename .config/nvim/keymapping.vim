" save with :W and :w
cnoreabbrev W w
" quit with :Q and :q
cnoreabbrev Q q

nnoremap <Space>h :wincmd h <cr>
nnoremap <Space>j :wincmd j <cr>
nnoremap <Space>k :wincmd k <cr>
nnoremap <Space>l :wincmd l <cr>

" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" TAB in general mode will move to buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Insert new line without entering insert mode
nnoremap <silent> [<space>  :<c-u>put!=repeat([''],v:count)<bar>']+1<cr>
nnoremap <silent> ]<space>  :<c-u>put =repeat([''],v:count)<bar>'[-1<cr>
" nmap <S-CR> O<Esc>
" nmap <CR> o<Esc>

" Go to start of line with H and to the end with L
noremap H ^
noremap L $

" split screen
noremap <Space>s :<C-u>split<CR>
noremap <Space>v :<C-u>vsplit<CR>

" open new tab
nnoremap <Space>a :tabnew<CR>
" go to next tab
nnoremap <Space>an :tabnext<CR>
" go to previous tab
nnoremap <Space>ap :tabprevious<CR>
" close tab
nnoremap <Space>ac :tabclose<CR>

" close all buffers but the current one
command! BufOnly execute '%bdelete|edit #|normal `"'

" jumps from buffers
nnoremap <silent> <space><C-o> :call jumps#fileCO(v:true)<CR>
nnoremap <silent> <space><C-i> :call jumps#fileCO(v:false)<CR>

" Substitute the word under the cursor.
nmap <space>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Insert common snippets
inoremap <C-c> console.log(
inoremap <C-d> describe('', () => {});<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
inoremap <C-t> test('', () => {});<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

nnoremap <space>+ :vertical resize +5<CR>
nnoremap <space>- :vertical resize -5<CR>
nnoremap <space>rp :resize 100<CR>

" highlight and search word
function! s:getSelectedText()
  let l:old_reg = getreg('"')
  let l:old_regtype = getregtype('"')
  norm gvy
  let l:ret = getreg('"')
  call setreg('"', l:old_reg, l:old_regtype)
  exe "norm \<Esc>"
  return l:ret
endfunction

vnoremap <silent> * :call setreg("/",
    \ substitute(<SID>getSelectedText(),
    \ '\_s\+',
    \ '\\_s\\+', 'g')
    \ )<Cr>n

vnoremap <silent> # :call setreg("?",
    \ substitute(<SID>getSelectedText(),
    \ '\_s\+',
    \ '\\_s\\+', 'g')
    \ )<Cr>n
