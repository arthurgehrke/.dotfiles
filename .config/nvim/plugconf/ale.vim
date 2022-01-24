" start disabled
let g:ale_enabled = 0

let g:ale_fix_on_save = 0
" let g:ale_lint_on_save = 0

let g:ale_fixers = {
\   'typescript': ['eslint'],
\}

let g:ale_linters = {
\   'typescript': ['eslint'],
\}

let g:ale_linters = {}
let g:ale_linters.typescript = ['eslint', 'tsserver']
let g:ale_linters.javascript = ['eslint']

let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 0 " Disable lint-as-you-type
let g:ale_typescript_tslint_use_global = 0
let g:ale_typescript_tsserver_use_global = 0
let g:ale_typescript_prettier_use_local_config = 1
let g:ale_sign_column_always = 0
let g:ale_completion_enabled = 0
" let g:ale_completion_tsserver_autoimport = 0

let g:ale_linters_explicit = 1

" move between errors
" nmap <silent> <C-n> <Plug>(ale_next_wrap)
" nmap <silent> <C-p> <Plug>(ale_previous_wrap)

" move between linting errors
nmap ]r <Plug>(ale_next_wrap)zz
nmap [r <Plug>(ale_previous_wrap)zz

nnoremap <leader>qf :ALECodeAction<CR>
vnoremap <leader>qf :ALECodeAction<CR>
nnoremap K :ALEHover<CR>
nnoremap <silent> gr :ALEFindReferences<CR>
nnoremap <leader>rn :ALERename<CR>

let mapleader = ' '
function! s:ale_list()
  let g:ale_open_list = 1
  call ale#Queue(0, 'lint_file')
endfunction
command! ALEList call s:ale_list()
nnoremap <leader>m  :ALEList<CR>

function! s:ale_clean()
  let g:ale_open_list = 0
  call ale#Queue(0, 'lint_file')
endfunction
command! ALEClean call s:ale_clean()

nnoremap <leader>ct  :ALEClean<CR>
nnoremap <leader>mt :ALEList<CR>

augroup alegroup
    autocmd!
    autocmd FileType qf nnoremap <silent><buffer> q :let g:ale_open_list=0<CR>:q!<CR>
    autocmd FileType help,qf,man,ref let b:ale_enabled = 0
augroup end
