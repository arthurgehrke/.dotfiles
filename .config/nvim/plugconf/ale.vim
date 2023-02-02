" npm i -g eslint prettier eslint_d

" nnoremap <leader>tal :ALEToggle<cr>
nmap <space>af <Plug>(ale_fix)
nmap <space>al <Plug>(ale_lint)
nmap <silent><space>ro :ALEFix<CR>
nmap <silent><space>ri :ALEImport<CR>
nmap <silent><space>ral :ALEOrganizeImports<cr>
nnoremap <space>ao :ALEOrganizeImports \| sleep 1 \| ALEFix<CR>

let g:ale_pattern_options = {
\   '.*/node_modules/.*': { 'ale_enabled': 0 },
\ }

let g:ale_linters = {
      \  'html': ['eslint', 'tsserver'],
      \  'typescript': ['eslint', 'tsserver'],
      \  'javascript': [ 'eslint', 'standard', 'tsserver' ] ,
      \}
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'javascript': ['eslint'],
    \ 'typescript': ['eslint']
\}

let g:ale_javascript_prettier_use_local_config = 1
let g:ale_default_navigation='vsplit'
let g:ale_linters_explicit = 1  " Do as I say and ONLY as I say
" let g:ale_completion_enabled=1
let g:ale_virtualtext_cursor = 'disabled' "controls how ALE will display problems
let g:ale_completion_enabled=0
let g:ale_completion_autoimport = 1
let g:ale_lint_on_filetype_changed=0
let g:ale_sign_error = ''
" let g:ale_disable_lsp = 1
let g:ale_hover_cursor = 0 " default=1, to show info in echo line
let g:ale_hover_to_preview = 0
let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 0
" let g:ale_lint_on_enter = 0
" let g:ale_lint_on_save = 0


