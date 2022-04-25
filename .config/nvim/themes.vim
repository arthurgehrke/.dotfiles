syntax on
set termguicolors

"---------------------------------------
" gruvbox
" set background=dark
" colorscheme gruvbox

"---------------------------------------
" nord
" set termguicolors
" set background=dark
" colorscheme nord

"---------------------------------------
" onedark
colorscheme onedark
set termguicolors
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif

hi Comment cterm=italic
" let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1

"---------------------------------------
" railscasts (dark):

"---------------------------------------

" palenight (dark):
" set background=dark
" colorscheme palenight

" if (has("nvim"))
"   let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" endif

" if (has("termguicolors"))
"   set termguicolors
" endif
