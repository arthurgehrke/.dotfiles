syntax on
set termguicolors

" gruvbox
" set termguicolors
" set background=dark
" colorscheme gruvbox
" let g:gruvbox_contrast_dark='hard'

" let g:gruvbox_contrast_dark = 'hard'
" if exists('+termguicolors')
"     let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"     let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" endif
" let g:gruvbox_invert_selection='0'

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
" railscasts (dark):

"---------------------------------------
" palenight (dark):
set background=dark
colorscheme palenight

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif
