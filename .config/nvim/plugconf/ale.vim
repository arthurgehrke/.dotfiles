" npm i -g eslint prettier eslint_d
nmap <space>af <Plug>(ale_fix)
nmap <space>al <Plug>(ale_lint)
nmap <space><space>ro :ALEFix<CR>
nmap <silent><space>ri :ALEImport<CR>
nmap <silent><space>ral :ALEOrganizeImports<cr>
nnoremap <space>ao :ALEOrganizeImports \| sleep 1 \| ALEFix<CR>
nnoremap <space>e mF:%!eslint_d --stdin --fix-to-stdout<CR>`F
" Autofix visual selection with eslint_d:
vnoremap <space>e :!eslint_d --stdin --fix-to-stdout<CR>gv
" Expand %% to directory of current buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_linters = {
  \ 'javascript'      : ['eslint', 'tsserver'],
  \ 'javascriptreact' : ['eslint', 'tsserver'],
  \ 'typescript'      : ['eslint', 'tsserver'],
  \ 'typescriptreact' : ['eslint', 'tsserver']
  \}

let g:ale_fixers = {
  \'typescript': ['eslint'],
  \'javascript': ['eslint'],
  \'javascript.jsx': ['prettier', 'eslint'],
  \'typescriptreact': ['prettier', 'eslint'],
  \'css': ['prettier'],
  \'json': ['prettier'],
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \}

let g:ale_javascript_prettier_use_local_config = 1
" let g:ale_typescript_prettier_use_local_config = 1
let g:ale_default_navigation='vsplit'
let g:ale_linters_explicit = 1  " Do as I say and ONLY as I say
let g:ale_virtualtext_cursor = 'disabled' "controls how ALE will display problems
let g:ale_completion_enabled=0
let g:ale_completion_autoimport = 1
let g:ale_lint_on_filetype_changed=0
let g:ale_sign_error = ''
let g:ale_hover_cursor = 0 " default=1, to show info in echo line
let g:ale_hover_to_preview = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_column_always = 0
let g:ale_set_signs = 0
let g:ale_virtualtext_cursor = 'disabled'

let g:ale_set_highlights = 0
let g:ale_set_balloons = 0
let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 0
let g:ale_sign_info = 0

let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_delay = 100
let g:ale_fix_on_save = 0
let g:ale_lint_on_save = 0
let g:ale_completion_enabled = 0

