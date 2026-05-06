return {
  'alexpasmantier/tv.nvim',
  lazy = false,
  enabled = true,
  config = function()
    local h = require('tv').handlers

    require('tv').setup({
      channels = {
        files = {
          keybinding = '<C-p>', -- Launch the files channel
          handlers = {
            ['<CR>'] = h.open_as_files, -- default: open selected files
            ['<C-q>'] = h.send_to_quickfix, -- send to quickfix list
            ['<C-s>'] = h.open_in_split, -- open in horizontal split
            ['<C-v>'] = h.open_in_vsplit, -- open in vertical split
            ['<C-y>'] = h.copy_to_clipboard, -- copy paths to clipboard
          },
        },
        text = {
          keybinding = '<leader><leader>',
          handlers = {
            ['<CR>'] = h.open_at_line, -- Jump to line:col in file
            ['<C-q>'] = h.send_to_quickfix, -- Send matches to quickfix
            ['<C-s>'] = h.open_in_split, -- Open in horizontal split
            ['<C-v>'] = h.open_in_vsplit, -- Open in vertical split
            ['<C-y>'] = h.copy_to_clipboard, -- Copy matches to clipboard
          },
        },
      },
    })
  end,
}
