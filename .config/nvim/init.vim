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

" Plug 'puremourning/vimspector'

Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'maxmellon/vim-jsx-pretty'

Plug 'OmniSharp/omnisharp-vim'

Plug 'styled-components/vim-styled-components'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()
"*****************************************************************************
" Nvim config
"*****************************************************************************
syntax enable
filetype plugin on

set shell=$SHELL
set title
set encoding=utf-8
set number
set relativenumber
set hidden
set nowrap                              

set autoindent
set copyindent
set smarttab

autocmd BufRead *.js,*.ts setlocal tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
autocmd BufRead *.json setlocal tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
autocmd BufRead *.cs,*.aspx setlocal tabstop=4 shiftwidth=4 softtabstop=-1 expandtab backspace=indent,eol,start indentexpr=-1

set nobackup
set nowritebackup
set noswapfile

set ignorecase " case insensitive searching
set smartcase " case-sensitive if expresson contains a capital letter
set hlsearch " highlight search results
set incsearch " set incremental search, like modern browsers

set shortmess+=c
set cmdheight=2

set previewheight=5
" set pumheight=10                        " Makes popup menu smaller
" set previewheight=10

set clipboard+=unnamedplus

set splitright
set splitbelow

" set cmdheight=1 " command bar height
" set noshowcmd

autocmd FileType tagbar,nerdtree setlocal signcolumn=no
highlight clear SignColumn
set signcolumn=number
set numberwidth=4

set termguicolors
set background=dark
colorscheme gruvbox

map <silent> <F1> :source $HOME/.config/nvim/init.vim<CR>

" save with :W and :w
cnoreabbrev W w
" quit with :Q and :q
cnoreabbrev Q q

nnoremap <Space>h :wincmd h <cr>
nnoremap <Space>j :wincmd j <cr>
nnoremap <Space>k :wincmd k <cr>
nnoremap <Space>l :wincmd l <cr>

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
" More predictable syntax highlighting
autocmd BufEnter * syntax sync fromstart
" Automatically close preview windows after autocompletion
autocmd CompleteDone * pclose

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" TAB in general mode will move to buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>
" close all buffers but the current one
command! BufOnly execute '%bdelete|edit #|normal `"'

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Insert new line without entering insert mode
" nmap <S-CR> O<Esc>
" nmap <CR> o<Esc>
nnoremap <silent> [<space>  :<c-u>put!=repeat([''],v:count)<bar>']+1<cr>
nnoremap <silent> ]<space>  :<c-u>put =repeat([''],v:count)<bar>'[-1<cr>

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

" Only show the cursor line in the active buffer.
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

"*****************************************************************************
" Commands
"*****************************************************************************

"*****************************************************************************
" Mappings
"*****************************************************************************
" split screen
noremap <Leader>t :<C-u>split<CR>
noremap <Leader>s :<C-u>vsplit<CR> 

" open new tab
nnoremap <leader>a :tabnew<CR>
" go to next tab
nnoremap <leader>an :tabnext<CR>
" go to previous tab
nnoremap <leader>ap :tabprevious<CR>
" close tab
nnoremap <Space>ac :tabclose<CR>

"*****************************************************************************
" Plugins Config
"*****************************************************************************
" NERDTree 
"*****************************************************************************
nnoremap <Space>f :NERDTreeToggle <cr>
nnoremap <Space>t :Files <cr>
nnoremap <Space>g :GFiles<cr>

let g:NERDTreeIgnore = ['^node_modules$', '\.git$']
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
" Automatically close NerdTree when you open a file
let g:NERDTreeQuitOnOpen = 1
" Automatically delete the buffer of the file you just deleted with NerdTree
" let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeWinSize = 30

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
" function! SyncTree()
"   if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
"     NERDTreeFind
"     wincmd p
"   endif
" endfunction

" " Highlight currently open buffer in NERDTree
" autocmd BufRead * call SyncTree()

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
  \ 'coc-prettier'
  \ ]

" nmap <silent> gd :call CocActionAsync('jumpDefinition')<CR>
" nmap <silent> gs :call CocActionAsync('jumpDefinition', 'split')<CR>
autocmd FileType ts nmap <silent> gd :call CocActionAsync('jumpDefinition')<CR>
autocmd FileType ts,js nmap <silent> gd <Plug>(coc-definition)
autocmd FileType html nmap <silent> gd :call CocActionAsync('jumpDefinition')<CR>
autocmd FileType ts,js nmap <silent> gy <Plug>(coc-type-definition)
autocmd FileType ts,js nmap <silent> gi <Plug>(coc-implementation)
autocmd FileType ts,js nmap <silent> gr <Plug>(coc-references)
autocmd FileType ts,js nnoremap go <c-o>

" Add CoC Prettier if prettier is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

" Add CoC ESLint if ESLint is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

"*****************************************************************************
" OmniSharp 
"*****************************************************************************
filetype indent plugin on
nnoremap gr :<C-u>pedit %<Bar>wincmd P<Bar>norm! gd<Bar>wincmd p<CR>
autocmd FileType cs nmap <silent> gd :OmniSharpGotoDefinition<CR>
autocmd FileType cs nmap <silent> gu :OmniSharpFindUsages<CR>
autocmd FileType cs nmap <silent> gi :OmniSharpFindImplementations<CR>
autocmd FileType cs nmap <silent> gt :OmniSharpDocumentation<CR>
nmap <buffer> <leader>gg :OmniSharpFindUsages<CR>
nnoremap go <c-o>

let g:OmniSharp_typeLookupInPreview = 1
let g:omnicomplete_fetch_full_documentation = 1
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_timeout = 30
let g:OmniSharp_server_path = '/home/arthurgehrke/.cache/omnisharp-vim/omnisharp-roslyn/run'

"*****************************************************************************
" Airline 
"*****************************************************************************
let g:airline_theme = 'onedark'

" enable powerline fonts
let g:airline_powerline_fonts = 1

" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline_highlighting_cache = 1

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

let g:airline_left_sep = ''
let g:airline_right_sep = ''

let g:airline_section_z = ''
" Do not draw separators for empty sections (only for the active window) >
let g:airline_skip_empty_sections = 1

" hide nerdtree status line
let g:airline_filetype_overrides = {
  \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', ''), '' ],
  \ 'list': [ '%y', '%l/%L'],
  \ }
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

