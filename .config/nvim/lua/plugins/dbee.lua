return {
  'kndndrj/nvim-dbee',
  lazy = false,
  dependencies = { 'MunifTanjim/nui.nvim' },
  build = function()
    require('dbee').install()
  end,
  config = function()
    require('dbee').setup({
      mappings = {
        {
          action = 'show_result',
          key = '<CR>',
          mode = '',
        },
        {
          action = 'cancel_call',
          key = '<C-c>',
          mode = '',
        },
      },
      disable_help = true,
      window_options = {},
      result = {
        page_size = 100000,
      },
      editor = {
        mappings = {
          { key = '<leader>r', mode = 'v', action = 'run_selection' },
          { key = '<leader>r', mode = 'n', action = 'run_file' },
        },
      },
    })
  end,
  keys = {
    {
      '<leader>dbt',
      function()
        require('dbee').toggle()
      end,
      noremap = true,
      silent = true,
    },
    {
      '<leader>dbo',
      function()
        require('dbee').open()
      end,
      mode = { 'n' },
    },
  },
}
