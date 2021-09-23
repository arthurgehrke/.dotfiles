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
