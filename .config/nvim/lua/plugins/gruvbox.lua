return {
  'ellisonleao/gruvbox.nvim',
  lazy = false,
  priority = 1000,
  -- enabled = false,
  config = function()
    require('gruvbox').setup({
      terminal_colors = false,
      undercurl = true,
      underline = true,
      bold = true,
      italic = { strings = false, operators = false, comments = false, folds = false },
      strikethrough = false,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_indent_guides = false,
      inverse = true,
      contrast = 'soft',
      palette_overrides = {

        bright_yellow = '#c9a554',

        neutral_yellow = '#b69244',

        faded_yellow = '#a8893a',
      },
      overrides = {},
      dim_inactive = false,
      transparent_mode = true,
    })
    vim.cmd.colorscheme('gruvbox')
  end,
}
