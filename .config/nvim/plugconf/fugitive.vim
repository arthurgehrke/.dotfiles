lua << EOF
  vim.g.nvim_tree_disable_netrw = 0
  vim.cmd([[ command! -nargs=1 Browse silent exec '!open "<args>"' ]])

vim.keymap.set("n", "<space>zs", vim.cmd.Git, { desc = "Git Status" })
EOF

command! DiffviewFile execute("DiffviewOpen -- " . expand("%")) | DiffviewToggleFiles

command! -nargs=? PreviousVersion diffthis |
      \ vnew |
      \ set buftype=nofile |
      \ set bufhidden=wipe |
      \ set noswapfile |
      \ execute "r!git show ".(!"<args>"?'head^':"<args>").":".expand('#') |
      \ 1d_ |
      \ let &filetype=getbufvar('#', '&filetype') |
      \ execute 'autocmd BufWipeout <buffer> diffoff!' |
      \ diffthis
