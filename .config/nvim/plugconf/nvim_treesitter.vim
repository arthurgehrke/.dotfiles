lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  auto_install = true,
  -- ensure_installed = "all", -- or maintained
  highlight = {
    enable = true,
  },
  indent = { enable = false, disable = { "python", "nginx" } },
  autotag = { enable = true },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
EOF

