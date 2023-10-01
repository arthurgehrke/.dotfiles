
lua << EOF
require("rest-nvim").setup({
  result_split_horizontal = false,
  skip_ssl_verification = false,
  highlight = {
    enabled = true,
    timeout = 150,
  },
  jump_to_request = false,
})
EOF
autocmd FileType http nnoremap <buffer> <space>rr <Plug>RestNvim
autocmd FileType http nnoremap <buffer> <space>rc <Plug>RestNvimPreview
noremap <space>re <plug>RestNvim
nnoremap <space>rp <plug>RestNvimPreview
nnoremap <space>rr <plug>RestNvimLast
command! Http lua require('rest-nvim').run()
nmap <space>hh <Plug>RestNvim
