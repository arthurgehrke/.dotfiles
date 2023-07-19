lua << EOF
  vim.opt.listchars:append("space:⋅")
  vim.api.nvim_command("let g:indentLine_fileTypeExclude = ['text', 'markdown', 'help']")
  vim.api.nvim_command("let g:indentLine_bufNameExclude = ['STARTIFY', 'NVIMTREE']")
  
  require("indent_blankline").setup {
      char = "|",
      file_type = {"terminal", "nerdtree", "help", "NvimTree"},
      buftype_exclude = {"terminal", "nerdtree", "NvimTree", "neotree", "nvim-tree"},
      indent_blankline_context_patterns = {
        "class",
        "return",
        "function",
        "method",
        "^if",
        "^while",
        "jsx_element",
        "^for",
        "^object",
        "^table",
        "block",
        "arguments",
        "if_statement",
        "else_clause",
        "jsx_element",
        "jsx_self_closing_element",
        "try_statement",
        "catch_clause",
        "import_statement",
        "operation_type",
      },
      indent_blankline_use_treesitter = true,
      indent_blankline_filetype_exclude = {
          "help",
          "startify",
          "dashboard",
          "packer",
          "neogitstatus",
          "NvimTree",
          "Trouble",
      },
      show_end_of_line = true,
      space_char_blankline = " ",
      indentLine_enabled = false
  }
EOF

