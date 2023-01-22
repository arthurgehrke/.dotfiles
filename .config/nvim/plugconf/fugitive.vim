" let g:fugitive_gitlab_domains = ['git@gitlab.com:doare/api-v2.git']
" let g:gitlab_api_keys = {'gitlab.com': 'glpat-n2TTkV9iue-RbNbYKo_7'}
" let g:fugitive_gitlab_domains = {'git@gitlab.com:doare/api-v2.git': 'https://gitlab.com/doare/api-v2'}

autocmd BufReadPost fugitive://* set bufhidden=delete

" Files with preview
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

augroup FugitiveCustom
    autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END
