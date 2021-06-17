"*****************************************************************************
" Plugins
"*****************************************************************************
call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-rooter'

Plug 'tpope/vim-fugitive'

Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tmux-plugins/vim-tmux'

Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'maxmellon/vim-jsx-pretty'

Plug 'styled-components/vim-styled-components'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()
"*****************************************************************************
" Nvim config
"*****************************************************************************
syntax enable

set shell=$SHELL
set title
set encoding=utf-8
set relativenumber
set hidden
set smarttab
set expandtab
set tabstop=2
set shiftwidth=4
set showtabline=2
set nowrap                              


set nobackup
set nowritebackup
set noswapfile

" Search
set ignorecase " case insensitive searching
set smartcase " case-sensitive if expresson contains a capital letter
set hlsearch " highlight search results
set incsearch " set incremental search, like modern browsers

set shortmess+=c
set pumheight=10                        " Makes popup menu smaller

set clipboard+=unnamedplus
set copyindent

" open new split panes to right and below
set splitright
set splitbelow

" set cmdheight=1 " command bar height
set noshowcmd
" set nolazyredraw " don't redraw while executing macros
" set noshowmode " don't show which mode disabled for PowerLine
" set laststatus=0
" set noruler
" set inccommand=nosplit

autocmd FileType tagbar,nerdtree setlocal signcolumn=no
highlight clear SignColumn
set signcolumn=number
" signcolumn margin
set numberwidth=4

set termguicolors
set background=dark
" autocmd ColorScheme * highlight! link SignColumn LineNr
colorscheme gruvbox

map <silent> <F1> :source $HOME/.config/nvim/init.vim<CR>

nnoremap <Space>h :wincmd h <cr>
nnoremap <Space>j :wincmd j <cr>
nnoremap <Space>k :wincmd k <cr>
nnoremap <Space>l :wincmd l <cr>

" autocmd FileType qf setlocal wrap linebreak nolist breakindent breakindentopt=shift:2
inoremap jk <ESC>
inoremap kj <ESC>
inoremap JK <ESC>
inoremap jj <ESC>

" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" If vim is resized, resize any splits
autocmd VimResized * wincmd =
" Wrap lines in quickfix windows
autocmd FileType qf setlocal wrap linebreak nolist breakindent breakindentopt=shift:2
" More predictable syntax highlighting
autocmd BufEnter * syntax sync fromstart
" Automatically close preview windows after autocompletion
autocmd CompleteDone * pclose

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Insert new line without entering insert mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Go to start of line with H and to the end with L
noremap H ^
noremap L $

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

" space to clear search highlights
noremap <space> :set hlsearch! hlsearch?<cr>

" Update a buffer's contents on focus if it changed outside of Vim.
au FocusGained,BufEnter * :checktime

" Ensure tabs don't get converted to spaces in Makefiles.
autocmd FileType make setlocal noexpandtab

" Only show the cursor line in the active buffer.
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

"*****************************************************************************
" Commands
"*****************************************************************************
" close all buffers
command! Bdall %bd|e#|bd#"

"*****************************************************************************
" Mappings
"*****************************************************************************
" split screen
noremap <Leader>t :<C-u>split<CR>
noremap <Leader>s :<C-u>vsplit<CR>

" open new tab
nnoremap <leader>aa :tabnew<CR>
" go to next tab
nnoremap <leader>an :tabnext<CR>
" go to previous tab
nnoremap <leader>ap :tabprevious<CR>
" close tab
nnoremap <leader>ac :tabclose<CR>

" search file on actual dir
nnoremap <silent> <leader>pf :Files<CR>
" search into files 
nnoremap <leader>ps :Find 
" search text on cursor files
nnoremap <leader>pe :Find <c-r>=expand("<cword>")<CR><CR>

"*****************************************************************************
" Plugins Config
"*****************************************************************************
" NERDTree 
"*****************************************************************************
nnoremap <Space>f :NERDTreeToggle <cr>

let g:NERDTreeIgnore = ['^node_modules$', '\.git$']
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
" Automatically close NerdTree when you open a file
let g:NERDTreeQuitOnOpen = 1
" Automatically delete the buffer of the file you just deleted with NerdTree
" let g:NERDTreeAutoDeleteBuffer = 1
" let g:NERDTreeWinSize = 30

" Prevent buffers dont open on NERDTree buffer
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" sync open file with NERDTree
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncTree()

"*****************************************************************************
" NERDTree Git 
"*****************************************************************************
let g:NERDTreeGitStatusIndicatorMapCustom = {
	\ 'Modified'  :'✹',
	\ 'Staged'    :'✚',
	\ 'Untracked' :'✭',
	\ 'Renamed'   :'➜',
	\ 'Unmerged'  :'═',
	\ 'Deleted'   :'✖',
	\ 'Dirty'     :'✗',
	\ 'Ignored'   :'☒',
	\ 'Clean'     :'✔︎',
	\ 'Unknown'   :'?',
	\ }

"*****************************************************************************
" GitGutter  
"*****************************************************************************
let g:gitgutter_sign_column_always = 1
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

"*****************************************************************************
" Coc 
"*****************************************************************************
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nnoremap go <c-o>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" COC-VIM TAB SETTINGS START
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" coc diagnostics theme
autocmd FileType json syntax match Comment +\/\/.\+$+

highlight Error            ctermbg=161
highlight ErrorMsg         NONE
highlight link ErrorMsg    Error
hi! CocErrorSign guifg=#d1666a

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>

" Add CoC Prettier if prettier is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

" Add CoC ESLint if ESLint is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

"*****************************************************************************
" Airline 
"*****************************************************************************
let g:airline_theme = 'onedark'

" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

" enable powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''

"*****************************************************************************
" Vim Commentary 
"*****************************************************************************
nnoremap <space>/ :Commentary<CR>
vnoremap <space>/ :Commentary<CR>

"*****************************************************************************
" Fzf 
"*****************************************************************************
" default
nnoremap <C-p> :FZF<CR>
" search into files with silver search (install with apt)
nnoremap <C-f> :Rg<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'app/cache/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

if executable('rg')
    let ignored_files = '--glob "!.git/*" --glob "!node_modules/*" --glob "!app/cache/*" --glob "!app/logs/*" --glob "!web/uploads/*" --glob "!web/bundles/*" --glob "!tags" --glob "!web/css/*" --glob "!web/js/*" --glob "!var/logs/*" --glob "!var/cache/*" --glob "!elm-stuff/*"'
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --no-ignore --follow '.ignored_files
    set grepprg=rg\ --vimgrep
    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --no-ignore --follow '.ignored_files.' --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

"*****************************************************************************
" Vim-jsx 
"*****************************************************************************
let g:jsx_ext_required = 1

" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

