lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
  },
  auto_install = true,
  auto_update = true,
  ensure_installed = {
    "markdown",
    "tsx",
    "php",
    "json",
    "tsx",
    "yaml",
    "css",
    "html",
    "lua",
    "typescript",
    "javascript",
    "vim",
    "sql",
    "yaml",
    "vim",
    "gitcommit",
    "dockerfile"
  },
  autotag = {
    -- enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  }
}
EOF
