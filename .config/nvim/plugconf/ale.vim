nmap <space>af <Plug>(ale_fix)
nmap <space>al <Plug>(ale_lint)
nmap <silent><space>ro :ALEFix<CR>
nmap <silent><space>ri :ALEImport<CR>
nmap <silent><space>ral :ALEOrganizeImports<cr>

" start disabled
let g:ale_enabled = 0
let g:ale_disable_lsp = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters_explicit = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_delay = 100
" let g:ale_lint_delay = 500
let g:ale_sign_error = ''
let g:ale_fix_on_save = 0
let g:ale_completion_autoimport = 1
let g:ale_completion_enabled = 0
let g:ale_sign_column_always = 0
let g:ale_lint_on_save = 0
let g:loaded_ale = 1

let g:ale_javascript_eslint_executable = 'eslint'
let g:ale_javascript_eslint_options = ''
let g:ale_javascript_eslint_suppress_eslintignore = 0
let g:ale_javascript_eslint_use_global = 0

let g:ale_typescript_tsserver_executable = 'tsserver'
let g:ale_typescript_tsserver_use_global = 1
let g:ale_typescript_tslint_use_global = 0
let g:ale_typescript_prettier_use_local_config = 1

let g:ale_linters = {}
let g:ale_fixers = {}

" Other
let g:ale_fixers['*'] = ['remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers.yaml = ['remove_trailing_lines', 'trim_whitespace']

" Javascript / Typescript
let g:ale_linters = {
      \  'html': ['eslint', 'tsserver'],
      \  'typescript': ['tsserver', 'eslint' ],
      \  'javascript': ['eslint', 'standard', 'tsserver' ] ,
      \}
let g:ale_fixers = {
      \ 'javascript': ['prettier', 'prettier-eslint', 'eslint'],
      \ 'typescript': ['prettier', 'prettier-eslint', 'eslint'],
      \ 'json': ['prettier'],
      \ 'css': ['prettier'],
      \ 'scss': ['prettier'],
      \}
