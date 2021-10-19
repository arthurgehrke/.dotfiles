lua << EOF
  vim.opt.listchars:append("space:⋅")
  vim.api.nvim_command("let g:indentLine_fileTypeExclude = ['text', 'markdown', 'help']")
  vim.api.nvim_command("let g:indentLine_bufNameExclude = ['STARTIFY', 'NVIMTREE']")
  
  require("indent_blankline").setup {
      char = "|",
      file_type = {"terminal", "nerdtree", "help", "NvimTree"},
      buftype_exclude = {"terminal", "nerdtree", "NvimTree"},
      show_end_of_line = true,
      space_char_blankline = " ",
      indentLine_enabled = false
  }
EOF

