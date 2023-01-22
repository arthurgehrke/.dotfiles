lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { 'javascript', 'typescript', 'tsx', 'css', 'json', 'lua' },
  auto_install = true,
  -- ensure_installed = "all", -- or maintained
  highlight = {
    enable = true,
  },
  indent = { enable = false, disable = { "python", "nginx" } },
  autotag = { enable = true },
  context_commentstring = {
    enable = true
  }
}
EOF

