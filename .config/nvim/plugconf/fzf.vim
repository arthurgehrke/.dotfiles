" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_buffers_jump = 1
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_colors = {
  \ 'fg': ['fg', 'Normal'],
  \ 'bg': ['bg', 'Normal'],
  \ 'hl': ['fg', 'Comment'],
  \ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+': ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+': ['fg', 'Statement'],
  \ 'info': ['fg', 'PreProc'],
  \ 'border': ['fg', 'Ignore'],
  \ 'prompt': ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker': ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header': ['fg', 'Comment']
  \ }

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow -g "!{.git,node_modules,*.lock,*-lock.json}/*" 2>/dev/null --glob "!.git/*" --glob "!**/package-lock.json"'
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --theme='gruvbox-dark' --style=header,grid --line-range :300 {}' --bind alt-n:next-history,alt-p:previous-history,ctrl-n:down,ctrl-p:up"
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_files_options = 'bat --color=always --theme=OneHalfDark --style=changes --line-range :300 {}'

autocmd! FileType fzf
autocmd  FileType fzf set noshowmode noruler nonu

function! s:find_git_root()
    return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! -bang -nargs=? -complete=dir Files call fzf#vim#files(s:find_git_root(), fzf#vim#with_preview('right:50%'), <bang>0)

command! -bang -nargs=* RG call fzf#vim#grep("rg --column --line-number --no-heading --hidden -g '!.git/' --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'dir': s:find_git_root()}, 'right:50%'), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always -g "!{*.lock,*-lock.json}" --smart-case %s || true --glob "!.git/*"'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command], 'dir': s:find_git_root()}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

command! -bang -nargs=* RgSimple
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -g "!{*.lock,*-lock.json}" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'dir': s:find_git_root()}, 'up:40%')
  \           : fzf#vim#with_preview({'dir': s:find_git_root()}, 'right:50%:hidden', '?'),
\ <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)l


" Prevent FZF commands from opening in none modifiable buffers
function! FZFOpen(cmd)
    " If more than 1 window, and buffer is not modifiable or file type is
    if winnr('$') > 1 && (!&modifiable || &ft == 'NvimTree' || &ft == 'NvimTreeToggle' || &ft == 'qf')
        " Move one window to the right, then up
        wincmd l
        wincmd k
    endif
    exe a:cmd
endfunction

command! -bang -nargs=* LinesWithPreview
    \ call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --no-heading --color=always --smart-case . '.fnameescape(expand('%')), 1,
    \   fzf#vim#with_preview({'options': '--delimiter : --nth 4.. --no-sort'}, 'down:40%', '?'),
    \   1)
" nnoremap H :LinesWithPreview<CR>

let g:fzf_action = {
  \ 'ctrl-T': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-i': 'vsplit' }

map <C-e> :call FZFOpen(':Buffers')<CR>
nnoremap <silent> <C-p> :call FZFOpen(":Files")<CR>
nnoremap <silent> <space>; :call FZFOpen(":Rg")<CR>
nnoremap <silent> <space>gs :call FZFOpen(':Rg ' . expand('<cword>'))<CR>
nnoremap <silent> <C-f>l :call FZFOpen(':LinesWithPreview')<CR>

" open FZF in current file's directory
nnoremap <silent> <space>_ :Files <C-R>=expand('%:h')<CR><CR>
