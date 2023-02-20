nnoremap <space>so :source $HOME/.config/nvim/init.vim<cr>

syntax on " turn on syntax highlighting
filetype plugin indent on " allow plugins to use filetype indentation

source $HOME/.config/nvim/keymapping.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/themes.vim

set title
set shell=$SHELL
set clipboard+=unnamedplus
set encoding=utf-8
set autoread
set hidden
set scrolloff=2         " Keep at least 2 lines above/below
set lazyredraw
syntax sync minlines=256
" set redrawtime=10000
" set timeoutlen=400
" set ttimeoutlen=10
" set updatetime=100

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set noincsearch
set ignorecase
set smartcase 

set nobuflisted " buffer unlisted but still visible on screen
set signcolumn=auto
set numberwidth=4
set number relativenumber
set cursorline
set hlsearch
set virtualedit=block   " Allow selecting beyond ends of lines in visual block mode
set cmdheight=1
set noshowcmd
set noshowmode
set shortmess+=c
set previewheight=5
set pumheight=10
set autoindent
set copyindent
set smartindent
set nojoinspaces
set smarttab
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set nowrap
set splitbelow " when splitting horizontally, move coursor to lower pane
set splitright " when splitting vertically, mnove coursor to right pane
set noerrorbells
set backspace=indent,eol,start
highlight clear SignColumn

let mapleader =" "

" stop highlighting matching pairs
let g:loaded_matchparen=1

" highlight from start of file
autocmd BufEnter * :syntax sync fromstart

" disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" If vim is resized, resize any splits
autocmd VimResized * wincmd =

augroup vimrc-remember-cursor-position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

augroup numbertoggle
    autocmd!
    au WinEnter set norelativenumber
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

function! FourSpacesStyle()
  set tabstop=4
  set softtabstop=-1
  set shiftwidth=4
  set expandtab
  " set backspace=indent,eol,start
  " set indentexpr=-1
endfunction

function! TwoSpacesStyle()
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  set smartindent
  set expandtab
endfunction

function! TabStyle()
  set noexpandtab
  set tabstop=4
  set softtabstop=4
  set shiftwidth=4
endfunction

au BufNewFile,BufRead *.cs call FourSpacesStyle()
au BufNewFile,BufRead *.css call TwoSpacesStyle()
au BufNewFile,BufRead *.html call TwoSpacesStyle()
au BufNewFile,BufRead *.js call TwoSpacesStyle()
au BufNewFile,BufRead *.ts call TwoSpacesStyle()
au BufNewFile,BufRead *.jsx call TwoSpacesStyle()
au BufNewFile,BufRead *.scss call TwoSpacesStyle()
au BufNewFile,BufRead *.yaml call TwoSpacesStyle()
au BufNewFile,BufRead *.yml call TwoSpacesStyle()

au BufRead,BufNewFile *.nginx set ft=nginx
au BufRead,BufNewFile */etc/nginx/* set ft=nginx
au BufRead,BufNewFile */usr/local/nginx/conf/* set ft=nginx
au BufRead,BufNewFile nginx.conf set ft=nginx

au BufRead,BufNewFile *.md          set ft=mkd tw=80 syntax=markdown
au BufRead,BufNewFile *.ppmd          set ft=mkd tw=80 syntax=markdown
au BufRead,BufNewFile *.markdown    set ft=mkd tw=80 syntax=markdown

autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
autocmd BufRead,BufNew *scss :setlocal filetype=css

" Prevent selecting and pasting from overwriting what you originally copied.
xnoremap p pgvy

" clear highlighting if edit text
inoremap <expr> <Plug>(StopHL) execute('nohlsearch')[-1]
fu! StopHL()
  if !v:hlsearch || mode() isnot 'n'
    return
  endif
  sil call feedkeys("\<Plug>(StopHL)", 'm')
endfu
au InsertEnter * call StopHL()

" Prevent x and the delete key from overriding what's in the clipboard.
noremap x "_x
noremap X "_x
noremap <Del> "_x

" Keep cursor at the bottom of the visual selection after you yank it.
vmap y ygv<Esc>

" fzf with brew 
set rtp+=/opt/homebrew/opt/fzf

set nolist " do not display white characters
set noeol " show if there's no eol char
set showbreak=↪ " character to show when line is broken


" more natural movement with wrap on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv
