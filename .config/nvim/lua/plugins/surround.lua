return {
  'kylechui/nvim-surround',
  version = '*',
  lazy = false,
  keys = { 'ys', 'cs', 'ds' },
  config = function()
    require('nvim-surround').setup({})
  end,
}
