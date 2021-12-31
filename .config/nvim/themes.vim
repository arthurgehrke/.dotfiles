syntax on

" gruvbox
set termguicolors
set background=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'

let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'

"---------------------------------------

" ayu-theme
" set termguicolors     
" let ayucolor="dark"  
" colorscheme ayu

"---------------------------------------

" papercolor
" set background=dark
" colorscheme PaperColor

"---------------------------------------

" nord
" set termguicolors
" set background=dark
" colorscheme nord

"---------------------------------------

" onedark
" if (has("autocmd") && !has("gui_running"))
"   augroup colorset
"     autocmd!
"     let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
"     autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
"   augroup END
" endif

" hi Comment cterm=italic
" " let g:onedark_hide_endofbuffer=1
" let g:onedark_terminal_italics=1
" let g:onedark_termcolors=256

" colorscheme onedark

" checks if your terminal has 24-bit color support
" if (has("termguicolors"))
"     set termguicolors
"     " hi LineNr ctermbg=NONE guibg=NONE
" endif

"---------------------------------------

" deep-space
" set background=dark
" set termguicolors
" colorscheme deep-space
