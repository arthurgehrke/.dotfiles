return {
  'luukvbaal/nnn.nvim',
  lazy = false,
  keys = {
    {
      '<leader>n',
      function()
        local activeFilePath = vim.api.nvim_buf_get_name(0)
        vim.api.nvim_command(string.format('NnnPicker %s', activeFilePath))
      end,
      mode = { 'n' },
      desc = 'Open NNN',
    },
  },
  config = function()
    local signcolumn_width = 7
    local min_buffer_width = 110 + signcolumn_width
    local total_dual_panel_cols = min_buffer_width * 2 + 1
    local min_sidebar_width = 10
    local max_sidebar_width = 32

    local nnn = require('nnn')
    local builtin = require('nnn').builtin

    local get_sidebar_cols = function()
      local neovim_cols = vim.o.columns
      local sidebar_cols = neovim_cols - min_buffer_width - 1
      if total_dual_panel_cols < (neovim_cols - min_sidebar_width) then
        sidebar_cols = neovim_cols - total_dual_panel_cols - 1
      end
      if sidebar_cols < min_sidebar_width then
        sidebar_cols = min_sidebar_width
      end
      if sidebar_cols > max_sidebar_width then
        sidebar_cols = max_sidebar_width
      end
      return sidebar_cols
    end

    nnn.setup({
      explorer = {
        width = get_sidebar_cols(),
        side = 'topleft',
        tabs = false,
        fullscreen = false,
      },
      mappings = {
        { '<C-t>', builtin.open_in_tab }, -- open file(s) in tab
        { '<C-s>', builtin.open_in_split }, -- open file(s) in split
        { '<C-v>', builtin.open_in_vsplit }, -- open file(s) in vertical split
        { '<C-y>', builtin.copy_to_clipboard }, -- copy file(s) to clipboard
        { '<C-e>', builtin.populate_cmdline }, -- populate cmdline (:) with file(s)
      },
      auto_open = {
        ft_ignore = { 'gitcommit' },
      },
      replace_netrw = 'picker',
      quitcd = 'cd',
    })
  end,
}
