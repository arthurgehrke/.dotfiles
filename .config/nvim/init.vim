filetype on
filetype plugin on
filetype plugin indent on
syntax on
syntax enable

map <silent> <F1> :source $HOME/.config/nvim/init.vim<CR>

source $HOME/.config/nvim/keymapping.vim
source $HOME/.config/nvim/plugins.vim

" source $HOME/.config/nvim/plugconf/onedark.vim
source $HOME/.config/nvim/plugconf/gruvbox.vim
" source $HOME/.config/nvim/plugconf/nord.vim

source $HOME/.config/nvim/plugconf/vimcommentary.vim
source $HOME/.config/nvim/plugconf/fzfvim.vim
source $HOME/.config/nvim/plugconf/tagbar.vim
source $HOME/.config/nvim/plugconf/lsp.vim
source $HOME/.config/nvim/plugconf/gitsigns.vim
source $HOME/.config/nvim/plugconf/lualine.vim
source $HOME/.config/nvim/plugconf/airline.vim
source $HOME/.config/nvim/plugconf/indent_blankline.vim
source $HOME/.config/nvim/plugconf/better_whitespace.vim
source $HOME/.config/nvim/plugconf/nvim_tree.vim
source $HOME/.config/nvim/plugconf/better_scape.vim

set title
set shell=$SHELL
set updatetime=300
set clipboard+=unnamedplus
set encoding=utf-8
set autoread
set hidden
set nobuflisted

set nojoinspaces

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

set cmdheight=1
set noshowcmd
set noshowmode

set shortmess+=c
set previewheight=5
set pumheight=10                        
" set previewheight=10

set splitright
set splitbelow

" disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set autoindent
set copyindent
set smartindent

set nostartofline
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set nowrap                              

" stop highlighting matching pairs
let g:loaded_matchparen=1

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

" If vim is resized, resize any splits
autocmd VimResized * wincmd =
" More predictable syntax highlighting
autocmd BufEnter * syntax sync fromstart

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

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

" Also highlight all tabs and trailing whitespace characters.
" highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
" match ExtraWhitespace /\s\+$\|\t/
