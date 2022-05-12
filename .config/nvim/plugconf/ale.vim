nnoremap <space>af <Plug>(ale_fix)
nnoremap <space>al <Plug>(ale_lint)
nnoremap <silent><space>ro :ALEFix<CR>
nnoremap <silent><space>rn :ALERename<CR>

" start disabled
let g:ale_enabled = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters_explicit = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_delay = 200
let g:ale_sign_error = '>'
let g:ale_fix_on_save = 0
let g:ale_completion_enabled = 0
let g:ale_sign_column_always = 0

" Set this flag so that other plugins can use it, like airline.
let g:loaded_ale = 1

let g:ale_javascript_eslint_executable = 'eslint'
let g:ale_javascript_eslint_options = ''
let g:ale_javascript_eslint_suppress_eslintignore = 0
let g:ale_javascript_eslint_use_global = 0

" let g:ale_typescript_tsserver_config_path = ''
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
let g:ale_linters.javascript = [
     \ 'eslint',
     \ 'tsserver'
      \ ]

let g:ale_linters.typescript = [
      \ 'eslint',
      \ 'tsserver',
      \ ]

let g:ale_fixers.javascript = [
      \ 'eslint',
      \ 'prettier',
      \ 'prettier-eslint',
      \ ]

let g:ale_fixers.typescript = [
      \ 'eslint',
      \ 'prettier',
      \ 'prettier-eslint',
      \ ]

let g:ale_fixers['typescript.tsx'] = [
      \ 'eslint',
      \ 'prettier',
      \ 'tslint',
      \ ]

let g:ale_fixers['typescriptreact'] = [
      \ 'prettier',
      \ 'tslint',
      \ ]

let g:ale_linters['typescriptreact'] = [
      \ 'tslint',
      \ 'tsserver',
      \ 'typecheck'
      \ ]

let g:ale_json_jq_options = '-S'

"  \ 'jq',
let g:ale_fixers.json = [
      \ 'remove_trailing_lines',
      \ 'trim_whitespace',
      \ 'prettier'
      \ ]

" scss"
let g:ale_fixers.scss = [
      \ 'remove_trailing_lines',
      \ 'trim_whitespace',
      \ 'prettier',
      \ 'stylelint'
      \ ]


" HTML
let g:ale_fixers.html = [
      \ 'prettier',
      \ 'tidy',
      \ ]


