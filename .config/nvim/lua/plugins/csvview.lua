return {
  {
    'hat0uma/csvview.nvim',
    enabled = false,
    lazy = false,
    opts = {
      parser = { comments = { '#', '//' } },
      keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { 'if', mode = { 'o', 'x' } },
        textobject_field_outer = { 'af', mode = { 'o', 'x' } },
        -- Excel-like navigation:
        -- Use <Tab> and <S-Tab> to move horizontally between fields.
        -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
        -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
        jump_next_field_end = { '<Tab>', mode = { 'n', 'v' } },
        jump_prev_field_end = { '<S-Tab>', mode = { 'n', 'v' } },
        jump_next_row = { '<Enter>', mode = { 'n', 'v' } },
        jump_prev_row = { '<S-Enter>', mode = { 'n', 'v' } },
      },
    },
    cmd = { 'CsvViewEnable', 'CsvViewDisable', 'CsvViewToggle' },
  },
  {
    'emmanueltouzery/decisive.nvim',
    config = function()
      require('decisive').setup({})
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<leader>acsv', function()
        require('decisive').align_csv({})
      end, opts)
      vim.keymap.set('n', '<leader>acsvc', function()
        require('decisive').align_csv_clear({})
      end, opts)
      vim.keymap.set('n', '[c', require('decisive').align_csv_prev_col, opts)
      vim.keymap.set('n', ']c', require('decisive').align_csv_next_col, opts)
    end,
    ft = { 'csv' },
  },
  {
    'cameron-wags/rainbow_csv.nvim',
    config = function()
      require('rainbow_csv').setup()
      -- Disable column notifications
      vim.g.disable_rainbow_hover = 1
    end,
    module = {
      'rainbow_csv',
      'rainbow_csv.fns',
    },
    ft = {
      'csv',
      'tsv',
      'csv_semicolon',
      'csv_whitespace',
      'csv_pipe',
      'rfc_csv',
      'rfc_semicolon',
    },
    cmd = {
      'RainbowDelim',
      'RainbowDelimSimple',
      'RainbowDelimQuoted',
      'RainbowMultiDelim',
    },
  },
}
