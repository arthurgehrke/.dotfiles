lua << EOF
require("nvim-autopairs").setup {
    enable_check_bracket_line = false,
    check_ts = true,
    disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
    map_cr = true,
    fast_wrap = {
      map = '<M-e>',
      chars = { '{', '[', '(', '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
      offset = 0, -- Offset from pattern match
      end_key = '$',
      keys = 'qwertyuiopzxcvbnmasdfghjkl',
      check_comma = true,
      highlight = 'PmenuSel',
      highlight_grey = 'LineNr',
    },
  }
EOF
