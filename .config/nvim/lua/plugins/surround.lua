return {
  'kylechui/nvim-surround',
  version = '*',
  layy = false,
  keys = { 'ys', 'cs', 'ds' },
  config = function()
    require('nvim-surround').setup({})
  end,
}

