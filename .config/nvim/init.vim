map <silent> <F1> :source $HOME/.config/nvim/init.vim<CR>

source $HOME/.config/nvim/keymapping.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/themes.vim

filetype indent on " use filetype indentation
filetype plugin indent on " allow plugins to use filetype indentation
syntax on " turn on syntax highlighting
syntax enable

set title
set shell=$SHELL
set updatetime=300
set clipboard+=unnamedplus
set encoding=utf-8
set autoread
set hidden
" buffer unlisted but still visible on screen
set nobuflisted

set signcolumn=auto
set numberwidth=4
highlight clear SignColumn

set number relativenumber
set cursorline

set nobackup
set nowritebackup
set noswapfile

set ignorecase 
set smartcase 
set hlsearch 
set incsearch 
" time redrawing the display to hlsearch
set redrawtime=10000

set cmdheight=1
set noshowcmd
set noshowmode

set shortmess+=c
set previewheight=5
set pumheight=10

set splitright
set splitbelow

set autoindent
set nocompatible

set copyindent
set smartindent
set nojoinspaces

set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set nowrap

" improve fold explorer
set viewoptions-=curdir

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
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

autocmd FileType tagbar setlocal signcolumn=no

function! FourSpacesStyle()
  set tabstop=4
  set softtabstop=-1
  set shiftwidth=4
  set expandtab
  set backspace=indent,eol,start 
  set indentexpr=-1
endfunction

function! TwoSpacesStyle()
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
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

" WSL clipboard with win32yank
let g:clipboard = {
	\   'name': 'win32yank-wsl',
	\   'copy': {
	\      '+': 'win32yank.exe -i --crlf',
	\      '*': 'win32yank.exe -i --crlf',
	\    },
	\   'paste': {
	\      '+': 'win32yank.exe -o --lf',
	\      '*': 'win32yank.exe -o --lf',
	\   },
	\   'cache_enabled': 0,
  \ }

" clear highlighting if edit text
inoremap <expr> <Plug>(StopHL) execute('nohlsearch')[-1]
fu! StopHL()
    if !v:hlsearch || mode() isnot 'n'
        return
    endif
    sil call feedkeys("\<Plug>(StopHL)", 'm')
endfu
au InsertEnter * call StopHL()
