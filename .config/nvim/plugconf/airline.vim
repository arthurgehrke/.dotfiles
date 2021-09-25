let g:airline_theme = 'onedark'
let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0 
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_highlighting_cache = 1

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

let g:airline#extensions#tabline#tabs_label = ''       
let g:airline#extensions#tabline#buffers_label = ''  
"
" disable file paths in the tab 
let g:airline#extensions#tabline#fnamemod = ':t'

" minimum of 2 tabs needed to display the tabline 
let g:airline#extensions#tabline#tab_min_count = 2

let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_splits = 0 
let g:airline#extensions#tabline#show_tab_type = 0  
let g:airline#extensions#tabline#show_tab_nr = 0 

let g:airline#extensions#branch#vcs_checks = ['untracked', 'dirty']
let g:airline#extensions#wordcount#enabled = 0

let g:airline_left_sep = ''
let g:airline_right_sep = ''

let g:airline_section_b = ''
let g:airline_section_z = ''
let g:airline_section_y = ''
" Do not draw separators for empty sections (only for the active window) >
let g:airline_skip_empty_sections = 1

let g:airline_exclude_preview = 0
" hide nerdtree status line
let g:airline_filetype_overrides = {
  \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', ''), '' ],
  \ 'list': [ '%y', '%l/%L'],
  \ }
