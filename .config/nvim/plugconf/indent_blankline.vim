lua << EOF
 require('ibl').setup({
  indent = {
    char = "|",
    use_treesitter = true,  
    tab_char =  "|",
    space_char_blankline = " ",
    show_current_context = false,
    show_current_context_start = false, 
    show_trailing_blankline_indent = false,
    exclude = { "help", "alpha", "lazy", "mason", 'terminal', 'dashboard' },
    scope = {
      enabled = false,
      show_start = false,
      show_first_indent_level = true,
    },
  }
})
EOF

