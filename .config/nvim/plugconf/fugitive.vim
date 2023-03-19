nnoremap ]r :%bd<CR>:cnext<CR>:Gdiffsplit master<CR>
nnoremap [r :%bd<CR>:cprevious<CR>:Gdiffsplit master<CR>
nnoremap ]R :%bd<CR>:clast<CR>:Gdiffsplit master<CR>
nnoremap [R :%bd<CR>:cfirst<CR>:Gdiffsplit master<CR>

nnoremap <space>dd :Gdiff<CR>
nnoremap <space>di :Gvdiff<CR>
nnoremap <space>dl :Git log<CR>
