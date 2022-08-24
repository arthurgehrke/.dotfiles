lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { 'javascript', 'typescript', 'tsx', 'css', 'json' },
  -- ensure_installed = "all", -- or maintained
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
    disable = { "html" },
  },
  indent = { enable = false, disable = { "yaml", "python" } },
  autotag = { enable = false },
  context_commentstring = {
    enable = true
  }
}
EOF

