" save with :W and :w
cnoreabbrev W w
" quit with :Q and :q
cnoreabbrev Q q

inoremap jk <ESC>
inoremap kj <ESC>
inoremap JK <ESC>
inoremap jj <ESC>

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
