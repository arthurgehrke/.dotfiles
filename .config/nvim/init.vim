nnoremap <silent> <space>so :source $MYVIMRC<bar>echo "reloaded vimrc"<cr>

syntax on 
filetype indent off

source $HOME/.config/nvim/keymapping.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/themes.vim

set foldcolumn=0 " Remove sidebar column
set magic
set nofoldenable
set foldmethod=indent " Simple and fast
set cursorline
set cursorlineopt=screenline
set laststatus=1            " show the satus line all the time
set shell=$SHELL
set clipboard+=unnamedplus
set encoding=utf-8
set scrolloff=2         " Keep at least 2 lines above/below
set noswapfile
set nobackup
set hidden
set noincsearch
set ignorecase
set smartcase
set nofixendofline "avoid empty line in the end
set signcolumn=auto
set numberwidth=4
set number relativenumber
set hlsearch
set noshowcmd
set virtualedit=onemore   " Allow selecting beyond ends of lines in visual block mode
" set cmdheight=1
set noshowmode
set shortmess+=c
set previewheight=5
set pumheight=10
set smartindent
set nojoinspaces
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set splitbelow " when splitting horizontally, move coursor to lower pane
set splitright " when splitting vertically, mnove coursor to right pane
set noerrorbells
set noshowmatch


set backspace=indent,eol,start
set novisualbell
set shortmess-=S
set nostartofline
set timeout timeoutlen=1000 ttimeoutlen=50
set fileformats=unix,mac,dos
set completeopt=menuone,noselect
set selectmode=
set ttyfast                 " faster redrawing
set diffopt+=vertical
set wildmenu                " enhanced command line completion

highlight clear SignColumn

set nowrap 

set list lcs=trail:.,tab:-·,space:·

set undolevels=1000
set autoread
set undodir=~/.local/share/nvim/undo
set undofile
set nobackup		" do not keep a backup file, use versions instead

let mapleader="\<Space>"

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

function! TwoSpacesStyle()
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  set expandtab
endfunction

au BufNewFile,BufRead *.css call TwoSpacesStyle()
au BufNewFile,BufRead *.vim call TwoSpacesStyle()
au BufNewFile,BufRead *.html call TwoSpacesStyle()
au BufNewFile,BufRead *.js call TwoSpacesStyle()
au BufNewFile,BufRead *.ts call TwoSpacesStyle()
au BufNewFile,BufRead *.jsx call TwoSpacesStyle()
au BufNewFile,BufRead *.scss call TwoSpacesStyle()
au BufNewFile,BufRead *.yaml call TwoSpacesStyle()
au BufNewFile,BufRead *.yml call TwoSpacesStyle()

au BufRead,BufNewFile *.md          set ft=mkd tw=80 syntax=markdown
au BufRead,BufNewFile *.ppmd          set ft=mkd tw=80 syntax=markdown
au BufRead,BufNewFile *.markdown    set ft=mkd tw=80 syntax=markdown

" autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
" autocmd BufRead,BufNew *scss :setlocal filetype=css
autocmd bufnewfile,bufread *.tsx set filetype=typescript.tsx
autocmd bufnewfile,bufread *.jsx set filetype=javascript.jsx

" Prevent selecting and pasting from overwriting what you originally copied.
xnoremap p pgvy

" Prevent x and the delete key from overriding what's in the clipboard.
noremap x "_x
noremap X "_x
noremap <Del> "_x

" Keep cursor at the bottom of the visual selection after you yank it.
vmap y ygv<Esc>

" fzf with brew
set rtp+=/opt/homebrew/opt/fzf

if has('mac')
    " To setup Python for plugins that need it...
    " $ brew install python
    " $ brew install python3
    " $ pip2 install neovim --upgrade
    " $ pip3 install neovim --upgrade
    let g:python_host_prog='/usr/local/bin/python'
    " let g:python3_host_prog='/usr/local/bin/python3'
    let g:python3_host_prog = "python"
endif

let g:editorconfig_end_of_line = 'mac'

nnoremap <space>/ "fyiw :/<c-r>f<cr>


