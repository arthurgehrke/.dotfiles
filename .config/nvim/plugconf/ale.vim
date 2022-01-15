let g:ale_fixers = {
\   'typescript': ['eslint'],
\}

let g:ale_linters = {}
let g:ale_linters.typescript = ['eslint', 'tsserver']
let g:ale_linters.javascript = ['eslint']
let g:ale_typescript_tsserver_use_global = 0

let g:ale_typescript_prettier_use_local_config = 1
let g:ale_completion_tsserver_autoimport = 0
let g:ale_sign_column_always = 0
let g:ale_completion_enabled = 0

let g:ale_fix_on_save = 0

let g:ale_linters_explicit = 1

nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>
nnoremap <leader>qf :ALECodeAction<CR>
vnoremap <leader>qf :ALECodeAction<CR>
nnoremap K :ALEHover<CR>
nnoremap <silent> gr :ALEFindReferences<CR>
nnoremap <leader>rn :ALERename<CR>

" asyncomplete
" preferred keyboard mappings for navigating autocomplete menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
inoremap <expr> <Esc>   pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"
imap <c-space> <Plug>(asyncomplete_force_refresh)
