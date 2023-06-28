function! s:setup_git_messenger_popup() abort
    nmap <buffer><C-o> o
    nmap <buffer><C-i> O
endfunction

autocmd FileType gitmessengerpopup call <SID>setup_git_messenger_popup()

nmap <space>gm <Plug>(git-messenger)

let g:git_messenger_include_diff= "all"
let g:git_messenger_floating_win_opts = { 'border': 'single' }
let g:git_messenger_popup_content_margins = v:false
let g:git_messenger_close_on_cursor_moved = v:false
let g:git_messenger_into_popup_after_show = v:true
let g:git_messenger_always_into_popup = v:true

