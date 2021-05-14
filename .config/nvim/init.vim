call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'neoclide/coc.nvim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tmux-plugins/tmux-yank'
call plug#end()

syntax enable

set hidden
set number
set relativenumber
set background=dark
set smarttab
set cindent
set tabstop=2
set shiftwidth=2
set expandtab

set title
set clipboard=unnamedplus

colorscheme gruvbox

nnoremap <Space>f :NERDTreeToggle <cr>

nnoremap <Space>h :wincmd h <cr>
nnoremap <Space>j :wincmd j <cr>
nnoremap <Space>k :wincmd k <cr>
nnoremap <Space>l :wincmd l <cr>

inoremap jk <ESC>

" Go to start of line with H and to the end with L
noremap H ^
noremap L $

" Yank and paste to system's clipboard
noremap <Space>y "+y
noremap <Space>p "+p
noremap <Space>P +P""


" NERDTree config
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeIgnore = ['^node_modules$']

" sync open file with NERDTree

" " Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

autocmd BufRead * call SyncTree()

" coc config
" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]

nmap <silent> gd <Plug>(coc-definition)
nnoremap go <c-o>

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>

" Airline config
let g:airline_theme = 'LanguageClient'
