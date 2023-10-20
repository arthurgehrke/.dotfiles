lua << EOF
-- Show indent, space, color brackets &
-- Indentation display, showing bracket pair connections.
  local exclude_filetypes = {
    NvimTree = true,
    TelescopePrompt = true,
    [''] = true, -- because TelescopePrompt will set a empty ft, so add this.
    ['neo-tree'] = true,
    aerial = true,
    alpha = true,
    checkhealth = true,
    dashboard = true,
    help = true,
    lazy = true,
    lspinfo = true,
    lspsagafinder = true,
    man = true,
    mason = true,
    packer = true,
    plugin = true,
    toggleterm = true,
    startify = true,
  }
require('hlchunk').setup({
chunk = {
    enable = true,
    use_treesitter = true,
    notify = false, 
    exclude_filetypes = exclude_filetypes,
    support_filetypes = {
      "*.lua",
      "*.js",
      "*.vim",
      "*.ts",
    },
    chars = {
      horizontal_line = "─",
      vertical_line = "│",
      left_top = "╭",
      left_bottom = "╰",
      right_arrow = ">",
    },
    style = {
      { fg = '#3f444a' },
    },
  },
  indent = {
    enable = true,
    use_treesitter = false,
    chars = { "│", "¦", "┆", "┊", },
    style = {
      { fg = '#3f444a' },
    },
    exclude_filetypes = exclude_filetypes,
  },
  context = {
    enable = false,
    exclude_filetypes = exclude_filetypes,
  },
  line_num = {
    enable = false,
    use_treesitter = false,
  },
  blank = {
    enable = false,
    chars = {
      "․",
    },
    exclude_filetypes = {
      aerial = true,
      alpha = true,
      zsh = true,
      tmux = true,
      toml = true,
      dashboard = true,
      NvimTree = true,
    },
    style = {
      vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
    },
  },
})
EOF

