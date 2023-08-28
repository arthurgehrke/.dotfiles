" save with :W and :w
cnoreabbrev W w
" quit with :Q and :q
cnoreabbrev Q q

" Open files relative to current path:
nnoremap <space>ed :edit <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <space>sp :split <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <space>vs :vsplit <C-R>=expand("%:p:h") . "/" <CR>

" Ctrl H and L will move to buffer
nnoremap <silent><C-l>   :bnext<CR>
nnoremap <silent><C-h>   :bprevious<CR>

" Edit alternate file with <leader><leader>. See `:help CTRL-^`.
" Note: `:bprevious` is different because it "wraps around".
" nnoremap tt <c-^><CR>
nnoremap <silent> tt <c-^><cr>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <space>ss :call StripWhitespace()<CR>

nnoremap <silent><C-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><C-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>


" Toggle relative line numbers and regular line numbers.
nnoremap <space>tr :set relativenumber!<CR>

" close all buffers but the current one
command! BufOnly execute '%bdelete|edit #|normal `"'

function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  call histadd('/', substitute(@/, '[?/]', '\="\\%d".char2nr(submatch(0))', 'g'))
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>/<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>?<CR>

function SetSearchVisualSelection()
    let clipboard_original_content=@"
    normal gvy " this overwrites clipboard
    let raw_search=@"
    let @/=substitute(escape(raw_search, '\/.*$^~[]'), "\n", '\\n', "g")
    let @"=clipboard_original_content
endfunction
vnoremap ml :call SetSearchVisualSelection()<CR>:set hlsearch<CR> 

nnoremap <silent> ml :<c-u>let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<CR>wb

" Easy window split; C-w v -> vv, C-w - s -> ss
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s
nnoremap <silent> sx :close<CR>
nnoremap <silent> sd :bd<CR>

" " quit quick fix window
" nnoremap <expr> q
"       \ &l:filetype ==# 'qf' ? '<Cmd>cclose<CR>' :
      " \ '$'->winnr() != 1 ? '<Cmd>close<CR>' : ''

" more natural movement with wrap on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" copy current file name (relative/absolute) to system clipboard
if has("mac") || has("gui_macvim") || has("gui_mac")
  " relative path  (src/foo.txt)
  nnoremap <space>cf :let @*=expand("%")<CR>
  " absolute path  (/something/src/foo.txt)
  nnoremap <space>cF :let @*=expand("%:p")<CR>
  " filename       (foo.txt)
  nnoremap <space>ct :let @*=expand("%:t")<CR>
  " directory name (/something/src)
  nnoremap <space>ch :let @*=expand("%:p:h")<CR>
endif


" Convert rows of numbers or text (as if pasted from excel column) to a tuple
function! ToTupleFunction() range
  silent execute a:firstline . "," . a:lastline . "s/^/'/"
  silent execute a:firstline . "," . a:lastline . "s/$/',/"
  silent execute a:firstline . "," . a:lastline . "join"
  silent execute "normal I("
  silent execute "normal $xa)"
  silent execute "normal ggVGYY"
endfunction
command! -range ToTuple <line1>,<line2> call ToTupleFunction()

" Convert rows of numbers or text (as if pasted from excel column) to an array
function! ToArrayFunction() range
  silent execute a:firstline . "," . a:lastline . "s/^/'/"
  silent execute a:firstline . "," . a:lastline . "s/$/',/"
  silent execute a:firstline . "," . a:lastline . "join"
  silent execute "normal I["
  silent execute "normal $xa]"
endfunction
command! -range ToArray <line1>,<line2> call ToArrayFunction()

"Delete all Git conflict markers
"Creates the command :GremoveConflictMarkers
function! RemoveConflictMarkers() range
  echom a:firstline.'-'.a:lastline
  execute a:firstline.','.a:lastline . ' g/^<\{7}\|^|\{7}\|^=\{7}\|^>\{7}/d'
endfunction
"-range=% default is whole file
command! -range=% GremoveConflictMarkers <line1>,<line2>call RemoveConflictMarkers()

func! DeleteBuffers()
    let l:buffers = filter(getbufinfo(), {_, v -> v.hidden})
    if !empty(l:buffers)
        execute 'bwipeout' join(map(l:buffers, {_, v -> v.bufnr}))
    endif
endfunc
command! -bar -bang DeleteBuffers call DeleteBuffers()
