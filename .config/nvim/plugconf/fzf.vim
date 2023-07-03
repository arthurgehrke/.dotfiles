autocmd! FileType fzf
autocmd  FileType fzf set noshowmode noruler nonu

let g:fzf_buffers_jump = 1
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

" let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow -g "!{.git,node_modules,*.lock,*-lock.json,tmp}/*" 2>/dev/null --glob "!.git/*" --glob "!**/package-lock.json"'
" let $FZF_DEFAULT_OPTS="--reverse --ansi --preview-window 'right:60%' --preview 'bat --color=always --theme='gruvbox-dark' --style=header,grid --line-range :300 {}' --bind ctrl-n:down,ctrl-p:up"
" let g:fzf_layout = { 'down': '~40%' }

function! s:find_git_root()
    return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! -bang -nargs=? -complete=dir Files call fzf#vim#files(s:find_git_root(), fzf#vim#with_preview('right:50%'), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always -g "!{*.lock,*-lock.json}" --smart-case %s || true --glob "!.git/*"'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command], 'dir': s:find_git_root()}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

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

let g:fzf_action = {
  \ 'ctrl-T': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

nnoremap <silent><space>; :Rg<CR>
nnoremap <silent><space>ps :Ag<CR>
nnoremap <silent><C-p> :Files<CR>
nnoremap <silent><space>gs :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> <space>m :History<CR>

command! -bang -nargs=? Buffers
            \ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline','--tiebreak=end']}), <bang>0)

function! FzfExplore(...)
    let inpath = substitute(a:1, "'", '', 'g')
    if inpath == "" || matchend(inpath, '/') == strlen(inpath)
        execute "cd" getcwd() . '/' . inpath
        let cwpath = getcwd() . '/'
        call fzf#run(fzf#wrap(fzf#vim#with_preview({'source': 'ls -1ap', 'dir': cwpath, 'sink': 'FZFExplore', 'options': ['--prompt', cwpath]})))
    else
        let file = getcwd() . '/' . inpath
        execute "e" file
    endif
endfunction

command! -nargs=* FZFExplore call FzfExplore(shellescape(<q-args>))

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

lua << EOF
require('fzf-lua').setup{}
EOF

nnoremap fb :FzfLua buffers<cr>
nnoremap fs :FzfLua live_grep_native<cr>
nnoremap ff :FzfLua files<cr>

