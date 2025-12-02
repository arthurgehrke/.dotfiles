return {
  'eddyekofo94/gruvbox-flat.nvim',
  priority = 1000,
  enabled = false,
  lazy = false,
  config = function()
    vim.cmd([[colorscheme gruvbox-flat]])
  end,
}
