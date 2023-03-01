require("nvim-autopairs").setup {
  active = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },
  enable_check_bracket_line = false,
  check_ts = true,
  -- map_char = {

  -- all = "(",
  -- tex = "{",
  -- },
  disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
  -- map_cr = true,
  -- disable_in_visualblock = true,
  ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
  fast_wrap = {
    map = '<M-e>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
    offset = 0, -- Offset from pattern match
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
  },
}
