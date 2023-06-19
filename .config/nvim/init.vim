nnoremap <silent> <space>so :source $MYVIMRC<bar>echo "reloaded vimrc"<cr>

syntax on " turn on syntax highlighting
filetype plugin indent on " allow plugins to use filetype indentation

source $HOME/.config/nvim/keymapping.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/themes.vim

set laststatus=2

set shell=$SHELL
set clipboard+=unnamedplus
set encoding=utf-8
set autoread
set scrolloff=2         " Keep at least 2 lines above/below
set hidden
set bufhidden=hide
set nobuflisted

set noswapfile
set nobackup
set noincsearch
set ignorecase

set nofixendofline "avoid empty line in the end
set hidden " buffer unlisted but still visible on screen
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
set noshowmatch
highlight clear SignColumn

" Set up persistent undo across all files.
set undolevels=2000
set undofile
set backupdir=$HOME/.config/nvim/tmp/backup
set dir=$HOME/.config/nvim/tmp/swap
set viewdir=$HOME/.config/nvim/tmp/view
if !isdirectory(&backupdir) | call mkdir(&backupdir, 'p', 0700) | endif
if !isdirectory(&dir)       | call mkdir(&dir, 'p', 0700)       | endif
if !isdirectory(&viewdir)   | call mkdir(&viewdir, 'p', 0700)   | endif

" Persist undo history between Vim sessions.
if has('persistent_undo')
  set undodir=$HOME/.config/nvim/tmp/undo
    if !isdirectory(&undodir) | call mkdir(&undodir, 'p', 0700) | endif
endif

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

function! FourSpacesStyle()
  set tabstop=4
  set softtabstop=-1
  set shiftwidth=4
  set expandtab
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

au BufRead,BufNewFile *.md          set ft=mkd tw=80 syntax=markdown
au BufRead,BufNewFile *.ppmd          set ft=mkd tw=80 syntax=markdown
au BufRead,BufNewFile *.markdown    set ft=mkd tw=80 syntax=markdown

autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
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

if has('mac')
    " To setup Python for plugins that need it...
    " $ brew install python
    " $ brew install python3
    " $ pip2 install neovim --upgrade
    " $ pip3 install neovim --upgrade
    let g:python_host_prog='/usr/local/bin/python'
    let g:python3_host_prog='/usr/local/bin/python3'
endif

let g:editorconfig_end_of_line = 'mac'


function! s:setup_git_messenger_popup() abort
    " Your favorite configuration here

    " For example, set go back/forward history to <C-o>/<C-i>
    nmap <buffer><C-o> o
    nmap <buffer><C-i> O
endfunction
autocmd FileType gitmessengerpopup call <SID>setup_git_messenger_popup()

nmap <space>gm <Plug>(git-messenger)

let g:git_messenger_include_diff= "all"
let g:git_messenger_floating_win_opts = { 'border': 'single' }
let g:git_messenger_popup_content_margins = v:false
let g:git_messenger_close_on_cursor_moved = v:false
let g:git_messenger_into_popup_after_show = v:true
let g:git_messenger_always_into_popup = v:true

inoremap <C-s> yo console.log()<Esc>p

inoremap <buffer> ,if if ()<cr>{<cr>}<esc>2k3==f)i
inoremap <buffer> ,fo for ()<cr>{<cr>}<esc>2k3==f)i
inoremap <buffer> ,cl console.log();<esc>F)i

nnoremap <buffer> <space>xl yiwoconsole.log();<esc>F(p
vnoremap <buffer> <space>xl yoconsole.log();<esc>F(p
